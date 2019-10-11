module Models.LeagueGamesForDay exposing (LeagueGamesForDay)

import Time exposing (..)
import Models.Game exposing (Game)


type alias LeagueGamesForDay =
    { date : Maybe Posix
    , games : List Game
    }
