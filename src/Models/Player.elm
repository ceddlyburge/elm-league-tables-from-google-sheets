-- Should expose less things here, probably make some of the types opaque


module Models.Player exposing (..)

import Models.RealName exposing (..)


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
fromTuple ( teamName, playerName ) =
    PlayerId teamName playerName


player : PlayerId -> Int -> Player
player playerId goalCount =
    Player
        playerId
        goalCount
        (fromString playerId.playerName)


playerName : Player -> String
playerName player =
    player.playerId.playerName


teamName : Player -> String
teamName player =
    player.playerId.teamName


hasRealName : Player -> Bool
hasRealName player =
    Models.RealName.toBool player.realName


vanillaPlayerId : PlayerId
vanillaPlayerId =
    PlayerId "" ""


vanillaPlayer : Player
vanillaPlayer =
    Player vanillaPlayerId 0 NoName


vanillaPlayers : Players
vanillaPlayers =
    Players False []
