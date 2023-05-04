module Main exposing (main)

import Browser
import Browser.Navigation exposing (Key)
import Models.Config exposing (Config)
import Models.Model exposing (ModelAndKey, updateScreenSize, vanillaModelAndKey)
import Msg exposing (Msg)
import Subscriptions
import Update exposing (update)
import Url exposing (Url)
import View exposing (view)


init : Config -> Url -> Key -> ( ModelAndKey, Cmd Msg )
init config url key =
    let
        vanillamodelAndKey : ModelAndKey
        vanillamodelAndKey =
            vanillaModelAndKey key

        vanillaModel : Models.Model.Model
        vanillaModel =
            vanillamodelAndKey.model

        vanillaModelWithConfig : Models.Model.Model
        vanillaModelWithConfig =
            { vanillaModel | config = config }
                |> updateScreenSize config.windowWidth config.windowHeight

        vanillaModelAndKeyWithConfig : ModelAndKey
        vanillaModelAndKeyWithConfig =
            { vanillamodelAndKey | model = vanillaModelWithConfig }
    in
    update
        (Msg.OnUrlChange url)
        vanillaModelAndKeyWithConfig



---- PROGRAM ----


main : Program Config ModelAndKey Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = Subscriptions.subscriptions
        , onUrlChange = Msg.OnUrlChange
        , onUrlRequest = Msg.OnUrlRequest
        }
