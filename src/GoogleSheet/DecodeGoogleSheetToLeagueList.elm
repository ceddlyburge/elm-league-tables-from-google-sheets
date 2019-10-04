module GoogleSheet.DecodeGoogleSheetToLeagueList exposing (decodeAllSheetSummaryToLeagueSummaries)

import Json.Decode exposing (Decoder, at, list, string, succeed)
import Models.LeagueSummary exposing (LeagueSummary)


decodeAllSheetSummaryToLeagueSummaries : Decoder (List LeagueSummary)
decodeAllSheetSummaryToLeagueSummaries =
    Json.Decode.field "sheets" (list decodeSheetSummaryToLeagueSummary)


decodeSheetSummaryToLeagueSummary : Decoder LeagueSummary
decodeSheetSummaryToLeagueSummary =
    Json.Decode.map LeagueSummary (at [ "properties", "title" ] string)
