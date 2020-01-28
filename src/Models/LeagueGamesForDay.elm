module Models.LeagueGamesForDay exposing (LeagueGamesForDay)

import Time exposing (..)
import Models.Game exposing (Game)

-- Game is what the google spreadsheet is decoded to, and is used
-- again here for a calculated result. 
-- It might be better to separate these two uses, and use a new 
-- type in place of Game here


type alias LeagueGamesForDay =
    { date : Maybe Posix
    , games : List Game
    }
