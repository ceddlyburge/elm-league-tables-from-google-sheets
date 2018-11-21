module Pages.RenderPage exposing (renderPage)

import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import Html.Attributes exposing (class)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.Gaps exposing (..)

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
        SingleHeader headerBar ->
            renderMainHeaderBar gaps headerBar
        DoubleHeader headerBar subHeaderBar ->
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
            el TitleButton [ Element.Attributes.class "refresh", onClick msg ] refreshIcon
        ResultsFixturesHeaderButton msg ->
            el TitleButton [ onClick msg ] resultsFixturesIcon
        BackHeaderButton msg ->
            el TitleButton [ onClick msg ] backIcon

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
