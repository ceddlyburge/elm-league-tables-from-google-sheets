module Models.Config exposing (..)


type alias Config =
    { netlifyFunctionsServer : String
    , applicationTitle : String
    }


vanillaConfig : Config
vanillaConfig =
    Config "" ""
