module Models.LeagueGames exposing (LeagueGames)

import Models.Game exposing (Game)


type alias LeagueGames =
    { leagueTitle : String
    , games : List Game
    }
