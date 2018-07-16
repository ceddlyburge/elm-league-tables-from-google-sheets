module LeagueListUpdate exposing (..)

import Http exposing (..)
import Test exposing (..)
import Fuzz exposing (list, string)
import Expect
import LeagueList.Update exposing (update)
import Messages.Msg exposing (..)
import Models.Config exposing (Config)
import Models.Model exposing (LeagueListModel)
import Models.LeagueSummary exposing (LeagueSummary)


apiError : Test
apiError =
    test "Returns model and cmd.none on error" <|
        \() ->
            update (Messages.Msg.SheetResponse (Err NetworkError)) model
                |> Expect.equal ( Models.Model.LeagueList model, Cmd.none )


apiSuccess : Test
apiSuccess =
    fuzz (list string) "Returns model and Leagues on success" <|
        \leagues ->
            update (Messages.Msg.SheetResponse (Ok <| List.map LeagueSummary leagues)) model
                |> Expect.equal ( Models.Model.LeagueList (LeagueListModel (Config "" "") (List.map LeagueSummary leagues)), Cmd.none )


model : LeagueListModel
model =
    LeagueListModel (Config "" "") []
