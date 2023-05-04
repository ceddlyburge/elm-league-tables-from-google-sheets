module Pages.ResultsFixtures.View exposing (page)

import DateFormat
import Element exposing (Element, alignLeft, alignTop, centerX, centerY, column, el, fill, fillPortion, htmlAttribute, padding, paragraph, text, width)
import Element.Font as Font
import Html.Attributes
import Models.Game exposing (Game)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Msg exposing (Msg(..))
import Pages.HeaderBar exposing (HeaderBar, PageHeader(..), SubHeaderBar)
import Pages.HeaderBarItem exposing (HeaderBarItem(..))
import Pages.MaybeResponse exposing (maybeResponse)
import Pages.Page exposing (Page)
import Pages.ViewHelpers exposing (dataTestClass)
import RemoteData exposing (WebData)
import Styles exposing (Styles, elWithStyle, paragraphWithStyle, rowWithStyle)
import Time exposing (Posix, Zone, utc)


page : String -> WebData ResultsFixtures -> Styles -> Page
page leagueTitle response styles =
    Page
        (DoubleHeader
            (headerBar leagueTitle)
            (SubHeaderBar "Results / Fixtures")
        )
        (maybeResponse response (fixturesResultsElement styles) styles)


headerBar : String -> HeaderBar
headerBar leagueTitle =
    HeaderBar
        [ BackHeaderButton <| ShowLeagueTable leagueTitle ]
        leagueTitle
        [ RefreshHeaderButton <| RefreshResultsFixtures leagueTitle ]


fixturesResultsElement : Styles -> ResultsFixtures -> Element Msg
fixturesResultsElement styles resultsFixtures =
    column
        [ dataTestClass "dates"
        , width fill
        , centerX
        ]
        (List.map (day styles) resultsFixtures.days)


day : Styles -> LeagueGamesForDay -> Element Msg
day styles leagueGamesForDay =
    column
        [ styles.mediumPadding
        , styles.mediumSpacing
        , centerX
        , width styles.fillToDesignPortraitWidth
        , htmlAttribute <| Html.Attributes.class <| "data-test-day data-test-date-" ++ dateClassNamePart leagueGamesForDay.date
        ]
        [ dayHeader styles leagueGamesForDay.date
        , dayResultsFixtures styles leagueGamesForDay
        ]


dayHeader : Styles -> Maybe Posix -> Element Msg
dayHeader styles maybeDate =
    elWithStyle
        styles.resultFixtureDayHeader
        [ width fill
        , dataTestClass "dayHeader"
        ]
        (text <| dateDisplay maybeDate)


dayResultsFixtures : Styles -> LeagueGamesForDay -> Element Msg
dayResultsFixtures styles leagueGamesForDay =
    column
        [ width fill
        , styles.smallSpacing
        ]
        (List.map (gameRow styles) leagueGamesForDay.games)


gameRow : Styles -> Game -> Element Msg
gameRow styles game =
    rowWithStyle
        styles.resultFixtureRow
        [ padding 0
        , styles.mediumSpacing
        , centerX
        , dataTestClass "game"
        , width fill
        ]
        [ column
            [ teamWidth
            , alignTop
            ]
            [ paragraph
                [ Font.alignRight, dataTestClass "homeTeamName" ]
                [ text game.homeTeamName ]
            , paragraphWithStyle
                styles.resultFixtureGoals
                [ Font.alignRight
                , dataTestClass "homeTeamGoals"
                ]
                [ text game.homeTeamGoals ]
            ]
        , rowWithStyle
            styles.resultFixtureScore
            [ alignTop ]
            (scoreSlashTime game styles)
        , column
            [ teamWidth
            , alignTop
            ]
            [ paragraph
                [ alignLeft
                , dataTestClass "awayTeamName"
                ]
                [ text game.awayTeamName ]
            , paragraphWithStyle
                styles.resultFixtureGoals
                [ alignLeft
                , dataTestClass "awayTeamGoals"
                ]
                [ text game.awayTeamGoals ]
            ]
        ]


scoreSlashTime : Game -> Styles -> List (Element Msg)
scoreSlashTime game styles =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            [ el
                [ Font.alignRight
                , dataTestClass "homeTeamGoalCount"
                ]
                (text <| String.fromInt homeTeamGoalCount)
            , el
                []
                (text " - ")
            , el
                [ alignLeft
                , dataTestClass "awayTeamGoalCount"
                ]
                (text <| String.fromInt awayTeamGoalCount)
            ]

        _ ->
            [ elWithStyle
                styles.resultFixtureTime
                [ centerY
                , dataTestClass "datePlayed"
                ]
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


teamWidth : Element.Attribute msg
teamWidth =
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
