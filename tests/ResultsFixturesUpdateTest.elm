module ResultsFixturesUpdateTest exposing (..)

import Dict exposing (Dict)
import Test exposing (..)
import Expect
import Expect exposing (Expectation)
import RemoteData exposing (WebData)
import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.Game exposing (vanillaGame)
import Models.LeagueGames exposing (LeagueGames)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)

oneGame : Test
oneGame =
    test "Calculates results / fixtures on success and adds to league table dictionary" <|
        \() ->
            update (IndividualSheetResponse leagueTitle <| RemoteData.Success leagueGames) vanillaModel
            |> \(model, msg) -> model.resultsFixturess
            |> Expect.equal
                (Dict.singleton 
                    leagueTitle
                    (RemoteData.Success <| calculateResultsFixtures leagueGames)
                )                

leagueTitle : String                
leagueTitle =
    "Regional Div 1"

leagueGames: LeagueGames
leagueGames = 
     LeagueGames leagueTitle [ vanillaGame ]
