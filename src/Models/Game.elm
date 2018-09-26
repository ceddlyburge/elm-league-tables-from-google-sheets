module Models.Game exposing (Game)

import Date exposing (..)

type alias Game =
    { homeTeamName : String
    , homeTeamGoals : Maybe Int
    , awayTeamName : String
    , awayTeamGoals : Maybe Int
    , datePlayed : Maybe Date
    , homeScorers : String
    , awayScorers : String
    , homeCards : String
    , awayCards : String
    , notes : String
    }
