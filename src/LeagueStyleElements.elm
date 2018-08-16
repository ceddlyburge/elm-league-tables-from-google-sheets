module LeagueStyleElements exposing (..)

import Html
import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (..)
import Style exposing (..)
import Style.Border as Border
import Style.Background as Background
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow
import Style.Transition as Transition

type Styles
    = None
    | Title
    | TitleButton
    | LeagueListLeagueTitle
    | LeagueTable
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
    [ Font.font "helvetica"
    , Font.font "arial"
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
    }


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style None []
        , style TitleButton [ 
            Color.background colors.titleBackground
            , Color.text colors.titleButton
            ]
        , style LeagueListLeagueTitle  -- same as DataRow, probably make it in to a function
            [ Font.size 25
            , Color.text colors.text
            , Border.bottom 2
            , Color.border colors.border
            ]
        , style LeagueTable []
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