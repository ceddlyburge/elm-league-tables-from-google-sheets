module Pages.ResultsFixtures.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import Date exposing (..)
import Date.Extra exposing (..)
import Pages.Gaps exposing (..)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.Game exposing (Game)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..) 
import Pages.HeaderBarItem exposing (..)


page : String -> WebData ResultsFixtures -> Device -> Page
page leagueTitle response device =
    Page
        ( DoubleHeader  
            (headerBar leagueTitle)
            (SubHeaderBar "Results / Fixtures"))
        ( maybeResponse response (fixturesResultsElement device) )

headerBar: String -> HeaderBar
headerBar leagueTitle = 
    HeaderBar 
        [ BackHeaderButton <| IndividualSheetRequest leagueTitle ] 
        (Maybe.withDefault "" (decodeUri leagueTitle))
        [ RefreshHeaderButton <| IndividualSheetRequestForResultsFixtures leagueTitle ]

fixturesResultsElement : Device -> ResultsFixtures -> Element Styles variation Msg
fixturesResultsElement device resultsFixtures =
    let
        gaps = gapsForDevice device
    in
        column 
            None 
            [ rowWidth device, class "data-test-dates" ]
            (List.map (day device gaps) resultsFixtures.days)

day : Device -> Gaps -> LeagueGamesForDay -> Element Styles variation Msg
day device gaps leagueGamesForDay =
    column 
        None 
        [ padding gaps.medium
        , spacing gaps.small
        , center
        , class <| "data-test-day data-test-date-" ++ (dateClassNamePart leagueGamesForDay.date)
        ]
        [ dayHeader leagueGamesForDay.date
        , dayResultsFixtures device gaps leagueGamesForDay] --List.map (gameRow device gaps) leagueGamesForDay.games)

dayHeader : Maybe Date -> Element Styles variation Msg
dayHeader maybeDate =
    el 
        ResultFixtureDay 
        [ class "data-test-dayHeader" ] 
        (text <| dateDisplay maybeDate)

dayResultsFixtures : Device -> Gaps -> LeagueGamesForDay -> Element Styles variation Msg
dayResultsFixtures device gaps leagueGamesForDay =
    column 
        None 
        [ ]
        (List.map (gameRow device gaps) leagueGamesForDay.games)

gameRow : Device -> Gaps -> Game -> Element Styles variation Msg
gameRow device gaps game =
    row 
        None 
        [ padding gaps.medium, spacing gaps.small, center, class "data-test-game" ] 
        [ 
            paragraph 
                ResultFixtureHome 
                [ alignRight, teamWidth device, class "data-test-homeTeamName" ] 
                [ text game.homeTeamName ]
            , row 
                None 
                [ scoreSlashDateWidth device ] 
                ( scoreSlashTime game )
            , paragraph 
                ResultFixtureAway 
                [ alignLeft, teamWidth device, class "data-test-awayTeamName" ] 
                [ text game.awayTeamName ]
        ]

scoreSlashTime : Game -> List (Element Styles variation Msg)
scoreSlashTime game =
    case (game.homeTeamGoals, game.awayTeamGoals) of
        (Just homeTeamGoals, Just awayTeamGoals) ->
            [ 
                el 
                    ResultFixtureHome 
                    [ alignRight, width (percent 35), class "data-test-homeTeamGoals" ] 
                    (text <| toString homeTeamGoals)
                , el 
                    None 
                    [ width (percent 30)] 
                    empty
                , el 
                    ResultFixtureAway 
                    [ alignLeft, width (percent 35), class "data-test-awayTeamGoals" ] 
                    (text <| toString awayTeamGoals)
            ]
        (_, _) ->
            [ 
                el 
                    ResultFixtureDate 
                    [ verticalCenter, width (percent 100) , class "data-test-datePlayed" ] 
                    (text <| timeDisplay game.datePlayed)
            ]
            
dateClassNamePart: Maybe Date -> String
dateClassNamePart maybeDate = 
    maybeDate
    |> dateToString
    |> Maybe.withDefault "unscheduled"

dateDisplay: Maybe Date -> String
dateDisplay maybeDate = 
    maybeDate
    |> dateToString
    |> Maybe.withDefault "Unscheduled"

dateToString: Maybe Date -> Maybe String
dateToString maybeDate = 
    maybeDate
    |> Maybe.map (Date.Extra.toFormattedString "yyyy-MM-dd") 

timeDisplay: Maybe Date -> String
timeDisplay maybeDate = 
    maybeDate
    |> Maybe.map (Date.Extra.toFormattedString "HH:mm")
    |> Maybe.withDefault ""

rowWidth: Device -> Element.Attribute variation msg
rowWidth device = 
    if device.phone then
        width (percent 95)
    else
        width (px 800)

teamWidth: Device -> Element.Attribute variation msg
teamWidth device = 
    if device.phone then
        width (percent 35)
    else
        width (px 300)

scoreSlashDateWidth: Device -> Element.Attribute variation msg
scoreSlashDateWidth device = 
    if device.phone then
        width (percent 30)
    else
        width (px 200)