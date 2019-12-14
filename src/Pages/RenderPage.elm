module Pages.RenderPage exposing (renderPage, renderTestablePage)

import Element exposing (..)
--import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import Html exposing (Html)
import Html.Attributes exposing (class)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import Pages.ViewHelpers exposing (..)
import Browser exposing (Document)
import Element.Font exposing (..)


renderPage : Responsive -> Page -> Document Msg
renderPage responsive page =
    Document
        "League Tables"
        [ renderTestablePage responsive page]


-- This is an annoyance, but the html test package doesn't want to work with lists really
renderTestablePage : Responsive -> Page -> Html Msg
renderTestablePage responsive page =
    body
        responsive
        [ renderHeaderBar responsive page.header
        , page.body
        ]

body : Responsive -> List (Element msg) -> Html msg
body responsive elements =
    Element.layout [] <| --(stylesheet responsive.fontSize) <|
        column
            --Body
            [ sansSerifFontFamily
            , width <| bodyWidth responsive
            , spacingXY 0 responsive.mediumGap
            , centerX --center
            , dataTestClass "body"
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
        fill


renderHeaderBar : Responsive -> PageHeader -> Element.Element Msg
renderHeaderBar responsive pageHeader =
    case pageHeader of
        SingleHeader headerBar ->
            renderMainHeaderBar responsive headerBar

        DoubleHeader headerBar subHeaderBar ->
            renderMainAndSubHeaderBar responsive headerBar subHeaderBar


renderMainAndSubHeaderBar : Responsive -> HeaderBar -> SubHeaderBar -> Element.Element Msg
renderMainAndSubHeaderBar responsive headerBar subHeaderBar =
    column
        --Title
        [ width fill ]
        [ renderMainHeaderBar responsive headerBar
        , renderSubHeaderBar responsive subHeaderBar
        ]


renderMainHeaderBar : Responsive -> HeaderBar -> Element.Element Msg
renderMainHeaderBar responsive headerBar =
    heading
        responsive
        (List.map renderHeaderBarItem headerBar.leftItems
            ++ [ title headerBar.title ]
            ++ List.map renderHeaderBarItem headerBar.rightItems
        )


renderSubHeaderBar : Responsive -> SubHeaderBar -> Element.Element msg
renderSubHeaderBar responsive subHeaderBar =
    el
        --SubTitle
        [ width fill
        , padding responsive.mediumGap
        , centerY --verticalCenter
        ]
        (text subHeaderBar.title)


renderHeaderBarItem : HeaderBarItem -> Element.Element Msg
renderHeaderBarItem headerBarItem =
    case headerBarItem of
        HeaderButtonSizedSpace ->
            el 
                --Hidden 
                [] 
                backIcon

        RefreshHeaderButton msg ->
            el 
                --TitleButton 
                [ dataTestClass "refresh", onClick msg ] 
                refreshIcon

        ResultsFixturesHeaderButton msg ->
            el 
                --TitleButton 
                [ onClick msg ] 
                resultsFixturesIcon

        TopScorersHeaderButton msg namedPlayerDataAvailable ->
            topScorerHeaderBarItem msg namedPlayerDataAvailable

        BackHeaderButton msg ->
            el --TitleButton 
                [ onClick msg ] 
                backIcon


topScorerHeaderBarItem : Msg -> Bool -> Element.Element Msg
topScorerHeaderBarItem msg namedPlayerDataAvailable =
    if namedPlayerDataAvailable == True then
        el --TitleButton 
            [ onClick msg ] 
            topScorersIcon

    else
        paragraph [] []


heading : Responsive -> List (Element msg) -> Element.Element msg
heading responsive elements =
    row
        --Title
        [ width <| fill
        , padding responsive.bigGap
        , spacing responsive.bigGap
        , centerY --verticalCenter
        , centerX --center
        , dataTestClass "heading"
        ]
        elements


title : String -> Element.Element msg
title titleText =
    paragraph
        --Title
        [ dataTestClass "title"
        , width fill
        ]
        [ text titleText ]


backIcon : Element msg
backIcon =
    Html.span [ Html.Attributes.class "back fas fa-arrow-alt-circle-left" ] []
        |> Element.html


refreshIcon : Element msg
refreshIcon =
    Html.span [ Html.Attributes.class "fas fa-sync-alt" ] []
        |> Element.html


resultsFixturesIcon : Element msg
resultsFixturesIcon =
    Html.span [ Html.Attributes.class "data-test-results-fixtures fas fa-calendar-alt" ] []
        |> Element.html


topScorersIcon : Element msg
topScorersIcon =
    Html.span [ Html.Attributes.class "data-test-top-scorers fas fa-futbol" ] []
        |> Element.html
