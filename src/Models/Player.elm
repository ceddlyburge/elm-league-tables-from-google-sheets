-- Should expose less things here, probably make some of the types opaque


module Models.Player exposing (Player, PlayerId, Players, fromTuple, hasRealName, player, playerName, teamName, toTuple)

import Models.RealName exposing (RealName, fromString)


type alias PlayerId =
    { teamName : String
    , playerName : String
    }


type alias Player =
    { playerId : PlayerId
    , goalCount : Int
    , realName : RealName
    }


type alias Players =
    { namedPlayerDataAvailable : Bool
    , players : List Player
    }


toTuple : PlayerId -> ( String, String )
toTuple playerId =
    ( playerId.teamName, playerId.playerName )


fromTuple : ( String, String ) -> PlayerId
fromTuple ( aTeamName, aPlayerName ) =
    PlayerId aTeamName aPlayerName


player : PlayerId -> Int -> Player
player playerId goalCount =
    Player
        playerId
        goalCount
        (fromString playerId.playerName)


playerName : Player -> String
playerName aPlayer =
    aPlayer.playerId.playerName


teamName : Player -> String
teamName aPlayer =
    aPlayer.playerId.teamName


hasRealName : Player -> Bool
hasRealName aPlayer =
    Models.RealName.toBool aPlayer.realName
