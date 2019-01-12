module Pages.ResultsFixtures.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import Date exposing (..)
import Date.Extra exposing (..)
import Pages.Responsive exposing (..)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.Game exposing (Game)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..) 
import Pages.HeaderBarItem exposing (..)


page : String -> WebData ResultsFixtures -> Responsive -> Page
page leagueTitle response progessive =
    Page
        ( DoubleHeader  
            (headerBar leagueTitle)
            (SubHeaderBar "Results / Fixtures"))
        ( maybeResponse response <| fixturesResultsElement progessive )

headerBar: String -> HeaderBar
headerBar leagueTitle = 
    HeaderBar 
        [ BackHeaderButton <| IndividualSheetRequest leagueTitle ] 
        (Maybe.withDefault "" <| decodeUri leagueTitle)
        [ RefreshHeaderButton <| IndividualSheetRequestForResultsFixtures leagueTitle ]

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
        , class <| "data-test-day data-test-date-" ++ (dateClassNamePart leagueGamesForDay.date)
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
        , width <| percent 100 ] 
        [ 
            paragraph 
                ResultFixtureHome 
                [ alignRight, teamWidth responsive, class "data-test-homeTeamName" ] 
                [ text game.homeTeamName ]
            , row 
                None 
                [ ] 
                ( scoreSlashTime game )
            , paragraph 
                ResultFixtureAway 
                [ alignLeft, teamWidth responsive, class "data-test-awayTeamName" ] 
                [ text game.awayTeamName ]
        ]

scoreSlashTime : Game -> List (Element Styles variation Msg)
scoreSlashTime game =
    case (game.homeTeamGoals, game.awayTeamGoals) of
        (Just homeTeamGoals, Just awayTeamGoals) ->
            [ 
                el 
                    ResultFixtureScore 
                    [ alignRight, class "data-test-homeTeamGoals" ] 
                    (text <| toString homeTeamGoals)
                , el 
                    ResultFixtureScore 
                    [ ] 
                    (text " - ")
                , el 
                    ResultFixtureScore 
                    [ alignLeft, class "data-test-awayTeamGoals" ] 
                    (text <| toString awayTeamGoals)
            ]
        (_, _) ->
            [ 
                el 
                    ResultFixtureTime 
                    [ verticalCenter, class "data-test-datePlayed" ] 
                    (text <| timeDisplay game.datePlayed)
            ]
            
dateClassNamePart: Maybe Date -> String
dateClassNamePart maybeDate = 
    maybeDate
    |> Maybe.map (Date.Extra.toFormattedString "yyyy-MM-dd") 
    |> Maybe.withDefault "unscheduled"

dateDisplay: Maybe Date -> String
dateDisplay maybeDate = 
    maybeDate
    |> Maybe.map (Date.Extra.toFormattedString "MMMM d, yyyy") 
    |> Maybe.withDefault "Unscheduled"

timeDisplay: Maybe Date -> String
timeDisplay maybeDate = 
    maybeDate
    |> Maybe.map (Date.Extra.toFormattedString "HH:mm")
    |> Maybe.withDefault " - "

dayWidth: Responsive -> Element.Attribute variation msg
dayWidth responsive = 
    if responsive.designTeamWidthMediumFont * 2.5 < responsive.pageWidth * 0.8 then 
        width <| percent 80
    else 
        width <| percent 100
    
teamWidth: Responsive -> Element.Attribute variation msg
teamWidth responsive = 
    width <| fillPortion 50