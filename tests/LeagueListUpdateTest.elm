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
                |> Expect.equal { vanillaModel | leagues = response }

cachesAPiResult : Test
cachesAPiResult =
    test "Only calls the api if the results isn't already available in the model" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagues = RemoteData.Success []
                        , route = Route.LeagueListRoute }
            in 
                update 
                    ShowLeagueList 
                    model
                |> Expect.equal ( model, Cmd.none )

apiSuccess : Test
apiSuccess =
    fuzz (list string) "Returns model and Leagues on success" <|
        \leagues ->
            let 
                response = RemoteData.Success <| List.map LeagueSummary leagues
            in 
                update (AllSheetSummaryResponse response) vanillaModel
                |> getModel
                |> Expect.equal { vanillaModel | leagues = response }  

getModel : (Model, Cmd Msg) -> Model
getModel (model, cmd) = 
    model
