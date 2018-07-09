module Updates.Main exposing (update, sheetRequest)

import Http

import Messages.Msg exposing ( .. )
import Models.Model exposing ( Model )
import Models.League exposing ( League )
import Models.Config exposing ( Config )
import Updates.DecodeGoogleSheetToLeagueList exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        Messages.Msg.NoOp ->
            ( model, Cmd.none )
        
        Messages.Msg.SheetRequest ->
            sheetRequest model 

        Messages.Msg.SheetResponse result ->
            sheetRespond result model

sheetRequest : Model -> ( Model, Cmd Msg )
sheetRequest model =
    ( model, Http.send Messages.Msg.SheetResponse (request model.config) )

request : Config -> Http.Request (List League)
request config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeGoogleSheets

sheetRespond : (Result Http.Error (List League)) -> Model -> ( Model, Cmd Msg )
sheetRespond result model =
    case result of
        Err httpError ->
            let
                _ =
                    Debug.log "sheetResponseError" httpError
            in
                ( model, Cmd.none )

        Ok leagues ->
            ( { model | leagues = leagues}, Cmd.none )
