module Models.Team exposing (Team)


type alias Team =
    { teamName : String
    , gamesPlayed : Int
    , points : Int
    , goalsFor : Int
    , goalsAgainst : Int
    , goalDifference : Int
    }
