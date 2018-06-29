module Updates.DecodeGoogleSheetToLeagueList exposing (decodeGoogleSheets)

import Json.Decode exposing (Decoder, at, list, string, succeed)

import Models.League exposing ( GoogleSheet )

googleSheetDecoder : Decoder GoogleSheet
googleSheetDecoder =
    Json.Decode.map GoogleSheet (at [ "properties", "title" ] string)

decodeGoogleSheets : Decoder (List GoogleSheet)
decodeGoogleSheets =
    Json.Decode.field "sheets" (list googleSheetDecoder)
