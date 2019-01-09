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
import Pages.Progressive exposing (..)

renderPage: Progressive -> Page -> Html Msg
renderPage progressive page =
    body 
        progressive  
        [
            renderHeaderBar progressive page.header
            , page.body
        ]

body: Progressive -> List (Element Styles variation msg) -> Html msg
body progressive elements = 
    Element.layout (stylesheet progressive.fontSize) <|         
        column 
            Body 
            [ width (percent 100), spacing progressive.mediumGap, center ]
            elements

renderHeaderBar: Progressive -> PageHeader -> Element.Element Styles variation Msg
renderHeaderBar progressive pageHeader = 
    case pageHeader of
        SingleHeader headerBar ->
            renderMainHeaderBar progressive headerBar
        DoubleHeader headerBar subHeaderBar ->
            renderMainAndSubHeaderBar progressive headerBar subHeaderBar

renderMainAndSubHeaderBar: Progressive -> HeaderBar -> SubHeaderBar -> Element.Element Styles variation Msg
renderMainAndSubHeaderBar progressive headerBar subHeaderBar =
    column 
        Title
        [ width (percent 100) ]
        [ renderMainHeaderBar progressive headerBar
          , renderSubHeaderBar progressive subHeaderBar ]


renderMainHeaderBar: Progressive -> HeaderBar -> Element.Element Styles variation Msg
renderMainHeaderBar progressive headerBar = 
    heading
        progressive
        (List.map renderHeaderBarItem headerBar.leftItems
            ++ [ title headerBar.title ]
            ++ List.map renderHeaderBarItem headerBar.rightItems)

renderSubHeaderBar: Progressive -> SubHeaderBar -> Element.Element Styles variation Msg
renderSubHeaderBar progressive subHeaderBar = 
    el 
        SubTitle 
        [ width (percent 100), padding progressive.mediumGap, verticalCenter ]
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

heading: Progressive -> List (Element Styles variation msg) -> Element.Element Styles variation msg
heading progressive elements = 
    row 
        Title 
        [ width (percent 100), padding progressive.bigGap, verticalCenter, center ] 
        [
            row 
                None 
                [ center, spacing progressive.bigGap, width (percent 100) ]
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
    Html.span [ Html.Attributes.class "data-test-resultsAndFixtures DecodeGoogleSheetToGameList fas fa-calendar-alt" ] []
        |> Element.html
