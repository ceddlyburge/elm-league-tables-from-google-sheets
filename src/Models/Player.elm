module Models.Player exposing (Player, vanillaPlayer)

type alias Player =
    { teamName : String
    , playerName : String
    , goalCount : Int
    }

vanillaPlayer : Player
vanillaPlayer = 
    Player "" "" 0
