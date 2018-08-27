module LeagueStyleElements exposing (..)

import Color
import Style exposing (..)
import Style.Border as Border

import Style.Color as Color
import Style.Font as Font

type Styles
    = None
    | Body
    | Hidden
    | Title
    | TitleButton
    | LeagueListText
    | LeagueListLeagueTitle
    | LeagueTableTeams
    | LeagueTableTeamName
    | LeagueTablePoints
    | LeagueTableGamesPlayed
    | LeagueTableGoalDifference
    | LeagueTableGoalsFor
    | LeagueTableGoalsAgainst
    | Heading1
    | HeaderRow
    | DataRow

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
    , titleButton : Color.Color
    , titleBackground : Color.Color
    , border : Color.Color
    , transparent : Color.Color
    }

colors =
    { secondary5 = Color.rgba 7 25 48 1.0
    , secondary4 = Color.rgba 35 63 98 1.0
    , secondary2 = Color.rgba 139 162 190 1.0
    , text = Color.rgba 79 108 142 1.0 -- secondary 3
    , titleText = Color.rgba 4 38 45 1.0 -- primary 5
    , titleButton = Color.rgba 70 124 134 1.0 -- primary 3
    , titleBackground = Color.rgba 130 174 182 1.0 -- primary 2
    , border = Color.rgba 215 227 241 1.0 -- secondary 1
    , transparent = Color.rgba 255 255 255 0 
    }


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style None []
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
        , style LeagueListText  -- same as DataRow, make it in to a function / fix
            [ Font.size 25
            , Font.center
            , Color.text colors.text
            ]
        , style LeagueListLeagueTitle  -- same as DataRow, make it in to a function / fix
            [ Font.size 25
            , Font.center
            , Color.text colors.text
            , Border.bottom 2
            , Color.border colors.border
            , cursor "pointer"
            ]
        , style LeagueTableTeams []
        , style LeagueTableTeamName  []
        , style LeagueTablePoints  []
        , style LeagueTableGamesPlayed  []
        , style LeagueTableGoalDifference  []
        , style LeagueTableGoalsFor  []
        , style LeagueTableGoalsAgainst  []
        , style Title
            [ Color.background colors.titleBackground
            , Font.size 34
            , Font.center
            , Color.text colors.titleText
            ]
        , style Heading1
            [ Font.size 25
            , Color.text Color.brown
            , Border.bottom 2
            , Color.border colors.text
            ]
        , style HeaderRow
            [ Font.size 25
            , Color.text colors.text
            , Border.bottom 2
            , Color.border colors.border
            ]
        , style DataRow
            [ Font.size 25
            , Color.text colors.text
            , Border.bottom 2
            , Color.border colors.border
            ]
        ]