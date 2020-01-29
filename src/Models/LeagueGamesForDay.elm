module Models.LeagueGamesForDay exposing (LeagueGamesForDay)

import Time exposing (Posix)
import Models.Game exposing (Game)

type alias LeagueGamesForDay =
    { date : Maybe Posix
    , games : List Game
    }
