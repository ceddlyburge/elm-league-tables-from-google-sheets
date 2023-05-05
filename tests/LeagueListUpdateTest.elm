module LeagueListUpdateTest exposing (apiError, apiSuccess, cachesApiResult, callsApi, refreshesAPi)

import Expect
import Fuzz exposing (list, string)
import Http exposing (Error(..))
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Model exposing (Model, vanillaModel)
import Models.Route as Route
import Msg exposing (Msg(..))
import RemoteData
import Test exposing (Test, fuzz, test)
import Update exposing (updatewithoutBrowserHistory)


apiError : Test
apiError =
    test "Retains response on error" <|
        \() ->
            let
                response : RemoteData.RemoteData Error a
                response =
                    RemoteData.Failure NetworkError
            in
            updatewithoutBrowserHistory (AllSheetSummaryResponse response) vanillaModel
                |> getModel
                |> Expect.equal { vanillaModel | leagueSummaries = response }



-- this doesn't completely test that the api call gets make, but it would be strange code
-- that set leagues to RemoteData.Loading without also calling the Api


callsApi : Test
callsApi =
    test "Calls the APi if the results arent already available in the model" <|
        \() ->
            updatewithoutBrowserHistory
                ShowLeagueList
                vanillaModel
                |> getModel
                |> Expect.equal
                    { vanillaModel
                        | leagueSummaries = RemoteData.Loading
                        , route = Route.LeagueList
                    }


cachesApiResult : Test
cachesApiResult =
    test "Only calls the api if the results isn't already available in the model" <|
        \() ->
            let
                model : Model
                model =
                    { vanillaModel
                        | leagueSummaries = RemoteData.Success []
                        , route = Route.LeagueList
                    }
            in
            updatewithoutBrowserHistory
                ShowLeagueList
                model
                |> Expect.equal ( model, Cmd.none )


refreshesAPi : Test
refreshesAPi =
    test "Calls the APi if asked to, even if the data already exists" <|
        \() ->
            let
                model : Model
                model =
                    { vanillaModel
                        | leagueSummaries = RemoteData.Success []
                        , route = Route.LeagueList
                    }
            in
            updatewithoutBrowserHistory
                RefreshLeagueList
                model
                |> getModel
                |> Expect.equal { model | leagueSummaries = RemoteData.Loading }


apiSuccess : Test
apiSuccess =
    fuzz (list string) "Returns model and Leagues on success" <|
        \leagues ->
            let
                response : RemoteData.RemoteData e (List LeagueSummary)
                response =
                    RemoteData.Success <| List.map LeagueSummary leagues
            in
            updatewithoutBrowserHistory (AllSheetSummaryResponse response) vanillaModel
                |> getModel
                |> Expect.equal { vanillaModel | leagueSummaries = response }


getModel : ( Model, Cmd msg ) -> Model
getModel ( model, _ ) =
    model
