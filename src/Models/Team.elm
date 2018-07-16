module Models.Team exposing (Team)


type alias Team =
    { name : String
    , gamesPlayed : Int
    , points : Int
    , goalsFor : Int
    , goalsAgainst : Int
    , goalDifference : Int
    }
