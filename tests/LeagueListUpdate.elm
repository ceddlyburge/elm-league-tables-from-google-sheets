module LeagueListUpdate exposing (..)

import Http exposing (..)
import Test exposing (..)
import Fuzz exposing (list, string)
import Expect
import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.State exposing (State)
import Models.Route as Route exposing (Route)

apiError : Test
apiError =
    test "Returns model and cmd.none on error" <|
        \() ->
            update (AllSheetSummaryResponse (Err NetworkError)) vanillaModel
                |> Expect.equal ( vanillaModel, Cmd.none )


apiSuccess : Test
apiSuccess =
    fuzz (list string) "Returns model and Leagues on success" <|
        \leagues ->
            update (AllSheetSummaryResponse (Ok <| List.map LeagueSummary leagues)) vanillaModel
            |> getModel
            |> Expect.equal { vanillaModel | state = Models.State.LeagueList, route = Route.LeagueListRoute, leagues = (List.map LeagueSummary leagues) }  

getModel : (Model, Cmd Msg) -> Model
getModel (model, cmd) = 
    model

