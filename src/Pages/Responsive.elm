module Pages.Responsive exposing (Responsive, FontSize, calculateResponsive, vanillaResponsive)

type alias Responsive =
    { bigGap: Float
    , mediumGap: Float
    , smallGap: Float
    , viewportWidth : Float
    , designTeamWidthMediumFont : Float
    , percentageWidthToUse : Float    
    , fontSize: FontSize
    }

type alias FontSize =
    { big: Float
    , medium: Float
    , small: Float    
    }

-- Pixel widths, with one character spare, measured using https://codepen.io/jasesmith/pen/eBeoNz
-- designTeamWidths are the width that a team should ideally be able to be displayed on one line,
-- "Blackwater_Bandits" is used as the text for this theoretical long team name. Team names 
-- longer than this can wrap or display an ellipsis. If pages need to wrap at shorter widths then
-- that is ok too, it is a guide, not a rule

calculateResponsive : Float -> Responsive
calculateResponsive viewportWidth =
    if viewportWidth <= 600 then
        { bigGap = 12
        , mediumGap = 5
        , smallGap = 3  
        , viewportWidth = viewportWidth
        -- 14px font 
        , designTeamWidthMediumFont = 141  
        , percentageWidthToUse = 95
        , fontSize = calculateFontSize viewportWidth
        }
    else if viewportWidth <= 1200 then
        { bigGap = 18
        , mediumGap = 8
        , smallGap = 5    
        , viewportWidth = viewportWidth
        -- 19px font
        , designTeamWidthMediumFont = 191  
        , percentageWidthToUse = 80
        , fontSize = calculateFontSize viewportWidth
        }
    else if viewportWidth <= 1800 then
        { bigGap = 24
        , mediumGap = 10
        , smallGap = 6    
        , viewportWidth = viewportWidth
        -- 25px font
        , designTeamWidthMediumFont = 252  
        , percentageWidthToUse = 60
        , fontSize = calculateFontSize viewportWidth
        }
    else 
        { bigGap = 30
        , mediumGap = 13
        , smallGap = 8    
        , viewportWidth = viewportWidth
        -- 32px font
        , designTeamWidthMediumFont = 322 
        , percentageWidthToUse = 60
        , fontSize = calculateFontSize viewportWidth
        }

calculateFontSize: Float -> FontSize
calculateFontSize width =
    if width <= 600 then
        { big = 24
        , medium = 14
        , small = 12    
        }
    else if width <= 1200 then
        { big = 29
        , medium = 19
        , small = 15    
        }
    else if width <= 1800 then
        { big = 34
        , medium = 25
        , small = 18    
        }
    else 
        { big = 48
        , medium = 32
        , small = 24    
        }

vanillaResponsive : Responsive
vanillaResponsive =
    calculateResponsive 1024.0 