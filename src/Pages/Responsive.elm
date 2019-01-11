module Pages.Responsive exposing (Responsive, FontSize, calculateResponsive, vanillaResponsive)

type alias Responsive =
    { bigGap: Float
    , mediumGap: Float
    , smallGap: Float
    , viewportWidth : Float
    , fontSize: FontSize
    , designTeamWidthMediumFont : Float
    , percentageWidthToUse : Float    
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
        , percentageWidthToUse = 95
        , fontSize = 
            { big = 24
            , medium = 14
            , small = 12    
            }
        , designTeamWidthMediumFont = 141  
        }
    else if viewportWidth <= 1200 then
        { bigGap = 18
        , mediumGap = 8
        , smallGap = 5    
        , viewportWidth = viewportWidth
        , fontSize = 
            { big = 29
            , medium = 19
            , small = 15    
            }
        , designTeamWidthMediumFont = 191  
        , percentageWidthToUse = 80
        }
    else if viewportWidth <= 1800 then
        { bigGap = 24
        , mediumGap = 10
        , smallGap = 6    
        , viewportWidth = viewportWidth
        , fontSize = 
            { big = 34
            , medium = 25
            , small = 18    
            }
        , designTeamWidthMediumFont = 252  
        , percentageWidthToUse = 60
        }
    else 
        { bigGap = 30
        , mediumGap = 13
        , smallGap = 8    
        , viewportWidth = viewportWidth
        , fontSize = 
            { big = 48
            , medium = 32
            , small = 24    
            }
        , designTeamWidthMediumFont = 322 
        , percentageWidthToUse = 60
        }

vanillaResponsive : Responsive
vanillaResponsive =
    calculateResponsive 1024.0 