module LeagueList.Update exposing (sheetRequest)

import Http
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Config exposing (Config)
import LeagueList.DecodeGoogleSheetToLeagueList exposing (..)


-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         NoOp ->
--             ( model, Cmd.none )

--         SheetRequest ->
--             sheetRequest model

--         SheetResponse (Err httpError) ->
--             logErrorAndNoOp httpError model

--         SheetResponse (Ok leagues) ->
--             ( { model | leagues = leagues }, Cmd.none )


sheetRequest : Model -> ( Model, Cmd Msg )
sheetRequest model =
    ( model, Http.send SheetResponse (request model.config) )


request : Config -> Http.Request (List LeagueSummary)
request config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeGoogleSheets


logErrorAndNoOp : Http.Error -> Model -> ( Model, Cmd Msg )
logErrorAndNoOp httpError model =
    let
        _ =
            Debug.log "sheetResponseError" httpError
    in
        ( model, Cmd.none )
