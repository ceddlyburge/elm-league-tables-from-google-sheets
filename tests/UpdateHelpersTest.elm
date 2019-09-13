module UpdateHelpersTest exposing (..)

import Dict exposing (Dict)
import Test exposing (..)
import Expect
import Expect exposing (Expectation)
import RemoteData exposing (WebData)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.Game exposing (vanillaGame)
import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueTable exposing (..)
import Models.ResultsFixtures exposing (..)
import Models.Player exposing (..)
import Models.Route as Route exposing (Route)
import Pages.UpdateHelpers exposing (..)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Calculations.PlayersFromLeagueGames exposing (calculatePlayers)

apiSuccess : Test
apiSuccess = 
    test "Calculates everything on success and adds to model" <|
        \() ->
            individualSheetResponse 
                vanillaModel
                (RemoteData.Success leagueGames)
                leagueTitle
            |> getModel
            |> Expect.equal 
                    { vanillaModel | 
                        leagueTables = Dict.singleton leagueTitle (RemoteData.Success <| calculateLeagueTable leagueGames)
                        , resultsFixtures = Dict.singleton leagueTitle (RemoteData.Success <| calculateResultsFixtures leagueGames)
                        , players = Dict.singleton leagueTitle (RemoteData.Success <| calculatePlayers leagueGames.games)
                    }

-- This only tests one Route, should maybe extend it to test others
-- It also only tests with a vanilla model, as opposed to a partially
-- filled model. The code doesn't currently partially fill the model,
-- and cachesAPiResultschecks it a bit, so I think its ok.
callsApi : Test
callsApi =
    test "Calls the APi if the results arent already available in the model" <|
        \() ->
            showRouteRequiringIndividualSheetApi
                leagueTitle
                (Route.ResultsFixtures leagueTitle)
                vanillaModel
            |> getModel
            |> Expect.equal 
                { vanillaModel | 
                    leagueTables = Dict.singleton leagueTitle RemoteData.Loading
                    , resultsFixtures = Dict.singleton leagueTitle RemoteData.Loading
                    , players = Dict.singleton leagueTitle RemoteData.Loading
                    , route = Route.ResultsFixtures leagueTitle }

cachesAPiResult : Test
cachesAPiResult =
    test "Only calls the api if the results isn't already available in the model" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagueTables = Dict.singleton leagueTitle (RemoteData.Success vanillaLeagueTable)
                        , resultsFixtures = Dict.singleton leagueTitle (RemoteData.Success vanillaResultsFixtures)
                        , players = Dict.singleton leagueTitle (RemoteData.Success vanillaPlayers)
                    }
            in 
                showRouteRequiringIndividualSheetApi
                    leagueTitle
                    (Route.LeagueTable leagueTitle)
                    model
                |> getModel
                |> Expect.equal { model | route = Route.LeagueTable leagueTitle }

refreshesApi : Test
refreshesApi =
    test "Calls the APi if asked to, even if the data already exists" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagueTables = Dict.singleton leagueTitle (RemoteData.Success vanillaLeagueTable)
                        , resultsFixtures = Dict.singleton leagueTitle (RemoteData.Success vanillaResultsFixtures)
                        , players = Dict.singleton leagueTitle (RemoteData.Success vanillaPlayers)
                    }
            in 
                refreshRouteRequiringIndividualSheetApi
                    leagueTitle
                    (Route.TopScorers leagueTitle)
                    vanillaModel
                |> getModel
                |> Expect.equal 
                    { model | 
                        leagueTables = Dict.singleton leagueTitle RemoteData.Loading
                        , resultsFixtures = Dict.singleton leagueTitle RemoteData.Loading
                        , players = Dict.singleton leagueTitle RemoteData.Loading
                        , route = Route.TopScorers leagueTitle }

leagueTitle : String                
leagueTitle =
    "Regional Div 1"

leagueGames: LeagueGames
leagueGames = 
     LeagueGames leagueTitle [ vanillaGame ]

getModel : (Model, Cmd Msg) -> Model
getModel (model, cmd) = 
    model
