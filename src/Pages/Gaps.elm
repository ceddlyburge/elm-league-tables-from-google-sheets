module Pages.Gaps exposing (..)

import Element exposing (..)


type alias Gaps =
    { big: Float
    , medium: Float
    , small: Float
    , percentageWidthToUse : Float    
    }

gapsForDevice : Device -> Gaps
gapsForDevice device =
    if device.phone then
        { big = 12
        , medium = 5
        , small = 3    
        , percentageWidthToUse = 95
        }
    else 
        { big = 25
        , medium = 10
        , small = 7    
        , percentageWidthToUse = 60
        }


