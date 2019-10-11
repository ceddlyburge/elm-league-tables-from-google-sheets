module Pages.Responsive exposing (FontSize, Responsive, calculateResponsive, vanillaResponsive)

-- Pixel widths, with one character spare, measured using https://codepen.io/jasesmith/pen/eBeoNz


type alias Responsive =
    { bigGap : Float
    , mediumGap : Float
    , smallGap : Float
    , viewportWidth : Float
    , pageWidth : Float
    , fontSize : FontSize

    -- designTeamWidths are the width that a team should ideally be able to be displayed on one line,
    -- "Blackwater_Bandits" is used as the text for this theoretical long team name. Team names
    -- longer than this can wrap or display an ellipsis. If pages need to wrap at shorter widths then
    -- that is ok too, it is a guide, not a rule
    , designTeamWidthMediumFont : Float

    -- designTeamWidths are the width that a team should ideally be able to be displayed on one line,
    -- "Anne Claire Chiffelou" is used as the text for this theoretical long team name. Names
    -- longer than this can wrap or display an ellipsis. If pages need to wrap at shorter widths then
    -- that is ok too, it is a guide, not a rule
    , designPlayerNamePixelWidthBigFont : Float

    -- if the content is essentiallyl portrait, try and extend out to this percentage width
    , designPortraitPercentageWidth : Float
    }


type alias FontSize =
    { big : Float
    , medium : Float
    , small : Float
    }


calculateResponsive : Float -> Responsive
calculateResponsive viewportWidth =
    if viewportWidth <= 600 then
        { bigGap = 12
        , mediumGap = 5
        , smallGap = 3
        , viewportWidth = viewportWidth
        , pageWidth = calculatePageWidth viewportWidth
        , fontSize =
            { big = 24
            , medium = 14
            , small = 12
            }
        , designTeamWidthMediumFont = 141
        , designPlayerNamePixelWidthBigFont = 250
        , designPortraitPercentageWidth = 95
        }

    else if viewportWidth <= 1200 then
        { bigGap = 18
        , mediumGap = 8
        , smallGap = 5
        , viewportWidth = viewportWidth
        , pageWidth = calculatePageWidth viewportWidth
        , fontSize =
            { big = 29
            , medium = 19
            , small = 15
            }
        , designTeamWidthMediumFont = 191
        , designPlayerNamePixelWidthBigFont = 300
        , designPortraitPercentageWidth = 60
        }

    else if viewportWidth <= 1800 then
        { bigGap = 24
        , mediumGap = 10
        , smallGap = 6
        , viewportWidth = viewportWidth
        , pageWidth = calculatePageWidth viewportWidth
        , fontSize =
            { big = 34
            , medium = 25
            , small = 18
            }
        , designTeamWidthMediumFont = 252
        , designPlayerNamePixelWidthBigFont = 350
        , designPortraitPercentageWidth = 60
        }

    else
        { bigGap = 30
        , mediumGap = 13
        , smallGap = 8
        , viewportWidth = viewportWidth
        , pageWidth = calculatePageWidth viewportWidth
        , fontSize =
            { big = 48
            , medium = 32
            , small = 24
            }
        , designTeamWidthMediumFont = 322
        , designPlayerNamePixelWidthBigFont = 500
        , designPortraitPercentageWidth = 60
        }


calculatePageWidth : Float -> Float
calculatePageWidth viewportWidth =
    if viewportWidth < 200 then
        200

    else
        viewportWidth


vanillaResponsive : Responsive
vanillaResponsive =
    calculateResponsive 1024.0
