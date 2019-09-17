module LeagueListUpdateTest exposing (..)

import Http exposing (..)
import Test exposing (..)
import Fuzz exposing (list, string)
import Expect
import RemoteData exposing (WebData)

import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Route as Route exposing (Route)

apiError : Test
apiError =
    test "Retains response on error" <|
        \() ->
            let 
                response = RemoteData.Failure NetworkError
            in 
                update (AllSheetSummaryResponse response) vanillaModel
                |> getModel
                |> Expect.equal { vanillaModel | leagueSummaries = response }

-- this doesn't completely test that the api call gets make, but it would be strange code
-- that set leagues to RemoteData.Loading without also calling the Api
callsApi : Test
callsApi =
    test "Calls the APi if the results arent already available in the model" <|
        \() ->
            update 
                ShowLeagueList 
                vanillaModel
            |> getModel
            |> Expect.equal 
                { vanillaModel | 
                    leagueSummaries = RemoteData.Loading
                    , route = Route.LeagueList }

cachesApiResult : Test
cachesApiResult =
    test "Only calls the api if the results isn't already available in the model" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagueSummaries = RemoteData.Success []
                        , route = Route.LeagueList }
            in 
                update 
                    ShowLeagueList 
                    model
                |> Expect.equal ( model, Cmd.none )


refreshesAPi : Test
refreshesAPi =
    test "Calls the APi if asked to, even if the data already exists" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagueSummaries = RemoteData.Success []
                        , route = Route.LeagueList }
            in 
                update 
                    RefreshLeagueList 
                    model
                |> getModel
                |> Expect.equal { model | leagueSummaries = RemoteData.Loading }


apiSuccess : Test
apiSuccess =
    fuzz (list string) "Returns model and Leagues on success" <|
        \leagues ->
            let 
                response = RemoteData.Success <| List.map LeagueSummary leagues
            in 
                update (AllSheetSummaryResponse response) vanillaModel
                |> getModel
                |> Expect.equal { vanillaModel | leagueSummaries = response }  


getModel : (Model, Cmd Msg) -> Model
getModel (model, cmd) = 
    model
