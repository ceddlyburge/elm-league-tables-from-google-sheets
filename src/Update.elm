module Update exposing (update)

import Http
import Msg exposing (..)
import Models.Model exposing (Model)
import LeagueList.Update exposing (sheetRequest)
import LeagueTable.Update exposing (individualSheetRequest, calculateLeagueTable)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        -- League List
        SheetRequest ->
            sheetRequest model

        SheetResponse (Err httpError) ->
            logErrorAndNoOp httpError model

        SheetResponse (Ok leagues) ->
            ( { model | leagues = leagues }, Cmd.none )

        -- League Table
        IndividualSheetRequest leagueTitle ->
            individualSheetRequest leagueTitle model

        IndividualSheetResponse (Err httpError) ->
            logErrorAndNoOp httpError model

        IndividualSheetResponse (Ok leagueGames) ->
            ( { model | leagueTable = calculateLeagueTable leagueGames }, Cmd.none ) 

logErrorAndNoOp : Http.Error -> Model -> ( Model, Cmd Msg )
logErrorAndNoOp httpError model =
    let
        _ =
            Debug.log "httpError" httpError
    in
        ( model, Cmd.none )
