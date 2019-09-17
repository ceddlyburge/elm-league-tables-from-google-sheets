module Models.League exposing (..)

import Models.LeagueTable exposing (..)
import Models.ResultsFixtures exposing (..)
import Models.Player as Player exposing (..)

type alias League =
    { title: String
    , table: LeagueTable
    , resultsFixtures: ResultsFixtures
    , players: Players
    } 

vanilla : League
vanilla =
    League
        "" 
        vanillaLeagueTable
        vanillaResultsFixtures
        vanillaPlayers