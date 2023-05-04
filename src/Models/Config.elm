module Models.Config exposing (Config, vanillaConfig)


type alias Config =
    { netlifyFunctionsServer : String
    , applicationTitle : String
    , windowWidth : Int
    , windowHeight : Int
    }


vanillaConfig : Config
vanillaConfig =
    Config "" "" 1024 768
