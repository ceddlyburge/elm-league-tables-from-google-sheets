module LeagueList.DecodeGoogleSheetToLeagueList exposing (decodeGoogleSheets)

import Json.Decode exposing (Decoder, at, list, string, succeed)
import Models.LeagueSummary exposing (LeagueSummary)


googleSheetDecoder : Decoder LeagueSummary
googleSheetDecoder =
    Json.Decode.map LeagueSummary (at [ "properties", "title" ] string)


decodeGoogleSheets : Decoder (List LeagueSummary)
decodeGoogleSheets =
    Json.Decode.field "sheets" (list googleSheetDecoder)
