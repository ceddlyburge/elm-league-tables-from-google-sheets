module Models.Game exposing (Game)


type alias Game =
    { homeTeamName : String
    , homeTeamGoals : Maybe Int
    , awayTeamName : String
    , awayTeamGoals : Maybe Int
    , datePlayed : String
    , homeScorers : String
    , awayScorers : String
    , homeCards : String
    , awayCards : String
    , notes : String
    }
