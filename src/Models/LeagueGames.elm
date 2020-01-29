module Models.LeagueGames exposing (LeagueGames)

import Models.DecodedGame exposing (DecodedGame)


type alias LeagueGames =
    { leagueTitle : String
    , games : List DecodedGame
    }
