module Pages.RenderPage exposing (renderPage, renderTestablePage)

import Browser exposing (Document)
import Element exposing (Element, Length, centerX, centerY, column, el, fill, paragraph, px, text, width)
import Element.Events exposing (onClick)
import Html exposing (Html)
import Msg exposing (Msg)
import Pages.HeaderBar exposing (HeaderBar, PageHeader(..), SubHeaderBar)
import Pages.HeaderBarItem exposing (HeaderBarItem(..))
import Pages.Page exposing (Page)
import Pages.Responsive exposing (Responsive)
import Pages.ViewHelpers exposing (dataTestClass)
import Styles exposing (Styles, elWithStyle, rowWithStyle, sansSerifFontFamily)
import Svg
import Svg.Attributes


renderPage : Styles -> Page -> Document Msg
renderPage styles page =
    Document
        "League Tables"
        [ renderTestablePage styles page ]



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
        [ sansSerifFontFamily
        , width <| bodyWidth styles.responsive
        ]
    <|
        column
            [ styles.mediumVerticalSpacing
            , width <| bodyWidth styles.responsive
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
                , onClick msg
                ]
                refreshIcon

        ResultsFixturesHeaderButton msg ->
            elWithStyle
                styles.mainHeaderBarLink
                [ dataTestClass "results-fixtures"
                , onClick msg
                ]
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
    if namedPlayerDataAvailable then
        elWithStyle
            styles.mainHeaderBarLink
            [ dataTestClass "top-scorers", onClick msg ]
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
        [ width <| bodyWidth styles.responsive
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
    Svg.svg
        [ Svg.Attributes.viewBox "0 0 512 512"
        , Svg.Attributes.class "back"
        , Svg.Attributes.fill "currentColor"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.d "M256 504C119 504 8 393 8 256S119 8 256 8s248 111 248 248-111 248-248 248zm116-292H256v-70.9c0-10.7-13-16.1-20.5-8.5L121.2 247.5c-4.7 4.7-4.7 12.2 0 16.9l114.3 114.9c7.6 7.6 20.5 2.2 20.5-8.5V300h116c6.6 0 12-5.4 12-12v-64c0-6.6-5.4-12-12-12z"
            ]
            []
        ]
        |> Element.html


refreshIcon : Element msg
refreshIcon =
    Svg.svg
        [ Svg.Attributes.viewBox "0 0 512 512"
        , Svg.Attributes.fill "currentColor"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.d "M370.72 133.28C339.458 104.008 298.888 87.962 255.848 88c-77.458.068-144.328 53.178-162.791 126.85-1.344 5.363-6.122 9.15-11.651 9.15H24.103c-7.498 0-13.194-6.807-11.807-14.176C33.933 94.924 134.813 8 256 8c66.448 0 126.791 26.136 171.315 68.685L463.03 40.97C478.149 25.851 504 36.559 504 57.941V192c0 13.255-10.745 24-24 24H345.941c-21.382 0-32.09-25.851-16.971-40.971l41.75-41.749zM32 296h134.059c21.382 0 32.09 25.851 16.971 40.971l-41.75 41.75c31.262 29.273 71.835 45.319 114.876 45.28 77.418-.07 144.315-53.144 162.787-126.849 1.344-5.363 6.122-9.15 11.651-9.15h57.304c7.498 0 13.194 6.807 11.807 14.176C478.067 417.076 377.187 504 256 504c-66.448 0-126.791-26.136-171.315-68.685L48.97 471.03C33.851 486.149 8 475.441 8 454.059V320c0-13.255 10.745-24 24-24z"
            ]
            []
        ]
        |> Element.html


resultsFixturesIcon : Element msg
resultsFixturesIcon =
    Svg.svg
        [ Svg.Attributes.viewBox "0 0 512 512"
        , Svg.Attributes.fill "currentColor"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.d "M0 464c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V192H0v272zm320-196c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12h-40c-6.6 0-12-5.4-12-12v-40zm0 128c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12h-40c-6.6 0-12-5.4-12-12v-40zM192 268c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12h-40c-6.6 0-12-5.4-12-12v-40zm0 128c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12h-40c-6.6 0-12-5.4-12-12v-40zM64 268c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12H76c-6.6 0-12-5.4-12-12v-40zm0 128c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12H76c-6.6 0-12-5.4-12-12v-40zM400 64h-48V16c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v48H160V16c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v48H48C21.5 64 0 85.5 0 112v48h448v-48c0-26.5-21.5-48-48-48z"
            ]
            []
        ]
        |> Element.html


topScorersIcon : Element msg
topScorersIcon =
    Svg.svg
        [ Svg.Attributes.viewBox "0 0 512 512"
        , Svg.Attributes.fill "currentColor"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.d "M417.3 360.1l-71.6-4.8c-5.2-.3-10.3 1.1-14.5 4.2s-7.2 7.4-8.4 12.5l-17.6 69.6C289.5 445.8 273 448 256 448s-33.5-2.2-49.2-6.4L189.2 372c-1.3-5-4.3-9.4-8.4-12.5s-9.3-4.5-14.5-4.2l-71.6 4.8c-17.6-27.2-28.5-59.2-30.4-93.6L125 228.3c4.4-2.8 7.6-7 9.2-11.9s1.4-10.2-.5-15l-26.7-66.6C128 109.2 155.3 89 186.7 76.9l55.2 46c4 3.3 9 5.1 14.1 5.1s10.2-1.8 14.1-5.1l55.2-46c31.3 12.1 58.7 32.3 79.6 57.9l-26.7 66.6c-1.9 4.8-2.1 10.1-.5 15s4.9 9.1 9.2 11.9l60.7 38.2c-1.9 34.4-12.8 66.4-30.4 93.6zM256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm14.1-325.7c-8.4-6.1-19.8-6.1-28.2 0L194 221c-8.4 6.1-11.9 16.9-8.7 26.8l18.3 56.3c3.2 9.9 12.4 16.6 22.8 16.6h59.2c10.4 0 19.6-6.7 22.8-16.6l18.3-56.3c3.2-9.9-.3-20.7-8.7-26.8l-47.9-34.8z"
            ]
            []
        ]
        |> Element.html
