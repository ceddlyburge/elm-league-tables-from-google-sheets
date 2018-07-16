module Models.LeagueTable exposing (LeagueTable)

import Models.Team exposing (Team)


type alias LeagueTable =
    { title : String
    , teams : List Team
    }
