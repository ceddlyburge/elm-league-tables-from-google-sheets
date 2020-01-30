module Pages.LeagueTable.View exposing (page)

import Element exposing (..)
import Html.Attributes exposing (..)
import Styles exposing (..)
import Models.League exposing (League)
import Models.LeagueTable exposing (LeagueTable)
import Models.Team exposing (..)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import Pages.ResponsiveColumn exposing (..)
import Pages.ViewHelpers exposing (..)
import RemoteData exposing (WebData)


page : String -> WebData League -> Styles -> Page
page leagueTitle response styles =
    Page
        (SingleHeader <|
            HeaderBar
                [ BackHeaderButton ShowLeagueList
                , ResultsFixturesHeaderButton <| ShowResultsFixtures leagueTitle
                , TopScorersHeaderButton (ShowTopScorers leagueTitle) (namedPlayerDataAvailable response)
                ]
                leagueTitle
                [ RefreshHeaderButton <| RefreshLeagueTable leagueTitle ]
        )
        (maybeResponse (RemoteData.map .table response) (leagueTableElement styles) styles)


namedPlayerDataAvailable : WebData League -> Bool
namedPlayerDataAvailable leagueResponse =
    RemoteData.map (\l -> l.players.namedPlayerDataAvailable) leagueResponse
        |> RemoteData.toMaybe
        |> Maybe.withDefault False


leagueTableElement : Styles -> LeagueTable -> Element Msg
leagueTableElement styles leagueTable =
    let
        columns =
            respondedColumns
                styles.responsive.pageWidth
                styles.responsive.mediumGap
                styles.responsive.smallGap
                (allColumns styles.responsive.pageWidth)
    in
    column
        [ dataTestClass "teams", centerX ]
        (   headerRow columns styles
            :: List.map (teamRow columns styles) leagueTable.teams
        )


headerRow : List Pages.ResponsiveColumn.Column -> Styles -> Element Msg
headerRow tableColumns styles =
    rowWithStyle
        styles.leagueTableHeaderRow
        [ styles.mediumPadding
        , styles.smallSpacing ]
        (List.map headerCell tableColumns)


headerCell : Pages.ResponsiveColumn.Column -> Element Msg
headerCell column =
    column.element
        [ Element.width (px column.width)
        , htmlAttribute (class column.cssClass) ]
        (text column.title)


teamRow : List Pages.ResponsiveColumn.Column -> Styles -> Team -> Element Msg
teamRow tableColumns styles aTeam =
    rowWithStyle
        styles.leagueTableTeamRow
        [ styles.mediumPadding
        , styles.smallSpacing
        , dataTestClass "team" ]
        (List.map (teamCell aTeam) tableColumns)


teamCell : Team -> Pages.ResponsiveColumn.Column -> Element Msg
teamCell aTeam column =
    column.element
        [ Element.width (px column.width)
        , htmlAttribute <| class column.cssClass ]
        (text <| column.value aTeam)



-- Pixel widths, with one character spare, measured using https://codepen.io/jasesmith/pen/eBeoNz


allColumns : Int -> List Pages.ResponsiveColumn.Column
allColumns viewportWidth =
    if viewportWidth <= 600 then
        -- 12px font (font size is from LeagueStyleElements)
        [ position el "" 21 8
        , team multiline "Team" 100 9
        , played el "P" 21 6
        , won el "W" 21 1
        , drawn el "D" 21 1
        , lost el "L" 21 1
        , goalsFor el "GF" 21 0
        , goalsAgainst el "GA" 21 0
        , goalDifference el "GD" 21 5
        , points el "Pts" 26 7
        ]

    else if viewportWidth <= 1200 then
        -- 15px font (from LeagueStyleElements)
        [ position el "" 26 8
        , team multiline "Team" 150 9
        , played el "Played" 57 6
        , won el "Won" 41 1
        , drawn el "Drawn" 56 1
        , lost el "Lost" 41 1
        , goalsFor multiline "Goals For" 49 0
        , goalsAgainst multiline "Goals Against" 65 0
        , goalDifference multiline "Goal Difference" 83 5
        , points el "Points" 53 7
        ]

    else if viewportWidth <= 1800 then
        -- 18px font (from LeagueStyleElements)
        [ position el "" 31 8
        , team multiline "Team" 200 9
        , played el "Played" 69 6
        , won el "Won" 49 1
        , drawn el "Drawn" 68 1
        , lost el "Lost" 49 1
        , goalsFor multiline "Goals For" 59 0
        , goalsAgainst multiline "Goals Against" 78 0
        , goalDifference multiline "Goal Difference" 99 5
        , points el "Points" 63 7
        ]

    else
        -- 24px font (from LeagueStyleElements)
        [ position el "" 41 8
        , team multiline "Team" 300 9
        , played el "Played" 92 6
        , won el "Won" 66 1
        , drawn el "Drawn" 90 1
        , lost el "Lost" 65 1
        , goalsFor multiline "Goals For" 79 0
        , goalsAgainst multiline "Goals Against" 104 0
        , goalDifference multiline "Goal Difference" 132 5
        , points el "Points" 85 7
        ]



-- the type signature for these is extremely onerous, and I haven't found a
-- way of making it better, so I'm just leaving them out for now.


position =
    Pages.ResponsiveColumn.Column Models.Team.position "data-test-position"


team =
    Pages.ResponsiveColumn.Column Models.Team.name "data-test-name"


played =
    Pages.ResponsiveColumn.Column Models.Team.gamesPlayed "data-test-gamesPlayed"


won =
    Pages.ResponsiveColumn.Column Models.Team.won "data-test-won"


drawn =
    Pages.ResponsiveColumn.Column Models.Team.drawn "data-test-drawn"


lost =
    Pages.ResponsiveColumn.Column Models.Team.lost "data-test-lost"


goalsFor =
    Pages.ResponsiveColumn.Column Models.Team.goalsFor "data-test-goalsFor"


goalsAgainst =
    Pages.ResponsiveColumn.Column Models.Team.goalsAgainst "data-test-goalsAgainst"


goalDifference =
    Pages.ResponsiveColumn.Column Models.Team.goalDifference "data-test-goalDifference"


points =
    Pages.ResponsiveColumn.Column Models.Team.points "data-test-points"
