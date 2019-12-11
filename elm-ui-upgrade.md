Upgrade to elm-ui

Update package
- "mdgriffith/style-elements": "5.0.1",
+ "mdgriffith/elm-ui": "1.1.5",

Change imports
- 
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Element.Attributes exposing (..)

+ 
import Element.Border as Border
import Element.Font as Font
import Element exposing (Attribute, Color, rgba255)

Remove stylesheet function (that returns `Stylesheet Styles variation`)

If you have a fontFamily style function, that returns List Font, change it to use Font.family and return Attribute msg

Change function signatures
- Element Styles variation msg
+ Element msg

Remove style parameter
- paragraph UnhappyPathText [ width (fillPortion 90) ] [ text string ]
+ paragraph [ width (fillPortion 90) ] [ text string ]

Change width percent
it becomes fill or fillPortion now

Change class
- class "blah"
+ htmlAttribute (Html.Attributes.class "blah")

Change attributes
- center, verticalCenter
+ centerX, centerY

Change padding and spacing calls
padding and spacing take Int instead of Float
fillPortion same, presumablyl between 0 and 1
fa
probably others

Element.layout takes a list of attributes instead of a StyleSheet