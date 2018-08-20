module Main exposing (..)

--import Html exposing (Html)
import Models.Config exposing (Config)
import Models.Model exposing (Model, vanillaModel)
--import Models.Route exposing (Route)
import Msg exposing (Msg)
--import LeagueList.Update exposing (allSheetSummaryRequest)
import Update exposing (update)
import View exposing (view)
import Navigation exposing (Location)
--import Routing exposing (..)

-- It is not possible to import this module in to an elm-spec test, as it tells me there is a circular dependency.
-- There isn't one that I can see, so it must be created by the test runner or something like that.
-- The upshot is that any code in this file is defintely not covered by the "end to end" tests.
-- This is a bit of a shame, but its a good enough compromise I think.


init : Config -> Location -> ( Model, Cmd Msg )
init config location =
    update 
     (Msg.OnLocationChange location)
     { vanillaModel | config = config }

-- init : Config -> Location -> ( Model, Cmd Msg )
-- init config location =
--     allSheetSummaryRequest { vanillaModel | config = config, route = parseLocation location}

-- init : Config -> ( Model, Cmd Msg )
-- init config =
--    let
--         currentRoute =
--             Routing.parseLocation location
--     in
--         ( initialModel currentRoute, fetchPlayers )


---- PROGRAM ----


main : Program Config Model Msg
main =
    --Html.programWithFlags
    Navigation.programWithFlags Msg.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
