module Models.Game exposing (Game)


type alias Game =
    { homeTeamName : String
    , homeTeamGoals : Int
    , awayTeamName : String
    , awayTeamGoals : Int
    , dateplayed : String
    , homeScorers : String
    , awayScorers : String
    , notesAndCards : String
    }
