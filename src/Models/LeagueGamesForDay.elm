module Models.LeagueGamesForDay exposing (LeagueGamesForDay)

import Date exposing (..)

import Models.Game exposing (Game)


type alias LeagueGamesForDay =
    { date : Maybe Date
    , games : List Game
    }
