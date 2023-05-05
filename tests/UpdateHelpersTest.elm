module UpdateHelpersTest exposing (apiSuccess, cachesApiResult, callsApi, callsApiOnError, refreshesApi)

import Calculations.LeagueFromLeagueGames exposing (calculateLeague)
import Dict
import Expect
import Helpers exposing (vanillaDecodedGame, vanillaLeague)
import Http
import Models.LeagueGames exposing (LeagueGames)
import Models.Model exposing (Model, vanillaModel)
import Models.Route as Route exposing (Route)
import Pages.UpdateHelpers exposing (individualSheetResponse, refreshRouteRequiringIndividualSheetApi, showRouteRequiringIndividualSheetApi)
import RemoteData
import Test exposing (Test, test)


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
                model : Model
                model =
                    { vanillaModel
                        | leagues = Dict.singleton leagueTitle (RemoteData.Success vanillaLeague)
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
                theRoute : Route
                theRoute =
                    Route.LeagueTable leagueTitle

                leaguesWithError : Dict.Dict String (RemoteData.RemoteData Http.Error a)
                leaguesWithError =
                    Dict.singleton leagueTitle (RemoteData.Failure Http.NetworkError)

                expectedLeagues : Dict.Dict String (RemoteData.RemoteData e a)
                expectedLeagues =
                    Dict.singleton leagueTitle RemoteData.Loading

                model : Model
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
                model : Model
                model =
                    { vanillaModel
                        | leagues = Dict.singleton leagueTitle (RemoteData.Success vanillaLeague)
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
    LeagueGames leagueTitle [ vanillaDecodedGame ]


getModel : ( Model, Cmd msg ) -> Model
getModel ( model, _ ) =
    model
