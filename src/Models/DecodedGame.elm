module Models.DecodedGame exposing (DecodedGame)

import Time exposing (Posix)



-- This type is what the google spreadsheet is decoded to, and is used
-- in results fixtures. It might be better to separate these two uses,
-- which would allow the minor smell of aggregateGoals to be fixed
-- This would require LeagueGamesForDays to use the new type, instead
-- of this one


type alias DecodedGame =
    { homeTeamName : String

    -- if homeTeamGoalCount and awayTeamGoalCount are not entered a game
    -- is considered not played yet (or not played yet)
    , homeTeamGoalCount : Maybe Int
    , awayTeamName : String
    , awayTeamGoalCount : Maybe Int
    , datePlayed : Maybe Posix

    -- homeTeamGoals and awayTeamGoals are lists of goals (currently just a string
    -- that represents the name or number of the scorer). They are optional. This creates
    -- the potential for a disconnect between the number of items in the list
    -- and the number of goals. I think this is Ok, we could add something to the
    -- docs later, but we don't control the data coming in so there isn't too much
    -- to do. We could do some logging / alerting / email when that functionality
    -- is availale
    , homeTeamGoals : List String
    , awayTeamGoals : List String
    , homeTeamCards : String
    , awayTeamCards : String
    , notes : String
    }
