module Pages.ResponsiveColumn exposing (Column, multiline, respondedColumns)

import Element exposing (..)

import Models.Team exposing (Team)
import LeagueStyleElements exposing (..)
import Msg exposing (..)

type alias Column =
    { value: Team -> String
    , cssClass: String
    , element : Styles -> List (Element.Attribute Variations Msg) -> Element.Element Styles Variations Msg -> Element.Element Styles Variations Msg
    , title: String
    , width: Float
    , priority : Int
    }

respondedColumns: Float -> Float -> Float -> List Column -> List Column
respondedColumns width padding spacing columns =
    columns
    |> columnsAvailableForWidth width padding spacing 
    |> padColumns width padding spacing

columnsAvailableForWidth: Float -> Float -> Float -> List Column -> List Column
columnsAvailableForWidth width padding spacing columns =
    let
        lowestPriority = Maybe.withDefault 0 (List.minimum <| List.map priority columns)
    in
        if  columnsWidth padding spacing columns <= width then
            columns
        else
            columnsAvailableForWidth 
                width 
                padding 
                spacing 
                (List.filter (isNotLowestPriority lowestPriority) columns)

columnsWidth : Float -> Float -> List Column -> Float
columnsWidth padding spacing columns =
    (List.foldr addWidth 0 columns)
    + padding + padding + (toFloat (List.length columns) * spacing)

padColumns: Float -> Float -> Float -> List Column -> List Column
padColumns width padding spacing columns  = 
    let
        numberOfColumns = toFloat (List.length columns)
        allColumnsWidth = columnsWidth padding spacing columns
        availableWidth = width - padding - padding - (numberOfColumns * spacing)
        desiredWidth = availableWidth * 0.8
    in
        if allColumnsWidth < desiredWidth then
            List.map (\column -> { column | width = column.width + (desiredWidth - allColumnsWidth) / numberOfColumns}) columns 
        else
            columns

multiline: Styles -> List (Element.Attribute Variations Msg) -> Element.Element Styles Variations Msg -> Element.Element Styles Variations Msg
multiline styles attributes element =
    paragraph styles attributes [element]

priority: Column -> Int
priority column =
    column.priority

isNotLowestPriority: Int -> Column -> Bool
isNotLowestPriority lowestPriority column =
    not (column.priority == lowestPriority)

addWidth: Column -> Float -> Float
addWidth column width  =
    column.width + width 
