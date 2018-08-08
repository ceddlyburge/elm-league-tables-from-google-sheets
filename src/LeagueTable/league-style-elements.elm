module MyElements exposing (..)

import Html exposing (Html)
import Html.Attributes
import Style exposing (..)
import Style.Elements exposing (element, elementAs, build)
import Color exposing (Color)


--------------------
-- Define Base Style
--------------------


base : Style.Model
base =
    { empty
        | colors =
            { background = Color.rgba 255 255 255 0
            , text = Color.rgb 17 17 17
            , border = Color.rgb 230 230 230
            }
        , text =
            { font = "Georgia"
            , size = 18
            , lineHeight = 1.7
            , characterOffset = Nothing
            , align = alignLeft
            , whitespace = normal
            }
    }


blue : Color
blue =
    Color.rgba 12 148 200 1



--------------------
-- Define Elements
--------------------
-- container


centered : List (Html.Attribute a) -> List (Element a) -> Html a
centered =
    build
        { base
            | padding = topBottom 100
            , layout =
                flowRight
                    { wrap = True
                    , horizontal = alignCenter
                    , vertical = alignTop
                    }
        }


pirateContent : List (Html.Attribute a) -> List (Element a) -> Element a
pirateContent =
    element
        { base
            | width = px 700
            , padding = all 20
            , spacing = all 40
            , layout =
                textLayout
        }


sidebar : List (Html.Attribute a) -> List (Element a) -> Element a
sidebar =
    element
        { base
            | width = px 300
            , padding = all 20
            , spacing = topBottom 40
            , layout =
                textLayout
        }


p : List (Html.Attribute a) -> List (Element a) -> Element a
p =
    elementAs "p"
        { base | spacing = all 20 }


title : List (Html.Attribute a) -> List (Element a) -> Element a
title =
    elementAs "h1"
        { base
            | text =
                { font = "Georgia"
                , size = 24
                , lineHeight = 1.4
                , characterOffset = Nothing
                , align = alignLeft
                , whitespace = normal
                }
        }


box : List (Html.Attribute a) -> List (Element a) -> Element a
box =
    element
        { base
            | width = px 180
            , height = px 180
            , padding = all 20
            , colors =
                { background = blue
                , text = Color.white
                , border = Color.rgb 230 230 230
                }
        }



-------------------
-- Table Creation
-------------------


{-| -}
table : List (Html.Attribute msg) -> List (Element msg) -> Element msg
table =
    elementAs "table"
        { empty
            | layout = Style.tableLayout
        }


{-| -}
row : List (Html.Attribute msg) -> List (Element msg) -> Element msg
row =
    elementAs "tr" empty


{-| -}
tableHeader : List (Html.Attribute msg) -> List (Element msg) -> Element msg
tableHeader =
    elementAs "th"
        { empty
            | padding = all 10
            , borderStyle = solid
            , borderWidth = all 1
            , cornerRadius = all 0
        }


{-| -}
cell : List (Html.Attribute msg) -> List (Element msg) -> Element msg
cell =
    elementAs "td"
        { empty
            | padding = all 10
            , borderStyle = solid
            , borderWidth = all 1
            , cornerRadius = all 0
        }


{-| -}
button : List (Html.Attribute msg) -> List (Element msg) -> Element msg
button =
    elementAs "button" empty



---------------
-- Text Markup
--
-- These are defined as basic html and not as elements because we want them to be context aware
-- (i.e. we want the parent to decide what font to use).
-- Instead of having a unique italics element for everywhere we want italics, we can just have one which will use the fontsize/properties of the elements around it.
--
-- The class "inline" means that it will ignore the spacing set for it by the parent.  This is generally desired for inline elements.
---------------


br : Element msg
br =
    Style.Elements.html <|
        Html.br [ Html.Attributes.class "inline" ] []


text : String -> Element msg
text str =
    Style.Elements.html <| Html.text str


{-| Italicize text
-}
i : String -> Element msg
i str =
    Style.Elements.html <|
        Html.i
            [ Html.Attributes.class "inline"
            ]
            [ Html.text str ]


{-| Bold text
-}
b : String -> Element msg
b str =
    Style.Elements.html <|
        Html.b
            [ Html.Attributes.class "inline"
            ]
            [ Html.text str ]


{-| Strike-through text
-}
s : String -> Element msg
s str =
    Style.Elements.html <|
        Html.s
            [ Html.Attributes.class "inline"
            ]
            [ Html.text str ]


{-| Underline text
-}
u : String -> Element msg
u str =
    Style.Elements.html <|
        Html.u
            [ Html.Attributes.class "inline"
            ]
            [ Html.text str ]


{-| Underline text
-}
sub : String -> Element msg
sub str =
    Style.Elements.html <|
        Html.sub
            [ Html.Attributes.class "inline"
            ]
            [ Html.text str ]


{-| Underline text
-}
sup : String -> Element msg
sup str =
    Style.Elements.html <|
        Html.sup
            [ Html.Attributes.class "inline"
            ]
            [ Html.text str ]


{-| A dividing line rendered as an 'hr' element
-}
divider : Element msg
divider =
    Style.Elements.html <|
        Html.hr
            [ Html.Attributes.style
                [ ( "height", "1px" )
                , ( "border", "none" )
                , ( "background-color", "#ddd" )
                ]
            , Html.Attributes.class "inline"
            ]
            []



-----------------------------------------
-- Convenience elements for setting float
-----------------------------------------


{-| Float a single element to the left
-}
floatLeft : Element a -> Element a
floatLeft floater =
    element
        { empty
            | float = Just Style.floatLeft
        }
        []
        [ floater ]


{-|
-}
floatRight : Element a -> Element a
floatRight floater =
    element
        { empty
            | float = Just Style.floatRight
        }
        []
        [ floater ]


{-| Float a single element to the left.  "topLeft" means it will ignore top spacing that the parent specifies and use 0px insteas.
-}
floatTopLeft : Element a -> Element a
floatTopLeft floater =
    element
        { empty
            | float = Just Style.floatTopLeft
        }
        []
        [ floater ]


{-|
-}
floatTopRight : Element a -> Element a
floatTopRight floater =
    element
        { empty
            | float = Just Style.floatTopRight
        }
        []
[ floater ]