module Models.Route exposing (..)

type Route
    = LeagueList
    | LeagueTable String -- change String to LeagueId later
    | ResultsFixtures String -- change String to LeagueId later
    | NotFound