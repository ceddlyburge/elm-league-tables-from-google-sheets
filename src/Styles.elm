module Styles exposing
    ( Attributes
    , Styles
    , createStyles
    , elWithStyle
    , paragraphWithStyle
    , rowWithStyle
    , sansSerifFontFamily
    )

import Element exposing (Attribute, Color, Element, Length, alignTop, el, fill, height, maximum, padding, paragraph, pointer, px, rgba255, row, spacing, spacingXY, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Msg exposing (Msg)
import Pages.Responsive exposing (Responsive)


type alias Attributes =
    List (Element.Attribute Msg)


type alias Styles =
    { responsive : Responsive
    , mainHeaderBar : Attributes
    , mainHeaderBarLink : Attributes
    , subHeaderBar : Attributes
    , unhappyPathText : Attributes
    , leagueListLeagueName : Attributes
    , leagueTableHeaderRow : Attributes
    , leagueTableTeamRow : Attributes
    , resultFixtureDayHeader : Attributes
    , resultFixtureRow : Attributes
    , resultFixtureGoals : Attributes
    , resultFixtureTime : Attributes
    , resultFixtureScore : Attributes
    , topScorerPlayerName : Attributes
    , topScorerGoalCount : Attributes
    , topScorerTeamName : Attributes
    , invisibleButTakesUpSpace : Attributes
    , fillToDesignPortraitWidth : Length
    , designPlayerNameWidthBigFont : Length
    , percentagePageWidth : Float -> Int
    , smallPadding : Attribute Msg
    , mediumPadding : Attribute Msg
    , bigPadding : Attribute Msg
    , smallSpacing : Attribute Msg
    , mediumSpacing : Attribute Msg
    , bigSpacing : Attribute Msg
    , mediumVerticalSpacing : Attribute Msg
    }


createStyles : Responsive -> Styles
createStyles responsive =
    Styles
        responsive
        (mainHeaderBar responsive)
        (mainHeaderBarLink responsive)
        (subHeaderBar responsive)
        (unhappyPathText responsive)
        (leagueListLeagueName responsive)
        (leagueTableHeaderRow responsive)
        (leagueTableTeamRow responsive)
        (resultFixtureDayHeader responsive)
        (resultFixtureRow responsive)
        (resultFixtureGoals responsive)
        resultFixtureScore
        resultFixtureTime
        (topScorerPlayerName responsive)
        (topScorerGoalCount responsive)
        (topScorerTeamName responsive)
        invisibleButTakesUpSpace
        (fill |> maximum responsive.designPortraitWidth)
        (px responsive.designPlayerNameWidthBigFont)
        (\percentage -> round (toFloat responsive.pageWidth * percentage))
        (padding responsive.smallGap)
        (padding responsive.mediumGap)
        (padding responsive.bigGap)
        (spacing responsive.smallGap)
        (spacing responsive.mediumGap)
        (spacing responsive.bigGap)
        (spacingXY 0 responsive.mediumGap)


elWithStyle : Attributes -> Attributes -> Element Msg -> Element Msg
elWithStyle styleAttributes layoutAttributes child =
    el
        (styleAttributes ++ layoutAttributes)
        child


rowWithStyle : Attributes -> Attributes -> List (Element Msg) -> Element Msg
rowWithStyle styleAttributes layoutAttributes children =
    row
        (styleAttributes ++ layoutAttributes)
        children


paragraphWithStyle : Attributes -> Attributes -> List (Element Msg) -> Element Msg
paragraphWithStyle styleAttributes layoutAttributes children =
    paragraph
        (styleAttributes ++ layoutAttributes)
        children


mainHeaderBar : Responsive -> List (Element.Attribute msg)
mainHeaderBar responsive =
    [ Background.color colors.titleBackground
    , Font.size responsive.fontSize.big
    , Font.center
    , Font.color colors.titleText
    ]


mainHeaderBarLink : Responsive -> List (Element.Attribute msg)
mainHeaderBarLink responsive =
    [ Background.color colors.titleBackground
    , Font.color colors.titleButton
    , height fill
    , width (px responsive.fontSize.big)
    , pointer
    ]


subHeaderBar : Responsive -> List (Element.Attribute msg)
subHeaderBar responsive =
    [ Background.color colors.subTitleBackground
    , Font.size responsive.fontSize.medium
    , Font.center
    , Font.color colors.titleText
    ]


unhappyPathText : Responsive -> List (Element.Attribute msg)
unhappyPathText responsive =
    [ Font.size responsive.fontSize.medium
    , Font.center
    , Font.color colors.supplementaryText
    ]


invisibleButTakesUpSpace : List (Element.Attribute msg)
invisibleButTakesUpSpace =
    [ Background.color colors.transparent
    , Font.color colors.transparent
    ]


leagueListLeagueName : Responsive -> Attributes
leagueListLeagueName responsive =
    [ Font.size responsive.fontSize.medium
    , Font.center
    , Font.color colors.text
    , Border.widthEach
        { bottom = 2
        , left = 0
        , right = 0
        , top = 0
        }
    , Border.color colors.border
    , pointer
    ]


leagueTableHeaderRow : Responsive -> List (Element.Attribute msg)
leagueTableHeaderRow responsive =
    [ Font.size responsive.fontSize.small
    , Font.color colors.text
    , Border.widthEach
        { bottom = 2
        , left = 0
        , right = 0
        , top = 0
        }
    , Border.color colors.border
    ]


leagueTableTeamRow : Responsive -> List (Element.Attribute msg)
leagueTableTeamRow responsive =
    [ Font.size responsive.fontSize.small
    , Font.color colors.text
    , Border.widthEach
        { bottom = 2
        , left = 0
        , right = 0
        , top = 0
        }
    , Border.color colors.border
    ]


resultFixtureDayHeader : Responsive -> List (Element.Attribute msg)
resultFixtureDayHeader responsive =
    [ Font.size responsive.fontSize.small
    , Font.color colors.text
    , Border.widthEach
        { bottom = 2
        , left = 0
        , right = 0
        , top = 0
        }
    , Border.color colors.border
    ]


resultFixtureRow : Responsive -> List (Element.Attribute msg)
resultFixtureRow responsive =
    [ Font.size responsive.fontSize.medium
    , Font.color colors.text
    ]


resultFixtureGoals : Responsive -> List (Element.Attribute msg)
resultFixtureGoals responsive =
    [ Font.size responsive.fontSize.small
    , Font.color colors.supplementaryText
    ]


resultFixtureScore : List (Element.Attribute msg)
resultFixtureScore =
    [ Font.bold
    , alignTop
    ]


resultFixtureTime : List (Element.Attribute msg)
resultFixtureTime =
    [ Font.bold ]


topScorerPlayerName : Responsive -> List (Element.Attribute msg)
topScorerPlayerName responsive =
    [ Font.size responsive.fontSize.big ]


topScorerTeamName : Responsive -> List (Element.Attribute msg)
topScorerTeamName responsive =
    [ Font.size responsive.fontSize.medium
    , Font.color colors.supplementaryText
    ]


topScorerGoalCount : Responsive -> List (Element.Attribute msg)
topScorerGoalCount responsive =
    [ Font.size responsive.fontSize.big
    , Font.alignRight
    , Font.color colors.supplementaryText
    ]


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
    { secondary5 = rgba255 7 25 48 1.0
    , secondary4 = rgba255 35 63 98 1.0
    , secondary2 = rgba255 139 162 190 1.0
    , text = rgba255 79 108 142 1.0 -- secondary 3
    , supplementaryText = rgba255 150 109 44 1.0 -- secondary-2-3
    , titleText = rgba255 4 38 45 1.0 -- primary 5
    , subTitleText = rgba255 7 25 48 1.0 -- primary 5
    , heading1 = rgba255 35 63 98 1.0 -- secondary 4
    , titleButton = rgba255 70 124 134 1.0 -- primary 3
    , titleBackground = rgba255 130 174 182 1.0 -- primary 2
    , subTitleBackground = rgba255 215 226 241 1.0 -- secondeay 2 - 1
    , border = rgba255 215 227 241 1.0 -- secondary 1
    , transparent = rgba255 255 255 255 0
    }


sansSerifFontFamily : Attribute msg
sansSerifFontFamily =
    Font.family
        [ Font.typeface "Source Sans Pro"
        , Font.typeface "Trebuchet MS"
        , Font.typeface "Lucida Grande"
        , Font.typeface "Bitstream Vera Sans"
        , Font.typeface "Helvetica Neue"
        , Font.sansSerif
        ]
