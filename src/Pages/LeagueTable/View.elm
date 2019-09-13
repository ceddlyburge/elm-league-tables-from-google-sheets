module Pages.LeagueTable.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueTable exposing (LeagueTable)
import Models.Team exposing (..)
import Pages.Responsive exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..) 
import Pages.HeaderBarItem exposing (..)
import Pages.ResponsiveColumn exposing (..)


page : String -> WebData LeagueTable -> Responsive -> Bool -> Page
page leagueTitle response responsive namedPlayerDataAvailable =
    Page
        ( SingleHeader <| 
            HeaderBar 
                [ BackHeaderButton ShowLeagueList
                , ResultsFixturesHeaderButton <| ShowResultsFixtures leagueTitle
                , TopScorersHeaderButton (ShowTopScorers leagueTitle) namedPlayerDataAvailable ] 
                (Maybe.withDefault "" (decodeUri leagueTitle))
                [ RefreshHeaderButton <| RefreshLeagueTable leagueTitle ] )
        ( maybeResponse response (leagueTableElement responsive) )


leagueTableElement : Responsive -> LeagueTable -> Element Styles Variations Msg
leagueTableElement responsive leagueTable =
    let
        columns = respondedColumns 
            responsive.pageWidth 
            responsive.mediumGap 
            responsive.smallGap  
            (allColumns responsive.pageWidth)
    in
        column None [ class "data-test-teams" ]
        (
            [ headerRow columns responsive ]
            ++ 
            (List.map (teamRow columns responsive) leagueTable.teams)
        )

headerRow : List Column -> Responsive -> Element Styles Variations Msg
headerRow tableColumns responsive = 
    row 
        LeagueTableHeaderRow 
        [ padding responsive.mediumGap, spacing responsive.smallGap, center ] 
        (List.map headerCell tableColumns)

headerCell : Column -> Element Styles Variations Msg
headerCell column =
    column.element 
        None 
        [ width (px column.width), class column.cssClass ] 
        (text column.title)

teamRow : List Column -> Responsive -> Team -> Element Styles Variations Msg
teamRow tableColumns responsive team = 
    row 
        LeagueTableTeamRow 
        [ padding responsive.mediumGap, spacing responsive.smallGap, center, class "data-test-team" ] 
        (List.map (teamCell team) tableColumns)

teamCell : Team -> Column -> Element Styles Variations Msg
teamCell team column=
    column.element 
        None 
        [ width (px column.width), class column.cssClass ] 
        (text <| column.value team)

-- Pixel widths, with one character spare, measured using https://codepen.io/jasesmith/pen/eBeoNz
allColumns : Float -> List Column
allColumns viewportWidth =
    if viewportWidth <= 600 then
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
    else if viewportWidth <= 1200 then
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
    else if viewportWidth <= 1800 then
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

-- the type signature for these is extremely onerous, and I haven't found a 
-- way of making it better, so I'm just leaving them out for now.
position = 
    Column Models.Team.position "data-test-position"

team = 
    Column Models.Team.name "data-test-name"

played = 
    Column Models.Team.gamesPlayed "data-test-gamesPlayed"

won = 
    Column Models.Team.won "data-test-won"

drawn =
    Column Models.Team.drawn "data-test-drawn"

lost =
    Column Models.Team.lost "data-test-lost"

goalsFor =
    Column Models.Team.goalsFor "data-test-goalsFor"

goalsAgainst =
    Column Models.Team.goalsAgainst "data-test-goalsAgainst"

goalDifference =
    Column Models.Team.goalDifference "data-test-goalDifference"

points =
    Column Models.Team.points "data-test-points"
