module LeagueStyleElements exposing (..)

import Pages.Responsive exposing (FontSize)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font



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
    | ResultFixtureGoals
    | ResultFixtureScore
    | ResultFixtureTime
    | TopScorerPlayerName
    | TopScorerTeamName
    | TopScorerGoalCount


sansSerif : List Font
sansSerif =
    [ Font.font "Source Sans Pro"
    , Font.font "Trebuchet MS"
    , Font.font "Lucida Grande"
    , Font.font "Bitstream Vera Sans"
    , Font.font "Helvetica Neue"
    , Font.font "sans-serif"
    ]

ceddRgba: Float -> Float -> Float -> Float -> Style.Color
ceddRgba r g b a =
    rgba (r / 255) (g / 255) (b / 255) a


colors :
    { secondary5 : Style.Color
    , secondary4 : Style.Color
    , secondary2 : Style.Color
    , text : Style.Color
    , supplementaryText : Style.Color
    , titleText : Style.Color
    , subTitleText : Style.Color
    , heading1 : Style.Color
    , titleButton : Style.Color
    , titleBackground : Style.Color
    , subTitleBackground : Style.Color
    , border : Style.Color
    , transparent : Style.Color
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


stylesheet : FontSize -> StyleSheet Styles variation
stylesheet fontSize =
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
        , style Hidden
            [ Color.background colors.transparent
            , Color.text colors.transparent
            ]
        , style TitleButton
            [ Color.background colors.titleBackground
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
            []
        , style ResultFixtureGoals
            [ Font.size fontSize.small
            , Color.text colors.supplementaryText
            ]
        , style ResultFixtureScore
            [ Font.bold
            ]
        , style ResultFixtureTime
            [ Font.bold
            ]
        , style TopScorerPlayerName
            [ Font.size fontSize.big
            ]
        , style TopScorerTeamName
            [ Font.size fontSize.medium
            , Color.text colors.supplementaryText
            ]
        , style TopScorerGoalCount
            [ Font.size fontSize.big
            , Font.alignRight
            , Color.text colors.supplementaryText
            ]
        ]
