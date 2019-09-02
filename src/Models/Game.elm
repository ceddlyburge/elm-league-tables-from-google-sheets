module Models.Game exposing (Game, vanillaGame)

import Date exposing (..)

type alias Game =
    { homeTeamName : String
    , homeTeamGoals : Maybe Int
    , awayTeamName : String
    , awayTeamGoals : Maybe Int
    , datePlayed : Maybe Date
    , homeGoals : List String
    , homeScorers : String
    , awayScorers : String
    , homeCards : String
    , awayCards : String
    , notes : String
    }

vanillaGame : Game
vanillaGame = 
    Game "" Nothing "" Nothing Nothing [] "" "" "" "" "" 
