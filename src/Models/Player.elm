module Models.Player exposing (..)

type alias PlayerId =
    { teamName : String
    , playerName : String
    }

type alias Player =
    { playerId : PlayerId
    , goalCount : Int
    }

type alias Players =
    { namedPlayerDataAvailable : Bool
    , players : List Player
    }

toTuple: PlayerId -> (String, String)
toTuple playerId =
    (playerId.teamName, playerId.playerName)


fromTuple: (String, String) -> PlayerId
fromTuple (teamName, playerName) =
    PlayerId teamName playerName


playerName : Player -> String
playerName player = 
    player.playerId.playerName


teamName : Player -> String
teamName player = 
    player.playerId.teamName

vanillaPlayerId : PlayerId
vanillaPlayerId = 
    PlayerId "" ""

vanillaPlayer : Player
vanillaPlayer = 
    Player vanillaPlayerId 0

vanillaPlayers : Players
vanillaPlayers = 
    Players False []
