module Pages.LeagueTable.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueTable exposing (LeagueTable)
import Models.Team exposing (..)
import Pages.Gaps exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..) 
import Pages.HeaderBarItem exposing (..)

-- maybe split out column to its own file, might well be useful elsewhere
type alias Column =
    { title: String
        , value: Team -> String
        , width: Int -- make this a float, I think it would make things easier, although might still be the odd annoyance.
        , priority : Int
    }

-- the biggest small width thing is "Played" in the full titles, or "P" in the condensed titles
-- LeagueTableTeamRow defines small font size, which is 12, 15, 18 or 24 points
-- width of played in this font size for font (plus a bit) is roughly  56px, 65px, 85px, 115 px  
allColumns : Device -> List Column
allColumns device =
    -- "Pts" is 25px in 12pt font (font size is from LeagueStyleElements)
    if device.width <= 600 then
        []
        -- [     Column ""     position       (px 30) 
        --     , Column "Team" name           fill 
        --     , Column "P"    gamesPlayed    (px 30) 
        --     , Column "W"    won            (px 30) 
        --     , Column "D"    drawn          (px 30) 
        --     , Column "L"    lost           (px 30) 
        --     , Column "GD"   goalDifference (px 30) 
        --     , Column "Pts"  points         (px 30) 
        -- ]
    else if device.width <= 1200 then
        columns600To1200px device.width
    else if device.width <= 1800 then
        []
        -- [     Column ""                position       (px 80) 
        --     , Column "Team"            name           (px 200) 
        --     , Column "Played"          gamesPlayed    (px 80) 
        --     , Column "Won"             won            (px 80) 
        --     , Column "Drawn"           drawn          (px 80) 
        --     , Column "Lost"            lost           (px 80) 
        --     , Column "Goals For"       goalsFor       (px 80) 
        --     , Column "Goals Against"   goalsAgainst   (px 80) 
        --     , Column "Goal Difference" goalDifference (px 120) 
        --     , Column "Points"          points         (px 80) 
        -- ]
    else 
        []
        -- [     Column ""                position       (px 120) 
        --     , Column "Team"            name           (px 300) 
        --     , Column "Played"          gamesPlayed    (px 120) 
        --     , Column "Won"             won            (px 120) 
        --     , Column "Drawn"           drawn          (px 120) 
        --     , Column "Lost"            lost           (px 120) 
        --     , Column "Goals For"       goalsFor       (px 120) 
        --     , Column "Goals Against"   goalsAgainst   (px 120) 
        --     , Column "Goal Difference" goalDifference (px 180) 
        --     , Column "Points"          points         (px 120) 
        -- ]

-- 15pt font (from LeagueStyleElements)
-- Pixel widths, with one character spare
-- (Postion)  35
-- Team       65 (team name should be bigger though so probably 115 at least)
-- Played     77 
-- Won        55
-- Drawn      75
-- Lost       54
-- Goals      66
-- Against    87
-- Difference 110
-- Points     70
-- total      694 (but this is with team name too small, so probably 744 at least)
columns600To1200px: Int -> List Column
columns600To1200px width =
    [     Column ""                position       35  8
        , Column "Team"            name           165 9
        , Column "Played"          gamesPlayed    77  6
        , Column "Won"             won            55  1
        , Column "Drawn"           drawn          75  1
        , Column "Lost"            lost           54  1
        , Column "Goals For"       goalsFor       66  0
        , Column "Goals Against"   goalsAgainst   87  0
        , Column "Goal Difference" goalDifference 110 5
        , Column "Points"          points         70  7
    ]

-- this will remove items from the top of the list, which is not what I want
-- can't really sort, as then the ui order goes wrong
-- could filter probably. yep use filter. and probably map then max to get the priority
columnsAvailableForWidth: Int -> Int -> Int -> List Column -> List Column
columnsAvailableForWidth width padding spacing columns =
    let
        lowestPriority = Maybe.withDefault 0 (List.minimum (List.map (\column -> column.priority) columns))
    in
        if  columnsWidth padding spacing columns <= width then
            columns
        else
            columnsAvailableForWidth width padding spacing (List.filter (\column -> not (column.priority == lowestPriority)) columns)

