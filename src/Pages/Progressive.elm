module Pages.Progressive exposing (..)



type alias Progressive =
    { big: Float
    , medium: Float
    , small: Float
    , viewportWidth : Float
    , designTeamWidthMediumFont : Float
    , percentageWidthToUse : Float    
    }

-- Pixel widths, with one character spare, measured using https://codepen.io/jasesmith/pen/eBeoNz
-- designTeamWidths are the width that a team should ideally be able to be displayed on one line,
-- "Blackwater_Bandits" is used as the text for this theoretical long team name. Team names 
-- longer than this can wrap or display an ellipsis. If pages need to wrap at shorter widths then
-- that is ok too, it is a guide, not a rule

calculateProgressive : Float -> Progressive
calculateProgressive viewportWidth =
    if viewportWidth <= 600 then
        { big = 12
        , medium = 5
        , small = 3  
        , viewportWidth = viewportWidth
        -- 14px font 
        , designTeamWidthMediumFont = 141  
        , percentageWidthToUse = 95
        }
    else if viewportWidth <= 1200 then
        { big = 18
        , medium = 8
        , small = 5    
        , viewportWidth = viewportWidth
        -- 19px font
        , designTeamWidthMediumFont = 191  
        , percentageWidthToUse = 80
        }
    else if viewportWidth <= 1800 then
        { big = 24
        , medium = 10
        , small = 6    
        , viewportWidth = viewportWidth
        -- 25px font
        , designTeamWidthMediumFont = 252  
        , percentageWidthToUse = 60
        }
    else 
        { big = 30
        , medium = 13
        , small = 8    
        , viewportWidth = viewportWidth
        -- 32px font
        , designTeamWidthMediumFont = 322 
        , percentageWidthToUse = 60
        }
