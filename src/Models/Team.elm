module Models.Team exposing (..)


type alias Team =
    { name : String
    , gamesPlayed : Int
    , points : Int
    , goalsFor : Int
    , goalsAgainst : Int
    , goalDifference : Int
    }

position: Team -> String
position team = 
    "0"

name: Team -> String
name team = 
    team.name

gamesPlayed: Team -> String
gamesPlayed team = 
    toString team.gamesPlayed

points: Team -> String
points team = 
    toString team.points

goalsFor: Team -> String
goalsFor team = 
    toString team.goalsFor

goalsAgainst: Team -> String
goalsAgainst team = 
    toString team.goalsAgainst

goalDifference: Team -> String
goalDifference team = 
    toString team.goalDifference

won: Team -> String
won team = 
    "0"

drawn: Team -> String
drawn team = 
    "0"

lost: Team -> String
lost team = 
    "0"

