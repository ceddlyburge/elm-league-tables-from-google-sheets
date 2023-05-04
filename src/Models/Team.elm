module Models.Team exposing (Team, drawn, gamesPlayed, goalDifference, goalsAgainst, goalsFor, lost, name, points, position, won)


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


position : Team -> String
position team =
    String.fromInt team.position


name : Team -> String
name team =
    team.name


gamesPlayed : Team -> String
gamesPlayed team =
    String.fromInt team.gamesPlayed


points : Team -> String
points team =
    String.fromInt team.points


goalsFor : Team -> String
goalsFor team =
    String.fromInt team.goalsFor


goalsAgainst : Team -> String
goalsAgainst team =
    String.fromInt team.goalsAgainst


goalDifference : Team -> String
goalDifference team =
    String.fromInt team.goalDifference


won : Team -> String
won team =
    String.fromInt team.won


drawn : Team -> String
drawn team =
    String.fromInt team.drawn


lost : Team -> String
lost team =
    String.fromInt team.lost
