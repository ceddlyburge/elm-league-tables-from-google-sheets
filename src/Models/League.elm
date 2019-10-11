module Models.League exposing (..)

import Models.LeagueTable exposing (..)
import Models.Player as Player exposing (..)
import Models.ResultsFixtures exposing (..)


type alias League =
    { title : String
    , table : LeagueTable
    , resultsFixtures : ResultsFixtures
    , players : Players
    }


vanilla : League
vanilla =
    League
        ""
        vanillaLeagueTable
        vanillaResultsFixtures
        vanillaPlayers
