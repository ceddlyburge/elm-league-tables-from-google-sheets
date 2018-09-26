module ResultsFixtures.View exposing (..)

import Html exposing (Html, span)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import Date.Format exposing (..)
import ViewComponents exposing (..)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueGames exposing (LeagueGames)
import Models.Game exposing (Game)
import ErrorMessages exposing (httpErrorMessage, unexpectedNotAskedMessage)


view : String -> WebData LeagueGames -> Device -> Html Msg
view leagueTitle response device =
    let
        gaps = gapsForDevice device
    in
        Element.layout (stylesheet device) <|         
            column Body [ width (percent 100), spacing gaps.big, center ]
            [
                column 
                    Title
                    [ width (percent 100) ]
                    [ 
                        row 
                            None
                            [ width (percent 100), padding gaps.big, verticalCenter ] 
                            [
                                row None [ center, spacing gaps.big, width (percent 100)   ]
                                [
                                    el TitleButton [ onClick <| IndividualSheetRequest leagueTitle ] backIcon
                                    , el Title [ width fill, center ] (text <| Maybe.withDefault "" (decodeUri leagueTitle))
                                    , el TitleButton [ onClick <| IndividualSheetRequestForResultsFixtures leagueTitle ] refreshIcon
                                ]
                            ]
                        , el 
                            SubTitle 
                            [ width (percent 100), padding gaps.medium, verticalCenter ]
                            (text "Results / Fixtures")
                    ]
                , maybeFixturesResults device gaps response
            ]

maybeFixturesResults : Device -> Gaps -> WebData LeagueGames -> Element Styles variation Msg
maybeFixturesResults device gaps response =
    case response of
        RemoteData.NotAsked ->
            unhappyPathText unexpectedNotAskedMessage

        RemoteData.Loading ->
            loading

        RemoteData.Success leagueTable ->
            fixturesResultsElement device gaps leagueTable

        RemoteData.Failure error ->
            unhappyPathText <| httpErrorMessage error

fixturesResultsElement : Device -> Gaps -> LeagueGames -> Element Styles variation Msg
fixturesResultsElement device gaps leagueGames =
    column 
        None 
        [ rowWidth device, class "games" ]
        (List.map (gameRow device gaps) leagueGames.games)

gameRow : Device -> Gaps -> Game -> Element Styles variation Msg
gameRow device gaps game =
    -- do something about LeagueTableTeamRow
    row 
        LeagueTableTeamRow 
        [ padding gaps.medium, spacing gaps.small, center, class "game" ] 
        [ 
            paragraph ResultFixtureHome [ alignRight, teamWidth device, class "homeTeamName" ] [text game.homeTeamName]
            , row 
                None 
                [ scoreSlashDateWidth device ] 
                ( scoreSlashDate game )
            , paragraph ResultFixtureAway [ alignLeft, teamWidth device, class "awayTeamName" ] [ text game.awayTeamName ]
        ]

scoreSlashDate : Game -> List (Element Styles variation Msg)
scoreSlashDate game =
    case (game.homeTeamGoals, game.awayTeamGoals) of
        (Just homeTeamGoals, Just awayTeamGoals) ->
            [ 
                el ResultFixtureHome [ alignRight, width (percent 35), class "homeTeamGoals" ] (text (toString homeTeamGoals) )
                , el None [ width (percent 30)] empty
                , el ResultFixtureAway [ alignLeft, width (percent 35), class "awayTeamGoals" ] (text (toString awayTeamGoals) )
            ]
        (_, _) ->
            [ 
                el ResultFixtureDate [ verticalCenter, width (percent 100) , class "datePlayed" ] (text <| Maybe.withDefault "" (Maybe.map formatDate game.datePlayed) )
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