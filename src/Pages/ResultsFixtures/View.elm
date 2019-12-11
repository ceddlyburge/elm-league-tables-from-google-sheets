module Pages.ResultsFixtures.View exposing (page)

import Time exposing (..)
import Element exposing (..)
import Html.Attributes exposing (class)
import DateFormat
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
import Pages.ViewHelpers exposing (..)
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
        leagueTitle
        [ RefreshHeaderButton <| RefreshResultsFixtures leagueTitle ]


fixturesResultsElement : Responsive -> ResultsFixtures -> Element msg
fixturesResultsElement responsive resultsFixtures =
    column
        --None
        [ dataTestClass "dates"
        , width <| fill
        , centerX --center
        ]
        (List.map (day responsive) resultsFixtures.days)


day : Responsive -> LeagueGamesForDay -> Element msg
day responsive leagueGamesForDay =
    column
        --None
        [ padding responsive.mediumGap
        , spacing responsive.mediumGap
        , dayWidth responsive
        , htmlAttribute <| Html.Attributes.class <| "data-test-day data-test-date-" ++ dateClassNamePart leagueGamesForDay.date
        ]
        [ dayHeader leagueGamesForDay.date
        , dayResultsFixtures responsive leagueGamesForDay
        ]


dayHeader : Maybe Posix -> Element msg
dayHeader maybeDate =
    el
        --ResultFixtureDayHeader
        [ dataTestClass "dayHeader" ]
        (text <| dateDisplay maybeDate)


dayResultsFixtures : Responsive -> LeagueGamesForDay -> Element msg
dayResultsFixtures responsive leagueGamesForDay =
    column
        --None
        [ width fill
        , spacing responsive.smallGap
        ]
        (List.map (gameRow responsive) leagueGamesForDay.games)


gameRow : Responsive -> Game -> Element msg
gameRow responsive game =
    row
        --ResultFixtureRow
        [ padding 0
        , spacing responsive.mediumGap
        , centerX --center
        , dataTestClass "game"
        , width fill
        ]
        [ column
            --ResultFixtureHome
            [ teamWidth responsive ]
            [ paragraph
                --ResultFixtureHome
                [ alignRight, dataTestClass "homeTeamName" ]
                [ text game.homeTeamName ]
            , paragraph
                --ResultFixtureGoals
                [ alignRight, dataTestClass "homeTeamGoals" ]
                [ text (String.join ", " (homeTeamGoalsWithRealPlayerNames game)) ]
            ]
        , row
            --None
            []
            (scoreSlashTime game)
        , column
            --ResultFixtureAway
            [ teamWidth responsive ]
            [ paragraph
                --ResultFixtureAway
                [ alignLeft, dataTestClass "awayTeamName" ]
                [ text game.awayTeamName ]
            , paragraph
                --ResultFixtureGoals
                [ alignLeft, dataTestClass "awayTeamGoals" ]
                [ text (String.join ", " (awayTeamGoalsWithRealPlayerNames game)) ]
            ]
        ]


scoreSlashTime : Game -> List (Element msg)
scoreSlashTime game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            [ el
                --ResultFixtureScore
                [ alignRight, dataTestClass "homeTeamGoalCount" ]
                (text <| String.fromInt homeTeamGoalCount)
            , el
                --ResultFixtureScore
                []
                (text " - ")
            , el
                --ResultFixtureScore
                [ alignLeft, dataTestClass "awayTeamGoalCount" ]
                (text <| String.fromInt awayTeamGoalCount)
            ]

        ( _, _ ) ->
            [ el
                --ResultFixtureTime
                [ centerY --verticalCenter
                , dataTestClass "datePlayed" ]
                (text <| timeDisplay game.datePlayed)
            ]


dateClassNamePart : Maybe Posix -> String
dateClassNamePart maybeDate =
    maybeDate
        |> Maybe.map (dateFormatter utc)
        |> Maybe.withDefault "unscheduled"


dateDisplay : Maybe Posix -> String
dateDisplay maybeDate =
    maybeDate
        |> Maybe.map (dayFormatter utc)
        |> Maybe.withDefault "Unscheduled"


timeDisplay : Maybe Posix -> String
timeDisplay maybeDate =
    maybeDate
        |> Maybe.map (timeFormatter utc)
        |> Maybe.withDefault " - "


dayWidth : Responsive -> Element.Attribute msg
dayWidth responsive =
    if toFloat responsive.designTeamWidthMediumFont * 2.5 < (toFloat responsive.pageWidth) * 0.8 then
        width <| fillPortion 80

    else
        width fill


teamWidth : Responsive -> Element.Attribute msg
teamWidth responsive =
    width <| fillPortion 50


dateFormatter : Zone -> Posix -> String
dateFormatter =
    DateFormat.format
        [ DateFormat.yearNumber
        , DateFormat.text "-"
        , DateFormat.monthFixed
        , DateFormat.text "-"
        , DateFormat.dayOfMonthFixed
        ]

dayFormatter : Zone -> Posix -> String
dayFormatter =
    DateFormat.format
        [ DateFormat.monthNameFull
        , DateFormat.text " "
        , DateFormat.dayOfMonthSuffix
        , DateFormat.text ", "
        , DateFormat.yearNumber
        ]

timeFormatter : Zone -> Posix -> String
timeFormatter =
    DateFormat.format
        [ DateFormat.hourFixed
        , DateFormat.text ":"
        , DateFormat.minuteFixed
        ]