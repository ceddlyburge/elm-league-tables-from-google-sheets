module Date.Format exposing (formatDate)

import Date exposing (..)

formatDate : Date -> String
formatDate datetime =
    let
        day =
            Date.day datetime

        month =
            Date.month datetime

        year =
            Date.year datetime

        hour =
            Date.hour datetime

        minute =
            Date.minute datetime
    in
        (toString year) ++ "-" ++ (zfill <| monthToNumber month) ++ "-" ++ (zfill day) ++ " " ++ (zfill hour) ++ ":" ++ (zfill minute)


zfill : Int -> String
zfill value =
    let
        string =
            toString value
    in
        if (String.length string) == 1 then
            "0" ++ string
        else
            string

monthToNumber : Month -> Int
monthToNumber m =
    case m of
        Jan ->
            1

        Feb ->
            2

        Mar ->
            3

        Apr ->
            4

        May ->
            5

        Jun ->
            6

        Jul ->
            7

        Aug ->
            8

        Sep ->
            9

        Oct ->
            10

        Nov ->
            11

        Dec ->
            12
