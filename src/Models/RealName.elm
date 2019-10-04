module Models.RealName exposing (..)

import Char


type RealName
    = HasRealName
    | NoName


fromString : String -> RealName
fromString playerName =
    if String.any isAlpha playerName then
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



-- this function exists in Char module in elm 0.19, so can remove when upgradr


isAlpha : Char -> Bool
isAlpha char =
    Char.isUpper char || Char.isLower char
