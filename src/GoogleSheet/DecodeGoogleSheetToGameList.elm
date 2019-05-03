module GoogleSheet.DecodeGoogleSheetToGameList exposing (decodeSheetToLeagueGames)

import Json.Decode exposing (Decoder, at, list, string, succeed, index, int, value, Value, andThen, decodeString, maybe)
import Json.Decode.Extra exposing (parseInt, date, indexedList, andMap, optionalField, withDefault)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)

decodeSheetToLeagueGames : String -> Decoder LeagueGames
decodeSheetToLeagueGames leagueTitle =
    Json.Decode.map (\(games) -> LeagueGames leagueTitle games) decodeSheetToGames

decodeSheetToGames : Decoder (List Game)
decodeSheetToGames =
    decodeSheetToMaybeGames
    |> Json.Decode.map (List.filterMap identity)
    |> Json.Decode.map (List.filter validTeamNames)

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
            withDefault
                Maybe.Nothing
                (
                    succeed 
                        Game
                        |> andMap (Json.Decode.map String.trim (index 0 string))
                        |> andMap (index 1 (maybe parseInt))
                        |> andMap (Json.Decode.map String.trim (index 3 string)) -- index 3 is on purpose
                        |> andMap (index 2 (maybe parseInt))
                        |> andMap (withDefault Nothing (index 4 (maybe date)))
                        |> andMap (withDefault "" (index 5 string))
                        |> andMap (withDefault "" (index 6 string))
                        |> andMap (withDefault "" (index 7 string))
                        |> andMap (withDefault "" (index 8 string))
                        |> andMap (withDefault "" (index 9 string))
                        |> Json.Decode.map Just
                )

validTeamNames : Game -> Bool
validTeamNames game =
    game.homeTeamName /= "" && game.awayTeamName /= ""
