module Pages.Components exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (class)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import LeagueStyleElements exposing (..)
import Msg exposing (..)

type alias Scaffold =
    { body: List (Element Styles Variations Msg) -> Html Msg
    , heading: List (Element Styles Variations Msg) -> Element.Element Styles Variations Msg
    , titleButtonSizedSpace: Element.Element Styles Variations Msg
    , title: String -> Element.Element Styles Variations Msg
    , refreshTitleButton: Msg -> Element.Element Styles Variations Msg
    }


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

body: Device -> Gaps -> List (Element Styles variation msg) -> Html msg
body device gaps elements = 
    Element.layout (stylesheet device) <|         
        column 
            Body 
            [ width (percent 100), spacing gaps.big, center ]
            elements

heading: Gaps -> List (Element Styles variation msg) -> Element.Element Styles variation msg
heading gaps elements = 
    row 
        Title 
        [ width (percent 100), padding gaps.big, verticalCenter, center ] 
        [
            row 
                None 
                [ center, spacing gaps.big, width (percent 100) ]
                elements
        ]

title: String -> Element.Element Styles variation msg
title titleText = 
    el Title [ width fill ] (text titleText)

titleButtonSizedSpace: Element.Element Styles variation msg
titleButtonSizedSpace = 
    el Hidden [ ] backIcon

refreshTitleButton: Msg -> Element.Element Styles variation Msg
refreshTitleButton msg = 
    el TitleButton [ Element.Attributes.class "refresh", onClick msg ] refreshIcon

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
