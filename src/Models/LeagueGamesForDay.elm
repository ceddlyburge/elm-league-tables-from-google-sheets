module Models.LeagueGamesForDay exposing (LeagueGamesForDay)

import Models.Game exposing (Game)
import Time exposing (Posix)


type alias LeagueGamesForDay =
    { date : Maybe Posix
    , games : List Game
    }
