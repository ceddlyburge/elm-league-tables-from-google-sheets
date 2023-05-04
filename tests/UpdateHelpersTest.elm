module UpdateHelpersTest exposing (apiSuccess, cachesApiResult, callsApi, callsApiOnError, refreshesApi)

import Calculations.LeagueFromLeagueGames exposing (calculateLeague)
import Dict
import Expect
import Http
import Models.DecodedGame exposing (vanillaGame)
import Models.League as League
import Models.LeagueGames exposing (LeagueGames)
import Models.Model exposing (Model, vanillaModel)
import Models.Route as Route
import Msg exposing (..)
import Pages.UpdateHelpers exposing (..)
import RemoteData
import Test exposing (..)


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
                    { vanillaModel
                        | leagues =
                            Dict.singleton
                                leagueTitle
                                (RemoteData.Success <| calculateLeague leagueGames)
                    }



-- This only tests one Route, should maybe extend it to test others
-- It also only tests with a vanilla model, as opposed to a partially
-- filled model. The code doesn't currently partially fill the model,
-- and cachesAPiResults checks it a bit, so I think its ok.


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
                    { vanillaModel
                        | leagues = Dict.singleton leagueTitle RemoteData.Loading
                        , route = Route.ResultsFixtures leagueTitle
                    }


cachesApiResult : Test
cachesApiResult =
    test "Only calls the api if the results isn't already available in the model" <|
        \() ->
            let
                model =
                    { vanillaModel
                        | leagues = Dict.singleton leagueTitle (RemoteData.Success League.vanilla)
                    }
            in
            showRouteRequiringIndividualSheetApi
                leagueTitle
                (Route.LeagueTable leagueTitle)
                model
                |> getModel
                |> Expect.equal { model | route = Route.LeagueTable leagueTitle }


callsApiOnError : Test
callsApiOnError =
    test "Calls the api if the result is failure" <|
        \() ->
            let
                theRoute =
                    Route.LeagueTable leagueTitle

                leaguesWithError =
                    Dict.singleton leagueTitle (RemoteData.Failure Http.NetworkError)

                expectedLeagues =
                    Dict.singleton leagueTitle RemoteData.Loading

                model =
                    { vanillaModel | leagues = leaguesWithError }
            in
            showRouteRequiringIndividualSheetApi
                leagueTitle
                theRoute
                model
                |> getModel
                |> Expect.equal { model | route = theRoute, leagues = expectedLeagues }


refreshesApi : Test
refreshesApi =
    test "Calls the APi if asked to, even if the data already exists" <|
        \() ->
            let
                model =
                    { vanillaModel
                        | leagues = Dict.singleton leagueTitle (RemoteData.Success League.vanilla)
                    }
            in
            refreshRouteRequiringIndividualSheetApi
                leagueTitle
                (Route.TopScorers leagueTitle)
                vanillaModel
                |> getModel
                |> Expect.equal
                    { model
                        | leagues = Dict.singleton leagueTitle RemoteData.Loading
                        , route = Route.TopScorers leagueTitle
                    }


leagueTitle : String
leagueTitle =
    "Regional Div 1"


leagueGames : LeagueGames
leagueGames =
    LeagueGames leagueTitle [ vanillaGame ]


getModel : ( Model, Cmd Msg ) -> Model
getModel ( model, cmd ) =
    model