columnsWidth : Int -> Int -> List Column -> Int
columnsWidth padding spacing columns =
    (List.foldr (\column total -> total + column.width) 0 columns)
    + padding + padding + ((List.length columns) * spacing)

-- split out a padColumn function
padColumns: Int -> Int -> Int -> List Column -> List Column
padColumns width padding spacing columns  = 
    let
        numberOfColumns = List.length columns
        allColumnsWidth = columnsWidth padding spacing columns
        availableWidth = width - padding - padding - (numberOfColumns * spacing)
        desiredWidth = round ((toFloat availableWidth) * 0.8)
    in
        if allColumnsWidth < desiredWidth then
            List.map (\column -> { column | width = column.width + round( (toFloat (desiredWidth - allColumnsWidth)) / toFloat numberOfColumns )}) columns 
        else
            columns

page : String -> WebData LeagueTable -> Device -> Page
page leagueTitle response device =
    Page
        ( SingleHeader <| 
            HeaderBar 
                [ BackHeaderButton AllSheetSummaryRequest
                , ResultsFixturesHeaderButton <| IndividualSheetRequestForResultsFixtures leagueTitle ] 
                (Maybe.withDefault "" (decodeUri leagueTitle))
                [ RefreshHeaderButton <| IndividualSheetRequest leagueTitle ] )
        ( maybeResponse response (leagueTableElement device) )


leagueTableElement : Device -> LeagueTable -> Element Styles variation Msg
leagueTableElement device leagueTable =
    let
        gaps = gapsForDevice device
        columns = 
            allColumns device 
            |> columnsAvailableForWidth device.width (round gaps.medium) (round gaps.small) 
            |> padColumns device.width (round gaps.medium) (round gaps.small)
    in
        column None [ class "teams" ]
        (
            [ headerRow columns device gaps ]
            ++ 
            (List.map (teamRow columns device gaps) leagueTable.teams)
        )

headerRow : List Column -> Device -> Gaps -> Element Styles variation Msg
headerRow tableColumns device gaps = 
    row 
        LeagueTableHeaderRow 
        [ padding gaps.medium, spacing gaps.small, center ] 
        (List.map headerCell tableColumns)

headerCell : Column -> Element Styles variation Msg
headerCell column =
    el 
        None 
        [ width (px (toFloat column.width)), class "need to do this: cssClass" ] 
        (text column.title)

teamRow : List Column -> Device -> Gaps -> Team -> Element Styles variation Msg
teamRow tableColumns device gaps team = 
    row 
        LeagueTableTeamRow 
        [ padding gaps.medium, spacing gaps.small, center, class "team" ] 
        (List.map (teamCell team) tableColumns)

teamCell : Team -> Column -> Element Styles variation Msg
teamCell team column=
    el 
        None 
        [ width (px (toFloat column.width)), class "need to do this: cssClass" ] 
        (text <| column.value team)

-- type alias LeagueTableHeaderText = 
--     { position: String
--         , team: String
--         , played: String
--         , won: String
--         , drawn: String
--         , lost: String
--         , goalsFor: String
--         , goalsAgainst: String
--         , goalDifference: String
--         , points: String
--     }

-- headerRow2 : Device -> Gaps -> Element Styles variation Msg
-- headerRow2 device gaps = 
--     let
--         headers = headerText device
--     in
--         row LeagueTableHeaderRow [ padding gaps.medium, spacing gaps.small, center ] 
--         [
--             small device "" headers.position
--             , big device "" headers.team
--             , small device "" headers.played
--             , small device "" headers.won
--             , small device "" headers.drawn
--             , small device "" headers.lost
--             , smallWithWrap device "" headers.goalsFor
--             , smallWithWrap device "" headers.goalsAgainst
--             , mediumWithWrap device "" headers.goalDifference
--             , small device "" headers.points
--         ]


