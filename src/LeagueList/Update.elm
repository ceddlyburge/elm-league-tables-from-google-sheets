module LeagueList.Update exposing (allSheetSummaryRequest, allSheetSummaryResponse)

import Http
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Config exposing (Config)
import LeagueList.DecodeGoogleSheetToLeagueList exposing (..)


allSheetSummaryRequest : Model -> ( Model, Cmd Msg )
allSheetSummaryRequest model =
    ( model, Http.send AllSheetSummaryResponse (request model.config) )


request : Config -> Http.Request (List LeagueSummary)
request config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeGoogleSheets


allSheetSummaryResponse: Model -> List LeagueSummary -> ( Model, Cmd Msg )
allSheetSummaryResponse model leagues = 
    ( { model | leagues = leagues }, Cmd.none )
