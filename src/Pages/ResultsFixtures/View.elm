module Pages.ResultsFixtures.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import Date.Extra exposing (..)
import Pages.Gaps exposing (..)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueGames exposing (LeagueGames)
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
    -- do something about LeagueTableTeamRow
    column 
        LeagueTableTeamRow 
        [ padding gaps.medium
        , spacing gaps.small
        , center
        , class 
        (
            "data-test-day data-test-date-" ++ 
            Maybe.withDefault 
                "unscheduled" 
                (Maybe.map (Date.Extra.toFormattedString "yyyy-MM-dd") leagueGamesForDay.date) ) ] 
        (List.map (gameRow device gaps) leagueGamesForDay.games)

gameRow : Device -> Gaps -> Game -> Element Styles variation Msg
gameRow device gaps game =
    -- do something about LeagueTableTeamRow
    row 
        LeagueTableTeamRow 
        [ padding gaps.medium, spacing gaps.small, center, class "data-test-game" ] 
        [ 
            paragraph ResultFixtureHome [ alignRight, teamWidth device, class "data-test-homeTeamName" ] [text game.homeTeamName]
            , row 
                None 
                [ scoreSlashDateWidth device ] 
                ( scoreSlashDate game )
            , paragraph ResultFixtureAway [ alignLeft, teamWidth device, class "data-test-awayTeamName" ] [ text game.awayTeamName ]
        ]

scoreSlashDate : Game -> List (Element Styles variation Msg)
scoreSlashDate game =
    case (game.homeTeamGoals, game.awayTeamGoals) of
        (Just homeTeamGoals, Just awayTeamGoals) ->
            [ 
                el ResultFixtureHome [ alignRight, width (percent 35), class "data-test-homeTeamGoals" ] (text (toString homeTeamGoals) )
                , el None [ width (percent 30)] empty
                , el ResultFixtureAway [ alignLeft, width (percent 35), class "data-test-awayTeamGoals" ] (text (toString awayTeamGoals) )
            ]
        (_, _) ->
            [ 
                el ResultFixtureDate [ verticalCenter, width (percent 100) , class "data-test-datePlayed" ] (text <| Maybe.withDefault "" (Maybe.map (Date.Extra.toFormattedString "HH:mm") game.datePlayed) )
            ]
            

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