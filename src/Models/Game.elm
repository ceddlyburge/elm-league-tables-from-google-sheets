module Models.Game exposing (Game)

import Time exposing (Posix)


type alias Game =
    { homeTeamName : String

    -- if homeTeamGoalCount and awayTeamGoalCount are not entered a game
    -- is considered invalid (or not played yet)
    , homeTeamGoalCount : Maybe Int
    , awayTeamName : String
    , awayTeamGoalCount : Maybe Int
    , datePlayed : Maybe Posix
    , homeTeamGoals : String
    , awayTeamGoals : String
    , homeTeamCards : String
    , awayTeamCards : String
    , notes : String
    }
