module Updates.DecodeGoogleSheetToLeagueList exposing (decodeGoogleSheets)

import Json.Decode exposing (Decoder, at, list, string, succeed)

import Models.League exposing ( League )

googleSheetDecoder : Decoder League
googleSheetDecoder =
    Json.Decode.map League (at [ "properties", "title" ] string)

decodeGoogleSheets : Decoder (List League)
decodeGoogleSheets =
    Json.Decode.field "sheets" (list googleSheetDecoder)