-- teamRow2 : Device -> Gaps -> Team -> Element Styles variation Msg
-- teamRow2 device gaps team = 
--     row LeagueTableTeamRow [ padding gaps.medium, spacing gaps.small, center, class "team" ] 
--     [ 
--         small device "" "0"  -- team.position
--         , bigWithWrap device "name" team.name
--         , small device "gamesPlayed" (toString team.gamesPlayed)
--         , small device "" "0" -- headers.won
--         , small device "" "0" -- headers.drawn
--         , small device "" "0" -- headers.lost
--         , small device "goalsFor" (toString team.goalsFor)
--         , small device "goalsAgainst" (toString team.goalsAgainst)
--         , medium device "goalDifference" (toString team.goalDifference)
--         , small device "points" (toString team.points)
--     ]

-- small: Device -> String -> String -> Element Styles variation Msg
-- small  device cssClass cellContents = 
--     el None [ smallWidth device, class cssClass ] (text cellContents)

-- smallWithWrap: Device -> String -> String -> Element Styles variation Msg
-- smallWithWrap  device cssClass cellContents = 
--     paragraph None [ smallWidth device, class cssClass ] [text cellContents]

-- medium: Device -> String -> String -> Element Styles variation Msg
-- medium device cssClass cellContents = 
--     el None [ mediumWidth device, class cssClass ] (text cellContents)

-- mediumWithWrap: Device -> String -> String -> Element Styles variation Msg
-- mediumWithWrap  device cssClass cellContents = 
--     paragraph None [ mediumWidth device, class cssClass ] [text cellContents]

-- big: Device -> String -> String -> Element Styles variation Msg
-- big device cssClass cellContents = 
--     el None [ bigWidth device, class cssClass ] (text cellContents)

-- bigWithWrap: Device -> String -> String -> Element Styles variation Msg
-- bigWithWrap  device cssClass cellContents = 
--     paragraph None [ bigWidth device, class cssClass ] [text cellContents]

-- headerText: Device -> LeagueTableHeaderText
-- headerText device = 
--     if device.width < 600 then
--         LeagueTableHeaderText
--             ""
--             "Team"
--             "P"
--             "W"
--             "D"
--             "L"
--             ""
--             ""
--             "GD"
--             "Pts"
--     else
--         LeagueTableHeaderText
--             ""
--             "Team"
--             "Played"
--             "Won"
--             "Drawn"
--             "Lost"
--             "Goals For"
--             "Goals Against"
--             "Goal Difference"
--             "Points"

-- the biggest small width thing is "Played" in the full titles, or "P" in the condensed titles
-- LeagueTableTeamRow defines small font size, which is 12, 15, 18 or 24 points
-- width of played in this font size for font (plus a bit) is roughly  56px, 65px, 85px, 115 px  
-- smallWidth: Device -> Element.Attribute variation msg
-- smallWidth device = 
--     if device.phone then
--         width (px 20)
--     else
--         width (px 80)

-- the biggest medium width thing is "Difference" in the full titles, assuming that "Goals Difference" wraps, or "Pts" in the condensed titles
-- LeagueTableTeamRow defines small font size, which is 12, 15, 18 or 24 points
-- width of played in this font size for font (plus a bit) is roughly  70px, 105px, 125px, 170px  
-- mediumWidth: Device -> Element.Attribute variation msg
-- mediumWidth device = 
--     if device.phone then
--         width (px 20)
--     else
--         width (px 120)

-- big width is for the team name, which could be anything, but can wrap. Let's say "Meridian X" should definitely be on one line
-- LeagueTableTeamRow defines small font size, which is 12, 15, 18 or 24 points
-- width of played in this font size for font (plus a bit) is roughly  95px, 120px, 145px, 195px  
-- bigWidth: Device -> Element.Attribute variation msg
-- bigWidth device = 
--     if device.phone then
--         width fill
--     else
--         width (px 200)
