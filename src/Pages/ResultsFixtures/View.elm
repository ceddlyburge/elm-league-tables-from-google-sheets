module Pages.ResultsFixtures.View exposing (page)

-- import Date exposing (..)
-- import Date.Extra exposing (..)
import Time exposing (..)
import Element exposing (..)
import Element.Attributes exposing (..)
import Http exposing (decodeUri)
import LeagueStyleElements exposing (..)
import Models.Game exposing (..)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import RemoteData exposing (WebData)


page : String -> WebData ResultsFixtures -> Responsive -> Page
page leagueTitle response progessive =
    Page
        (DoubleHeader
            (headerBar leagueTitle)
            (SubHeaderBar "Results / Fixtures")
        )
        (maybeResponse response <| fixturesResultsElement progessive)


headerBar : String -> HeaderBar
headerBar leagueTitle =
    HeaderBar
        [ BackHeaderButton <| ShowLeagueTable leagueTitle ]
        (Maybe.withDefault "" <| decodeUri leagueTitle)
        [ RefreshHeaderButton <| RefreshResultsFixtures leagueTitle ]


fixturesResultsElement : Responsive -> ResultsFixtures -> Element Styles variation Msg
fixturesResultsElement responsive resultsFixtures =
    column
        None
        [ class "data-test-dates"
        , width <| percent 100
        , center
        ]
        (List.map (day responsive) resultsFixtures.days)


day : Responsive -> LeagueGamesForDay -> Element Styles variation Msg
day responsive leagueGamesForDay =
    column
        None
        [ padding responsive.mediumGap
        , spacing responsive.mediumGap
        , dayWidth responsive
        , class <| "data-test-day data-test-date-" ++ dateClassNamePart leagueGamesForDay.date
        ]
        [ dayHeader leagueGamesForDay.date
        , dayResultsFixtures responsive leagueGamesForDay
        ]


dayHeader : Maybe Date -> Element Styles variation Msg
dayHeader maybeDate =
    el
        ResultFixtureDayHeader
        [ class "data-test-dayHeader" ]
        (text <| dateDisplay maybeDate)


dayResultsFixtures : Responsive -> LeagueGamesForDay -> Element Styles variation Msg
dayResultsFixtures responsive leagueGamesForDay =
    column
        None
        [ width <| percent 100
        , spacing responsive.smallGap
        ]
        (List.map (gameRow responsive) leagueGamesForDay.games)


gameRow : Responsive -> Game -> Element Styles variation Msg
gameRow responsive game =
    row
        ResultFixtureRow
        [ padding 0
        , spacing responsive.mediumGap
        , center
        , class "data-test-game"
        , width <| percent 100
        ]
        [ column
            ResultFixtureHome
            [ teamWidth responsive ]
            [ paragraph
                ResultFixtureHome
                [ alignRight, class "data-test-homeTeamName" ]
                [ text game.homeTeamName ]
            , paragraph
                ResultFixtureGoals
                [ alignRight, class "data-test-homeTeamGoals" ]
                [ text (String.join ", " (homeTeamGoalsWithRealPlayerNames game)) ]
            ]
        , row
            None
            []
            (scoreSlashTime game)
        , column
            ResultFixtureAway
            [ teamWidth responsive ]
            [ paragraph
                ResultFixtureAway
                [ alignLeft, class "data-test-awayTeamName" ]
                [ text game.awayTeamName ]
            , paragraph
                ResultFixtureGoals
                [ alignLeft, class "data-test-awayTeamGoals" ]
                [ text (String.join ", " (awayTeamGoalsWithRealPlayerNames game)) ]
            ]
        ]


scoreSlashTime : Game -> List (Element Styles variation Msg)
scoreSlashTime game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            [ el
                ResultFixtureScore
                [ alignRight, class "data-test-homeTeamGoalCount" ]
                (text <| String.fromInt homeTeamGoalCount)
            , el
                ResultFixtureScore
                []
                (text " - ")
            , el
                ResultFixtureScore
                [ alignLeft, class "data-test-awayTeamGoalCount" ]
                (text <| String.fromInt awayTeamGoalCount)
            ]

        ( _, _ ) ->
            [ el
                ResultFixtureTime
                [ verticalCenter, class "data-test-datePlayed" ]
                (text <| timeDisplay game.datePlayed)
            ]


dateClassNamePart : Maybe Date -> String
dateClassNamePart maybeDate =
    maybeDate
        |> Maybe.map (Time.Extra.toFormattedString "yyyy-MM-dd")
        |> Maybe.withDefault "unscheduled"


dateDisplay : Maybe Date -> String
dateDisplay maybeDate =
    maybeDate
        |> Maybe.map (Time.Extra.toFormattedString "MMMM d, yyyy")
        |> Maybe.withDefault "Unscheduled"


timeDisplay : Maybe Date -> String
timeDisplay maybeDate =
    maybeDate
        |> Maybe.map (Time.Extra.toFormattedString "HH:mm")
        |> Maybe.withDefault " - "


dayWidth : Responsive -> Element.Attribute variation msg
dayWidth responsive =
    if responsive.designTeamWidthMediumFont * 2.5 < responsive.pageWidth * 0.8 then
        width <| percent 80

    else
        width <| percent 100


teamWidth : Responsive -> Element.Attribute variation msg
teamWidth responsive =
    width <| fillPortion 50
