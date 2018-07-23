module LeagueTable.DecodeGoogleSheetToGameList exposing (decodeSheetToGames)

import Json.Decode exposing (Decoder, at, list, string, succeed, index, int, value, Value, andThen, decodeString)
import Json.Decode.Extra exposing (parseInt, indexedList, andMap)
import Models.Game exposing (Game)


decodeSheetToGames : Decoder (List Game)
decodeSheetToGames =
    decodeSheetToMaybeGames
    |> Json.Decode.map (List.filterMap identity)

decodeSheetToMaybeGames : Decoder (List (Maybe Game))
decodeSheetToMaybeGames =
    Json.Decode.field "values" (indexedList decodeRowToGame)

-- skip header row
decodeRowToGame : Int -> Decoder (Maybe Game)
decodeRowToGame row =
    case row of
        0 ->
            succeed Maybe.Nothing
        _ ->
            succeed Game
                |> andMap (index 0 string)
                |> andMap (index 1 parseInt)
                |> andMap (index 3 string) -- this is on purpose
                |> andMap (index 2 parseInt)
                |> andMap (index 4 string)
                |> andMap (index 5 string)
                |> andMap (index 6 string)
                |> andMap (index 7 string)
                |> Json.Decode.map Just
    
