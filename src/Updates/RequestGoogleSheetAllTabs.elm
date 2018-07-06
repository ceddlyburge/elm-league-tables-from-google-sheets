module Updates.RequestGoogleSheetAllTabs exposing (sheetRequest)

import Http

import Messages.Msg exposing ( .. )
import Models.Model exposing ( Model )
import Models.League exposing ( League )
import Models.Config exposing ( Config )
import Updates.DecodeGoogleSheetToLeagueList exposing (..)

sheetRequest : Model -> ( Model, Cmd Msg )
sheetRequest model =
    ( model, Http.send Messages.Msg.SheetResponse (request model.config) )

request : Config -> Http.Request (List League)
request config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeGoogleSheets
