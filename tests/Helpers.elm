module Helpers exposing (vanillaDecodedGame, vanillaGame, vanillaLeague, vanillaPlayers, vanillaResultsFixtures, vanillaStyles)

import Element exposing (Device, DeviceClass(..), Orientation(..))
import Models.DecodedGame exposing (DecodedGame)
import Models.Game exposing (Game)
import Models.League exposing (League)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.LeagueTable exposing (LeagueTable)
import Models.Player exposing (Players)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Pages.Responsive exposing (Responsive, calculateResponsive)
import Styles exposing (createStyles)


vanillaGame : Game
vanillaGame =
    Game "" Nothing "" Nothing Nothing "" "" "" "" ""


vanillaDecodedGame : DecodedGame
vanillaDecodedGame =
    DecodedGame "" Nothing "" Nothing Nothing [] [] "" "" ""


vanillaResponsive : Responsive
vanillaResponsive =
    calculateResponsive (Device Desktop Landscape) 1024


vanillaStyles : Styles.Styles
vanillaStyles =
    createStyles vanillaResponsive


vanillaResultsFixtures : ResultsFixtures
vanillaResultsFixtures =
    ResultsFixtures
        ""
        [ LeagueGamesForDay Nothing []
        ]


vanillaPlayers : Players
vanillaPlayers =
    Players False []


vanillaLeagueTable : LeagueTable
vanillaLeagueTable =
    LeagueTable "" []


vanillaLeague : League
vanillaLeague =
    League
        ""
        vanillaLeagueTable
        vanillaResultsFixtures
        vanillaPlayers
