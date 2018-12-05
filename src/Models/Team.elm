module Models.Team exposing (..)


type alias Team =
    { position : Int
    , name : String
    , gamesPlayed : Int
    , won : Int
    , drawn : Int
    , lost : Int
    , points : Int
    , goalsFor : Int
    , goalsAgainst : Int
    , goalDifference : Int
    }

position: Team -> String
position team = 
    toString team.position

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
    toString team.won

drawn: Team -> String
drawn team = 
    toString team.drawn

lost: Team -> String
lost team = 
    toString team.lost

