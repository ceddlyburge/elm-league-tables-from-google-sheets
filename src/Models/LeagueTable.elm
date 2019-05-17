module Models.LeagueTable exposing (LeagueTable, vanillaLeagueTable)

import Models.Team exposing (Team)


type alias LeagueTable =
    { title : String
    , teams : List Team
    }

vanillaLeagueTable : LeagueTable
vanillaLeagueTable = 
    LeagueTable "" []