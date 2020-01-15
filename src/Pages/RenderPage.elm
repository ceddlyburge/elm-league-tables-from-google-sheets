module Pages.RenderPage exposing (renderPage, renderTestablePage)

import Element exposing (..)
import Element.Events exposing (onClick)
import Html exposing (Html)
import Html.Attributes exposing (class)
import Styles exposing (..)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import Pages.ViewHelpers exposing (..)
import Browser exposing (Document)
import Element.Font exposing (..)


renderPage : Styles -> Page -> Document Msg
renderPage styles page =
    Document
        "League Tables"
        [ renderTestablePage styles page]


-- This is an annoyance, but the html test package doesn't want to work with lists really
renderTestablePage : Styles -> Page -> Html Msg
renderTestablePage styles page =
    body
        styles
        [ renderHeaderBar styles page.header
        , page.body
        ]

body : Styles -> List (Element Msg) -> Html Msg
body styles elements =
    Element.layout 
        [ sansSerifFontFamily ] 
        <| column
            [ width <| bodyWidth styles.responsive
            , styles.mediumVerticalSpacing
            , centerX 
            , dataTestClass "body"
            ]
            elements



-- 100% normally works better, as it takes into account a vertical scroll bar if there is one.
-- If you just set a pixel width, it will be wider than the available width if there is a
-- vertical scroll bar, and then yout get an annoying horizontal scroll bar as well.
-- If 100% is too small, then we can just use a pixel value, as there is going to be a
-- horizontal scroll bar anyway


bodyWidth : Responsive -> Length
bodyWidth responsive =
    if responsive.pageWidth > responsive.viewportWidth then
        px responsive.pageWidth

    else
        fill


renderHeaderBar : Styles -> PageHeader -> Element.Element Msg
renderHeaderBar styles pageHeader =
    case pageHeader of
        SingleHeader headerBar ->
            renderMainHeaderBar styles headerBar

        DoubleHeader headerBar subHeaderBar ->
            renderMainAndSubHeaderBar styles headerBar subHeaderBar


renderMainAndSubHeaderBar : Styles -> HeaderBar -> SubHeaderBar -> Element.Element Msg
renderMainAndSubHeaderBar styles headerBar subHeaderBar =
    column
        [ width fill ]
        [ renderMainHeaderBar styles headerBar
        , renderSubHeaderBar styles subHeaderBar
        ]


renderMainHeaderBar : Styles -> HeaderBar -> Element.Element Msg
renderMainHeaderBar styles headerBar =
    heading
        styles
        (List.map (renderHeaderBarItem styles) headerBar.leftItems
            ++ [ title headerBar.title ]
            ++ List.map (renderHeaderBarItem styles) headerBar.rightItems
        )


renderSubHeaderBar : Styles -> SubHeaderBar -> Element.Element Msg
renderSubHeaderBar styles subHeaderBar =
    elWithStyle
        styles.subHeaderBar
        [ width fill
        , styles.mediumPadding 
        , centerY 
        ]
        (text subHeaderBar.title)


renderHeaderBarItem : Styles -> HeaderBarItem -> Element.Element Msg
renderHeaderBarItem styles headerBarItem =
    case headerBarItem of
        HeaderButtonSizedSpace ->
            el 
                styles.invisibleButTakesUpSpace 
                backIcon

        RefreshHeaderButton msg ->
            elWithStyle 
                styles.mainHeaderBarLink
                [ dataTestClass "refresh"
                , onClick msg ]
                refreshIcon

        ResultsFixturesHeaderButton msg ->
            elWithStyle 
                styles.mainHeaderBarLink
                [ onClick msg ]
                resultsFixturesIcon

        TopScorersHeaderButton msg namedPlayerDataAvailable ->
            topScorerHeaderBarItem styles msg namedPlayerDataAvailable

        BackHeaderButton msg ->
            elWithStyle 
                styles.mainHeaderBarLink 
                [ onClick msg
                , dataTestClass "back"
                ] 
                backIcon


topScorerHeaderBarItem : Styles -> Msg -> Bool -> Element.Element Msg
topScorerHeaderBarItem styles msg namedPlayerDataAvailable =
    if namedPlayerDataAvailable == True then
        elWithStyle
            styles.mainHeaderBarLink
            [ onClick msg ]
            topScorersIcon

    else
        -- this avoids screen jank when loading the page
        -- namedPlayerDataAvailable is only known after the result
        -- is fetched from the google api, which takes time, and
        -- it defaults to false
        -- could potentially show it greyed out instead
        -- or just show it, and if there is no named player data
        -- link to a help page stating this
        el 
            styles.invisibleButTakesUpSpace 
            topScorersIcon


heading : Styles -> List (Element Msg) -> Element.Element Msg
heading styles elements =
    rowWithStyle
        styles.mainHeaderBar
        [ width fill
        , styles.bigPadding
        , styles.bigSpacing
        , centerY 
        , dataTestClass "heading"
        ]
        elements


title : String -> Element.Element msg
title titleText =
    paragraph
        [ dataTestClass "title"
        , centerX
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
    Html.span [ Html.Attributes.class "fas fa-futbol" ] []
        |> Element.html
