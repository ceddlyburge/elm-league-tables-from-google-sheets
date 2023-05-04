module Pages.ResponsiveColumn exposing (Column, multiline, respondedColumns)

import Element
import Models.Team exposing (Team)
import Msg exposing (Msg)


type alias Column =
    { value : Team -> String
    , cssClass : String
    , element : List (Element.Attribute Msg) -> Element.Element Msg -> Element.Element Msg
    , title : String
    , width : Int
    , priority : Int
    }


respondedColumns : Int -> Int -> Int -> List Column -> List Column
respondedColumns width padding spacing columns =
    columns
        |> columnsAvailableForWidth width padding spacing
        |> padColumns width padding spacing


columnsAvailableForWidth : Int -> Int -> Int -> List Column -> List Column
columnsAvailableForWidth width padding spacing columns =
    if columnsWidth padding spacing columns <= width then
        columns

    else
        let
            lowestPriority : Int
            lowestPriority =
                Maybe.withDefault 0 (List.minimum <| List.map priority columns)
        in
        columnsAvailableForWidth
            width
            padding
            spacing
            (List.filter (isNotLowestPriority lowestPriority) columns)


columnsWidth : Int -> Int -> List Column -> Int
columnsWidth padding spacing columns =
    List.foldr addWidth 0 columns
        + padding
        + padding
        + (List.length columns * spacing)


padColumns : Int -> Int -> Int -> List Column -> List Column
padColumns width padding spacing columns =
    let
        numberOfColumns : Int
        numberOfColumns =
            List.length columns

        allColumnsWidth : Int
        allColumnsWidth =
            columnsWidth padding spacing columns

        availableWidth : Int
        availableWidth =
            width - padding - padding - (numberOfColumns * spacing)

        desiredWidth : Int
        desiredWidth =
            round (toFloat availableWidth * 0.8)
    in
    if allColumnsWidth < desiredWidth then
        List.map (\column -> { column | width = column.width + (desiredWidth - allColumnsWidth) // numberOfColumns }) columns

    else
        columns


multiline : List (Element.Attribute Msg) -> Element.Element Msg -> Element.Element Msg
multiline attributes element =
    Element.paragraph attributes [ element ]


priority : Column -> Int
priority column =
    column.priority


isNotLowestPriority : Int -> Column -> Bool
isNotLowestPriority lowestPriority column =
    not (column.priority == lowestPriority)


addWidth : Column -> Int -> Int
addWidth column width =
    column.width + width
