module LeagueList.Updates exposing (update, sheetRequest)

import Http
import Messages.Msg exposing (..)
import Models.Model exposing (Model, LeagueListModel)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Config exposing (Config)
import LeagueList.DecodeGoogleSheetToLeagueList exposing (..)


update : Msg -> LeagueListModel -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Messages.Msg.NoOp ->
            ( Models.Model.LeagueList model, Cmd.none )

        Messages.Msg.SheetRequest ->
            sheetRequest model

        Messages.Msg.SheetResponse (Err httpError) ->
            logErrorAndNoOp httpError model

        Messages.Msg.SheetResponse (Ok leagues) ->
            ( Models.Model.LeagueList { model | leagues = leagues }, Cmd.none )


sheetRequest : LeagueListModel -> ( Model, Cmd Msg )
sheetRequest model =
    ( Models.Model.LeagueList model, Http.send Messages.Msg.SheetResponse (request model.config) )


request : Config -> Http.Request (List LeagueSummary)
request config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeGoogleSheets


logErrorAndNoOp : Http.Error -> LeagueListModel -> ( Model, Cmd Msg )
logErrorAndNoOp httpError model =
    let
        _ =
            Debug.log "sheetResponseError" httpError
    in
        ( Models.Model.LeagueList model, Cmd.none )
