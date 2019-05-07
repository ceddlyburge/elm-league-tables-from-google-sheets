module ResultsFixturesUpdateTest exposing (..)

import Test exposing (..)
import Expect
import Expect exposing (Expectation)
import RemoteData exposing (WebData)
import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.LeagueGames exposing (LeagueGames)
import Models.ResultsFixtures exposing (ResultsFixtures)
import TestHelpers exposing (..)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)

oneGame : Test
oneGame =
    test "setLeagueGames" <|
        \() ->
            update (IndividualSheetResponseForResultsFixtures "" anyLeagueGames) vanillaModel
            |> \(model, msg) -> model
            |> Expect.all 
                [ expectLeagueGames anyLeagueGames
                , expectResultsFixtures <| RemoteData.map calculateResultsFixtures anyLeagueGames
                ]


anyLeagueGames: WebData LeagueGames
anyLeagueGames = 
    RemoteData.Success ( LeagueGames "Div 1" [ vanillaGame ] )

expectLeagueGames: WebData LeagueGames -> Model -> Expectation
expectLeagueGames expectedLeagueGames model =
    Expect.equal expectedLeagueGames model.leagueGames

expectResultsFixtures: WebData ResultsFixtures -> Model -> Expectation
expectResultsFixtures expectedResultsFixtures model =
    Expect.equal expectedResultsFixtures model.resultsFixtures
