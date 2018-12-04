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
    { value: Team -> String
    , cssClass: String
    , element : Styles -> List (Element.Attribute Variations Msg) -> Element.Element Styles Variations Msg -> Element.Element Styles Variations Msg
    , title: String
    , width: Int -- make this a float, I think it would make things easier, although might still be the odd annoyance.
    , priority : Int
    }

multiline: Styles -> List (Element.Attribute Variations Msg) -> Element.Element Styles Variations Msg -> Element.Element Styles Variations Msg
multiline styles attributes element =
    paragraph styles attributes [element]

-- Pixel widths, with one character spare, measured using https://codepen.io/jasesmith/pen/eBeoNz
allColumns : Device -> List Column
allColumns device =
    if device.width <= 600 then
        -- 12px font (font size is from LeagueStyleElements)
        [     position       el        ""     21  8
            , team           multiline "Team" 100 9
            , played         el        "P"    21  6
            , won            el        "W"    21  1
            , drawn          el        "D"    21  1
            , lost           el        "L"    21  1
            , goalsFor       el        "GF"   21  0
            , goalsAgainst   el        "GA"   21  0 
            , goalDifference el        "GD"   21  5
            , points         el        "Pts"  26  7
        ]
    else if device.width <= 1200 then
        -- 15px font (from LeagueStyleElements)
        [     position       el        ""                26  8
            , team           multiline "Team"            150 9
            , played         el        "Played"          57  6
            , won            el        "Won"             41  1
            , drawn          el        "Drawn"           56  1
            , lost           el        "Lost"            41  1
            , goalsFor       multiline "Goals For"       49  0
            , goalsAgainst   multiline "Goals Against"   65  0 
            , goalDifference multiline "Goal Difference" 83  5
            , points         el        "Points"          53  7
        ]
    else if device.width <= 1800 then
        -- 18px font (from LeagueStyleElements)
        [     position       el        ""                31  8
            , team           multiline "Team"            200 9
            , played         el        "Played"          69  6
            , won            el        "Won"             49  1
            , drawn          el        "Drawn"           68  1
            , lost           el        "Lost"            49  1
            , goalsFor       multiline "Goals For"       59  0
            , goalsAgainst   multiline "Goals Against"   78  0 
            , goalDifference multiline "Goal Difference" 99  5
            , points         el        "Points"          63  7
        ]
    else 
        -- 24px font (from LeagueStyleElements)
        [     position       el        ""                41  8
            , team           multiline "Team"            300 9
            , played         el        "Played"          92  6
            , won            el        "Won"             66  1
            , drawn          el        "Drawn"           90  1
            , lost           el        "Lost"            65  1
            , goalsFor       multiline "Goals For"       79  0
            , goalsAgainst   multiline "Goals Against"   104 0 
            , goalDifference multiline "Goal Difference" 132 5
            , points         el        "Points"          85  7
        ]

position = 
    Column Models.Team.position "position"

team = 
    Column Models.Team.name "name"

played = 
    Column Models.Team.gamesPlayed "gamesPlayed"

won = 
    Column Models.Team.won "won"

drawn =
    Column Models.Team.drawn "drawn"

lost =
    Column Models.Team.lost "lost"

goalsFor =
    Column Models.Team.goalsFor "goalsFor"

goalsAgainst =
    Column Models.Team.goalsAgainst "goalsAgainst"

goalDifference =
    Column Models.Team.goalDifference "goalDifference"

points =
    Column Models.Team.points "points"

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


leagueTableElement : Device -> LeagueTable -> Element Styles Variations Msg
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

headerRow : List Column -> Device -> Gaps -> Element Styles Variations Msg
headerRow tableColumns device gaps = 
    row 
        LeagueTableHeaderRow 
        [ padding gaps.medium, spacing gaps.small, center ] 
        (List.map headerCell tableColumns)

headerCell : Column -> Element Styles Variations Msg
headerCell column =
    column.element 
        None 
        [ width (px (toFloat column.width)), class column.cssClass ] 
        (text column.title)

teamRow : List Column -> Device -> Gaps -> Team -> Element Styles Variations Msg
teamRow tableColumns device gaps team = 
    row 
        LeagueTableTeamRow 
        [ padding gaps.medium, spacing gaps.small, center, class "team" ] 
        (List.map (teamCell team) tableColumns)

teamCell : Team -> Column -> Element Styles Variations Msg
teamCell team column=
    column.element 
        None 
        [ width (px (toFloat column.width)), class column.cssClass ] 
        (text <| column.value team)
