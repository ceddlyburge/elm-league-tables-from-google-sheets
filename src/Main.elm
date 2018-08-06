module Main exposing (..)

import Html exposing (Html)
import Models.Config exposing (Config)
import Models.Model exposing (Model)
import Models.LeagueTable exposing (LeagueTable)
import Msg exposing (Msg)
import LeagueList.Update exposing (allSheetSummaryRequest)
import Update exposing (update)
import View exposing (view)


-- It is not possible to import this module in to an elm-spec test, as it tells me there is a circular dependency.
-- There isn't one that I can see, so it must be created by the test runner or something like that.
-- The upshot is that any code in this file is defintely not covered by the "end to end" tests.
-- This is a bit of a shame, but its a good enough compromise I think.


init : Config -> ( Model, Cmd Msg )
init config =
    allSheetSummaryRequest (Model config [] ( LeagueTable "" [] ) )



---- PROGRAM ----


main : Program Config Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
