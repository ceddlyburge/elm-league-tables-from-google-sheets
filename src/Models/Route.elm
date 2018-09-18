module Models.Route exposing (..)

type Route
    = LeagueListRoute
    | LeagueTableRoute String -- change String to LeagueId later
    | ResultsFixturesRoute String -- change String to LeagueId later
    | NotFoundRoute