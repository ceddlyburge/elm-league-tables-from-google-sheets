module Models.Config exposing (..)


type alias Config =
    { netlifyFunctionsServer : String
    , applicationTitle : String
    , windowWidth : Int
    , windowHeight : Int
    }


vanillaConfig : Config
vanillaConfig =
    Config "" "" 1024 768
