module LeagueStyleElements exposing (..)

import Color
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Element exposing (Device)

-- I didn't really want to use this, but I couldn't get a type definition to work without it
-- I should have documented which one this was, so I can do further investigation, or to 
-- know when I can delete this.
type Variations
    = NotApplicable

type Styles
    = None
    | Body
    | Hidden
    | Title
    | SubTitle
    | TitleButton
    | UnhappyPathText
    | LeagueListLeagueTitle
    | LeagueTableHeaderRow
    | LeagueTableTeamRow
    | ResultFixtureDayHeader
    | ResultFixtureRow
    | ResultFixtureHome
    | ResultFixtureAway
    | ResultFixtureScore
    | ResultFixtureTime

sansSerif : List Font
sansSerif =
    [ Font.font "Source Sans Pro"
    , Font.font "Trebuchet MS"
    , Font.font "Lucida Grande"
    , Font.font "Bitstream Vera Sans"
    , Font.font "Helvetica Neue"
    , Font.font "sans-serif"
    ]


colors :
    { secondary5 : Color.Color
    , secondary4 : Color.Color
    , secondary2 : Color.Color
    , text : Color.Color
    , titleText : Color.Color
    , subTitleText : Color.Color
    , heading1 : Color.Color
    , titleButton : Color.Color
    , titleBackground : Color.Color
    , subTitleBackground : Color.Color
    , border : Color.Color
    , transparent : Color.Color
    }

colors =
    { secondary5 = Color.rgba 7 25 48 1.0
    , secondary4 = Color.rgba 35 63 98 1.0
    , secondary2 = Color.rgba 139 162 190 1.0
    , text = Color.rgba 79 108 142 1.0 -- secondary 3
    , titleText = Color.rgba 4 38 45 1.0 -- primary 5
    , subTitleText = Color.rgba 7 25 48 1.0 -- primary 5
    , heading1 = Color.rgba 35 63 98 1.0 -- secondary 4
    , titleButton = Color.rgba 70 124 134 1.0 -- primary 3
    , titleBackground = Color.rgba 130 174 182 1.0 -- primary 2
    , subTitleBackground  = Color.rgba 215 226 241 1.0 -- secondeay 2 - 1
    , border = Color.rgba 215 227 241 1.0 -- secondary 1
    , transparent = Color.rgba 255 255 255 0 
    }

type alias FontSize =
    { big: Float
    , medium: Float
    , small: Float    
    }

calculatefontSize: Device -> FontSize
calculatefontSize device =
    if device.width <= 600 then
        { big = 24
        , medium = 14
        , small = 12    
        }
    else if device.width <= 1200 then
        { big = 29
        , medium = 19
        , small = 15    
        }
    else if device.width <= 1800 then
        { big = 34
        , medium = 25
        , small = 18    
        }
    else 
        { big = 48
        , medium = 32
        , small = 24    
        }


stylesheet : Device -> StyleSheet Styles variation
stylesheet device =
    let
        fontSize = calculatefontSize device     
    in
        Style.styleSheet
            [ style None []
            , style Title
                [ Color.background colors.titleBackground
                , Font.size fontSize.big
                , Font.center
                , Color.text colors.titleText
                ]
            , style SubTitle
                [ Color.background colors.subTitleBackground
                , Font.size fontSize.medium
                , Font.center
                , Color.text colors.titleText
                ]
            , style Body [ Font.typeface sansSerif ]
            , style Hidden [ 
                Color.background colors.transparent
                , Color.text colors.transparent
                ]
            , style TitleButton [ 
                Color.background colors.titleBackground
                , Color.text colors.titleButton
                , cursor "pointer"
                ]
            , style UnhappyPathText 
                [ Font.size fontSize.medium
                , Font.center
                , Color.text colors.text
                ]
            , style LeagueListLeagueTitle 
                [ Font.size fontSize.medium
                , Font.center
                , Color.text colors.text
                , Border.bottom 2
                , Color.border colors.border
                , cursor "pointer"
                ]
            , style LeagueTableHeaderRow
                [ Font.size fontSize.small
                , Color.text colors.text
                , Border.bottom 2
                , Color.border colors.border
                ]
            , style LeagueTableTeamRow
                [ Font.size fontSize.small
                , Color.text colors.text
                , Border.bottom 2
                , Color.border colors.border
                ]
            , style ResultFixtureDayHeader
                [ Font.size fontSize.small
                , Color.text colors.text
                , Border.bottom 2
                , Color.border colors.border
                ]
            , style ResultFixtureRow
                [ Font.size fontSize.medium 
                , Color.text colors.text
                ]
            , style ResultFixtureHome
                [ Font.alignRight
                ]
            , style ResultFixtureAway
                [ 
                ]
            , style ResultFixtureScore
                [ Font.bold
                ]
            , style ResultFixtureTime
                [ Font.bold
                ]
            ]