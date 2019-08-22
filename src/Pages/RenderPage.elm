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
import Pages.Responsive exposing (..)

renderPage: Responsive -> Page -> Html Msg
renderPage responsive page =
    body 
        responsive  
        [
            renderHeaderBar responsive page.header
            , page.body
        ]

body: Responsive -> List (Element Styles variation msg) -> Html msg
body responsive elements = 
    Element.layout (stylesheet responsive.fontSize) <|         
        column 
            Body 
            [ width <| bodyWidth responsive
            , spacingXY 0 responsive.mediumGap
            , center 
            , Element.Attributes.class "data-class-body"
            ]
            elements

-- 100% normally works better, as it takes into account a vertical scroll bar if there is one. 
-- If you just set a pixel width, it will be wider than the available width if there is a 
-- vertical scroll bar, and then yout get an annoying horizontal scroll bar as well.
-- If 100% is too small, then we can just use a percent value, as there is going to be a 
-- horizontal scroll bar anyway
bodyWidth : Responsive -> Length
bodyWidth responsive = 
    if responsive.pageWidth > responsive.viewportWidth then
        px responsive.pageWidth
    else
        percent 100

renderHeaderBar: Responsive -> PageHeader -> Element.Element Styles variation Msg
renderHeaderBar responsive pageHeader = 
    case pageHeader of
        SingleHeader headerBar ->
            renderMainHeaderBar responsive headerBar
        DoubleHeader headerBar subHeaderBar ->
            renderMainAndSubHeaderBar responsive headerBar subHeaderBar

renderMainAndSubHeaderBar: Responsive -> HeaderBar -> SubHeaderBar -> Element.Element Styles variation Msg
renderMainAndSubHeaderBar responsive headerBar subHeaderBar =
    column 
        Title
        [ width <| percent 100 ]
        [ renderMainHeaderBar responsive headerBar
          , renderSubHeaderBar responsive subHeaderBar ]


renderMainHeaderBar: Responsive -> HeaderBar -> Element.Element Styles variation Msg
renderMainHeaderBar responsive headerBar = 
    heading
        responsive
        (List.map renderHeaderBarItem headerBar.leftItems
            ++ [ title headerBar.title ]
            ++ List.map renderHeaderBarItem headerBar.rightItems)

renderSubHeaderBar: Responsive -> SubHeaderBar -> Element.Element Styles variation Msg
renderSubHeaderBar responsive subHeaderBar = 
    el 
        SubTitle 
        [ width <| percent 100
        , padding responsive.mediumGap
        , verticalCenter ]
        (text subHeaderBar.title)

renderHeaderBarItem: HeaderBarItem -> Element.Element Styles variation Msg
renderHeaderBarItem headerBarItem =
    case headerBarItem of
        HeaderButtonSizedSpace ->
            el Hidden [ ] backIcon
        RefreshHeaderButton msg ->
            el TitleButton [ Element.Attributes.class "data-test-refresh", onClick msg ] refreshIcon
        ResultsFixturesHeaderButton msg ->
            el TitleButton [ onClick msg ] resultsFixturesIcon
        BackHeaderButton msg ->
            el TitleButton [ onClick msg ] backIcon

heading: Responsive -> List (Element Styles variation msg) -> Element.Element Styles variation msg
heading responsive elements = 
    row 
        Title 
        [ width <| percent 100
        , padding responsive.bigGap
        , spacing responsive.bigGap
        , verticalCenter
        , center
        , Element.Attributes.class "data-class-heading"
        ] 
        elements

title: String -> Element.Element Styles variation msg
title titleText = 
    paragraph 
        Title
        [ Element.Attributes.class "data-test-title"
        , width fill ]
        [ text titleText ]


backIcon : Element style variation msg
backIcon =
    Html.span [ Html.Attributes.class "data-test-back fas fa-arrow-alt-circle-left" ] []
        |> Element.html

refreshIcon : Element style variation msg
refreshIcon =
    Html.span [ Html.Attributes.class "fas fa-sync-alt" ] []
        |> Element.html

resultsFixturesIcon : Element style variation msg
resultsFixturesIcon =
    Html.span [ Html.Attributes.class "data-test-resultsAndFixtures DecodeGoogleSheetToGameList fas fa-calendar-alt" ] []
        |> Element.html
