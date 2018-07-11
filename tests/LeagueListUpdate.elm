module LeagueListUpdate exposing (..)

import Http exposing (..)

import Test exposing (..)
import Fuzz exposing (list, string)
import Expect

import LeagueList.Updates exposing (update)
import Messages.Msg exposing ( .. )
import Models.Config exposing (Config)
import Models.Model exposing (Model)
import Models.League exposing (League)

apiError : Test
apiError =
    test "Returns model and cmd.none on error" <|
        \() -> update ( Messages.Msg.SheetResponse ( Err NetworkError ) ) model
            |> Expect.equal (model, Cmd.none)

apiSuccess : Test
apiSuccess =
    fuzz ( list string ) "Returns model and Leagues on success" <|
        \( leagues ) -> update ( Messages.Msg.SheetResponse ( Ok <| List.map League leagues ) ) model
            |> \( model, cmd ) -> model.leagues
            |> Expect.equal ( List.map League leagues )

model : Model
model = 
    Model ( Config "" ""  ) []