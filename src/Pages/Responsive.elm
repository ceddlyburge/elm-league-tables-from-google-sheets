module Pages.Responsive exposing (FontSize, Responsive, calculateResponsive, vanillaResponsive)

import Element exposing (Device, DeviceClass(..), Orientation(..))



-- Pixel widths, with one character spare, measured using https://codepen.io/jasesmith/pen/eBeoNz


type alias Responsive =
    { bigGap : Int
    , mediumGap : Int
    , smallGap : Int
    , viewportWidth : Int
    , pageWidth : Int
    , fontSize : FontSize

    -- designTeamWidths are the width that a team should ideally be able to be displayed on one line,
    -- "Blackwater_Bandits" is used as the text for this theoretical long team name. Team names
    -- longer than this can wrap or display an ellipsis. If pages need to wrap at shorter widths then
    -- that is ok too, it is a guide, not a rule
    , designTeamWidthMediumFont : Int

    -- designPlayerNameWidths are the width that a player name should ideally be able to be displayed
    -- on one line, "Anne Claire Chiffelou" is used as the text for this theoretical long team name.
    -- Names longer than this can wrap or display an ellipsis. If pages need to wrap at shorter widths
    -- then that is ok too, it is a guide, not a rule
    , designPlayerNameWidthBigFont : Int

    -- if the content is essentially portrait, try and extend out to this width
    , designPortraitWidth : Int
    }


type alias FontSize =
    { big : Int
    , medium : Int
    , small : Int
    }


calculateResponsive : Device -> Int -> Responsive
calculateResponsive device viewportWidth =
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
        , designPlayerNameWidthBigFont = 250
        , designPortraitWidth = calculatedesignPortraitWidth device 0.6 viewportWidth
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
        , designPlayerNameWidthBigFont = 300
        , designPortraitWidth = calculatedesignPortraitWidth device 0.6 viewportWidth
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
        , designPlayerNameWidthBigFont = 350
        , designPortraitWidth = calculatedesignPortraitWidth device 0.6 viewportWidth
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
        , designPlayerNameWidthBigFont = 500
        , designPortraitWidth = calculatedesignPortraitWidth device 0.6 viewportWidth
        }


calculatePageWidth : Int -> Int
calculatePageWidth viewportWidth =
    if viewportWidth < 250 then
        250

    else
        viewportWidth


calculatedesignPortraitWidth : Device -> Float -> Int -> Int
calculatedesignPortraitWidth device landscapePercentage viewportWidth =
    let
        pageWidth =
            calculatePageWidth viewportWidth
    in
    case device.orientation of
        Portrait ->
            pageWidth

        Landscape ->
            percentage landscapePercentage pageWidth


percentage : Float -> Int -> Int
percentage fraction total =
    fraction
        * toFloat total
        |> round


vanillaResponsive : Responsive
vanillaResponsive =
    calculateResponsive (Device Desktop Landscape) 1024
