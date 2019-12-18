module Styles exposing (..)

import Pages.Responsive exposing (Responsive, FontSize)
import Element.Border as Border
import Element.Font as Font
import Element.Background as Background
import Element exposing (Attribute, Color, rgba255)


mainHeaderBar: Responsive ->  List (Element.Attribute msg)
mainHeaderBar responsive = 
    [ Background.color colors.titleBackground
    , Font.size responsive.fontSize.big 
    , Font.center
    , Font.color colors.titleText
    ]

mainHeaderBarLink: List (Element.Attribute msg)
mainHeaderBarLink = 
    [ Background.color colors.titleBackground
    , Font.color colors.titleButton
    --, cursor "pointer"
    ]

invisibleButTakesUpSpace: List (Element.Attribute msg)
invisibleButTakesUpSpace = 
    [ Background.color colors.transparent
    , Font.color colors.transparent
    ]

ceddRgba: Int -> Int -> Int -> Float -> Color
ceddRgba r g b a =
    rgba255 r g b a


colors :
    { secondary5 : Color
    , secondary4 : Color
    , secondary2 : Color
    , text : Color
    , supplementaryText : Color
    , titleText : Color
    , subTitleText : Color
    , heading1 : Color
    , titleButton : Color
    , titleBackground : Color
    , subTitleBackground : Color
    , border : Color
    , transparent : Color
    }
colors =
    { secondary5 = ceddRgba 7 25 48 1.0
    , secondary4 = ceddRgba 35 63 98 1.0
    , secondary2 = ceddRgba 139 162 190 1.0
    , text = ceddRgba 79 108 142 1.0 -- secondary 3
    , supplementaryText = ceddRgba 150 109 44 1.0 -- secondary-2-3
    , titleText = ceddRgba 4 38 45 1.0 -- primary 5
    , subTitleText = ceddRgba 7 25 48 1.0 -- primary 5
    , heading1 = ceddRgba 35 63 98 1.0 -- secondary 4
    , titleButton = ceddRgba 70 124 134 1.0 -- primary 3
    , titleBackground = ceddRgba 130 174 182 1.0 -- primary 2
    , subTitleBackground = ceddRgba 215 226 241 1.0 -- secondeay 2 - 1
    , border = ceddRgba 215 227 241 1.0 -- secondary 1
    , transparent = ceddRgba 255 255 255 0
    }
