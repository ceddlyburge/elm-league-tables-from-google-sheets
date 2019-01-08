module Pages.Progressive exposing (..)

import Element exposing (..)


type alias Progressive =
    { big: Float
    , medium: Float
    , small: Float
    , viewportWidth : Float
    , designTeamWidth : Float
    , percentageWidthToUse : Float    
    }

calculateProgressive : Device -> Progressive
calculateProgressive device =
    if device.phone then
        { big = 12
        , medium = 5
        , small = 3  
        , viewportWidth = device.width |> toFloat
        , designTeamWidth = 100  
        , percentageWidthToUse = 95
        }
    else 
        { big = 25
        , medium = 10
        , small = 7    
        , viewportWidth = device.width |> toFloat
        , designTeamWidth = 200  
        , percentageWidthToUse = 60
        }


