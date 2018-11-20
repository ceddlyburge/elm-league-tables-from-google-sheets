module Pages.RenderPage exposing (renderPage)

import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.Components exposing (..)

renderPage: Device -> Page -> Html Msg
renderPage device page =
    let
        gaps = gapsForDevice device
    in
        body 
            device
            gaps  
            [
                renderHeaderBar gaps page.headerBar
                , page.body
            ]

renderHeaderBar: Gaps -> HeaderBar -> Element.Element Styles variation Msg
renderHeaderBar gaps headerBar = 
    heading
        gaps
        (List.map renderHeaderBarItem headerBar.leftItems
            ++ [ title headerBar.title ]
            ++ List.map renderHeaderBarItem headerBar.rightItems)


renderHeaderBarItem: HeaderBarItem -> Element.Element Styles variation Msg
renderHeaderBarItem headerBarItem =
    case headerBarItem of
        HeaderButtonSizedSpace ->
            el Hidden [ ] backIcon
        RefreshHeaderButton msg ->
            el TitleButton [ class "refresh", onClick msg ] refreshIcon