module Models.RealName exposing (..)

import Char


type RealName
    = HasRealName
    | NoName


fromString : String -> RealName
fromString playerName =
    if String.any Char.isAlpha playerName then
        HasRealName

    else
        NoName


toBool : RealName -> Bool
toBool realName =
    case realName of
        HasRealName ->
            True

        _ ->
            False


hasRealName : String -> Bool
hasRealName name =
    fromString name
        |> toBool



