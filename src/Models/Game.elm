module Models.Game exposing (Game, LeagueGames)


type alias Game =
    { homeTeamName : String
    , homeTeamGoals : Maybe Int
    , awayTeamName : String
    , awayTeamGoals : Maybe Int
    , dateplayed : String
    , homeScorers : String
    , awayScorers : String
    , homeCards : String
    , awayCards : String
    , notes : String
    }

type alias LeagueGames =
    { leagueTitle : String
    , games : List Game
    }
