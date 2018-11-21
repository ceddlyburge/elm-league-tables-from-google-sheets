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
                renderHeaderBar gaps page.header
                , page.body
            ]

renderHeaderBar: Gaps -> PageHeader -> Element.Element Styles variation Msg
renderHeaderBar gaps pageHeader = 
    case pageHeader of
        Single headerBar ->
            renderMainHeaderBar gaps headerBar
        Double headerBar subHeaderBar ->
            renderMainAndSubHeaderBar gaps headerBar subHeaderBar

renderMainAndSubHeaderBar: Gaps -> HeaderBar -> SubHeaderBar -> Element.Element Styles variation Msg
renderMainAndSubHeaderBar gaps headerBar subHeaderBar =
    column 
        Title
        [ width (percent 100) ]
        [ renderMainHeaderBar gaps headerBar
          , renderSubHeaderBar gaps subHeaderBar ]


renderMainHeaderBar: Gaps -> HeaderBar -> Element.Element Styles variation Msg
renderMainHeaderBar gaps headerBar = 
    heading
        gaps
        (List.map renderHeaderBarItem headerBar.leftItems
            ++ [ title headerBar.title ]
            ++ List.map renderHeaderBarItem headerBar.rightItems)

renderSubHeaderBar: Gaps -> SubHeaderBar -> Element.Element Styles variation Msg
renderSubHeaderBar gaps subHeaderBar = 
    el 
        SubTitle 
        [ width (percent 100), padding gaps.medium, verticalCenter ]
        (text subHeaderBar.title)

renderHeaderBarItem: HeaderBarItem -> Element.Element Styles variation Msg
renderHeaderBarItem headerBarItem =
    case headerBarItem of
        HeaderButtonSizedSpace ->
            el Hidden [ ] backIcon
        RefreshHeaderButton msg ->
            el TitleButton [ class "refresh", onClick msg ] refreshIcon
        ResultsFixturesHeaderButton msg ->
            el TitleButton [ onClick msg ] resultsFixturesIcon
        BackHeaderButton msg ->
            el TitleButton [ onClick msg ] backIcon