module LeagueListUpdate exposing (..)

import Http exposing (..)
import Test exposing (..)
import Fuzz exposing (list, string)
import Expect
import Update exposing (update)
import Msg exposing (..)
import Models.Config exposing (Config)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)


apiError : Test
apiError =
    test "Returns model and cmd.none on error" <|
        \() ->
            update (SheetResponse (Err NetworkError)) model
                |> Expect.equal ( model, Cmd.none )


apiSuccess : Test
apiSuccess =
    fuzz (list string) "Returns model and Leagues on success" <|
        \leagues ->
            update (SheetResponse (Ok <| List.map LeagueSummary leagues)) model
                |> Expect.equal ( Model (Config "" "") (List.map LeagueSummary leagues) ( LeagueTable "" []) , Cmd.none )


model : Model
model =
    Model (Config "" "") [] ( LeagueTable "" [])
