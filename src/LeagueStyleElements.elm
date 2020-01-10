module LeagueStyleElements exposing (..)

import Pages.Responsive exposing (FontSize)
import Element.Border as Border
import Element.Font as Font
import Element exposing (Attribute, Color, rgba255)

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


-- stylesheet : FontSize -> StyleSheet Styles variation
-- stylesheet fontSize =
--     Style.styleSheet
--         [ style None []
--         , style Title
--             [ Color.background colors.titleBackground
--             , Font.size fontSize.big
--             , Font.center
--             , Color.text colors.titleText
--             ]
--         , style SubTitle
--             [ Color.background colors.subTitleBackground
--             , Font.size fontSize.medium
--             , Font.center
--             , Color.text colors.titleText
--             ]
--         , style Body [ Font.typeface sansSerif ]
--         , style Hidden
--             [ Color.background colors.transparent
--             , Color.text colors.transparent
--             ]
--         , style TitleButton
--             [ Color.background colors.titleBackground
--             , Color.text colors.titleButton
--             , cursor "pointer"
--             ]
--         , style UnhappyPathText
--             [ Font.size fontSize.medium
--             , Font.center
--             , Color.text colors.text
--             ]
--         , style LeagueListLeagueTitle
--             [ Font.size fontSize.medium
--             , Font.center
--             , Color.text colors.text
--             , Border.bottom 2
--             , Color.border colors.border
--             , cursor "pointer"
--             ]
--         , style LeagueTableHeaderRow
--             [ Font.size fontSize.small
--             , Color.text colors.text
--             , Border.bottom 2
--             , Color.border colors.border
--             ]
--         , style LeagueTableTeamRow
--             [ Font.size fontSize.small
--             , Color.text colors.text
--             , Border.bottom 2
--             , Color.border colors.border
--             ]
--         , style ResultFixtureDayHeader
--             [ Font.size fontSize.small
--             , Color.text colors.text
--             , Border.bottom 2
--             , Color.border colors.border
--             ]
--         , style ResultFixtureRow
--             [ Font.size fontSize.medium
--             , Color.text colors.text
--             ]
--         , style ResultFixtureHome
--             [ Font.alignRight
--             ]
--         , style ResultFixtureAway
--             []
--         , style ResultFixtureGoals
--             [ Font.size fontSize.small
--             , Color.text colors.supplementaryText
--             ]
--         , style ResultFixtureScore
--             [ Font.bold
--             ]
--         , style ResultFixtureTime
--             [ Font.bold
--             ]
--         , style TopScorerPlayerName
--             [ Font.size fontSize.big
--             ]
--         , style TopScorerTeamName
--             [ Font.size fontSize.medium
--             , Color.text colors.supplementaryText
--             ]
--         , style TopScorerGoalCount
--             [ Font.size fontSize.big
--             , Font.alignRight
--             , Color.text colors.supplementaryText
--             ]
--         ]
