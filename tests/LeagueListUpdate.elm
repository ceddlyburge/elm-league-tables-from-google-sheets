module LeagueListUpdate exposing (..)

import Http exposing (..)

import Test exposing (..)
import Expect

import LeagueList.Updates exposing (update)
import Messages.Msg exposing ( .. )
import Models.Config exposing (Config)
import Models.Model exposing (Model)

apiError : Test
apiError =
    test "Returns model and cmd.none on error" <|
        \() -> update ( Messages.Msg.SheetResponse ( Err NetworkError ) ) model
            |> Expect.equal (model, Cmd.none)

model : Model
model = 
    Model ( Config "" ""  ) []