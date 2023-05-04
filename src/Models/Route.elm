module Models.Route exposing (Route(..))


type Route
    = LeagueList
    | LeagueTable String -- change String to LeagueId later
    | ResultsFixtures String -- change String to LeagueId later
    | TopScorers String -- change String to LeagueId later
    | NotFound
