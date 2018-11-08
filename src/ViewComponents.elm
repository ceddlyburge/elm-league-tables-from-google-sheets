module ViewComponents exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (class)
import Element exposing (..)
import Element.Attributes exposing (..)
import LeagueStyleElements exposing (..)

type alias Gaps =
    { big: Float
    , medium: Float
    , small: Float
    , percentageWidthToUse : Float    
    }

gapsForDevice : Device -> Gaps
gapsForDevice device =
    if device.phone then
        { big = 12
        , medium = 5
        , small = 3    
        , percentageWidthToUse = 95
        }
    else 
        { big = 25
        , medium = 10
        , small = 7    
        , percentageWidthToUse = 60
        }

backIcon : Element style variation msg
backIcon =
    Html.span [ Html.Attributes.class "fas fa-arrow-alt-circle-left" ] []
        |> Element.html

refreshIcon : Element style variation msg
refreshIcon =
    Html.span [ Html.Attributes.class "fas fa-sync-alt" ] []
        |> Element.html

resultsFixturesIcon : Element style variation msg
resultsFixturesIcon =
    Html.span [ Html.Attributes.class "resultsAndFixtures DecodeGoogleSheetToGameList fas fa-calendar-alt" ] []
        |> Element.html

-- It is nice to wait before showing the loading animation, to avoid Jank
-- style-elements doesn't really support this, so using standard html / css
loading: Element style variation msg
loading =
    Html.div 
        [ Html.Attributes.class "loading" ] 
        [
            Html.div 
                [ Html.Attributes.class "la-ball-newton-cradle la-3x" ] 
                [
                    Html.div [] []
                    , Html.div [] []
                    , Html.div [] []
                    , Html.div [] []
                ]
        ]
    |> Element.html

unhappyPathText: String -> Element Styles variation msg
unhappyPathText string =
    paragraph UnhappyPathText [ width (percent 90) ] [ text string ]
