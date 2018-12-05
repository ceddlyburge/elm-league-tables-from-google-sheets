module LeagueListUpdate exposing (..)

import Http exposing (..)
import Test exposing (..)
import Fuzz exposing (list, string)
import Expect
import RemoteData exposing (WebData)

import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.LeagueSummary exposing (LeagueSummary)

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
