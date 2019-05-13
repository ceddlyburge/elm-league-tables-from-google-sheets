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
import Models.LeagueTable exposing (..)
import Models.ResultsFixtures exposing (..)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Models.Route as Route exposing (Route)

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

-- this doesn't completely test that the api call gets make, but it would be strange code
-- that set leagues to RemoteData.Loading without also calling the Api
callsApi : Test
callsApi =
    test "Calls the APi if the results arent already available in the model" <|
        \() ->
            update 
                (IndividualSheetRequestForResultsFixtures leagueTitle)
                vanillaModel
            |> getModel
            |> Expect.equal 
                { vanillaModel | 
                    leagueTables = Dict.singleton leagueTitle RemoteData.Loading
                    , resultsFixturess = Dict.singleton leagueTitle RemoteData.Loading
                    , route = Route.ResultsFixturesRoute leagueTitle }

cachesAPiResult : Test
cachesAPiResult =
    test "Only calls the api if the results isn't already available in the model" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagueTables = Dict.singleton leagueTitle (RemoteData.Success vanillaLeagueTable)
                        , resultsFixturess = Dict.singleton leagueTitle (RemoteData.Success vanillaResultsFixtures)
                        , route = Route.ResultsFixturesRoute leagueTitle }
            in 
                update 
                    (IndividualSheetRequestForResultsFixtures leagueTitle)
                    model
                |> Expect.equal ( model, Cmd.none )

leagueTitle : String                
leagueTitle =
    "Regional Div 1"

leagueGames: LeagueGames
leagueGames = 
     LeagueGames leagueTitle [ vanillaGame ]

getModel : (Model, Cmd Msg) -> Model
getModel (model, cmd) = 
    model
