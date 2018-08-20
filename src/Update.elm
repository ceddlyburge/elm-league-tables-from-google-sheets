module Update exposing (update)

import Http

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import LeagueList.Update exposing (allSheetSummaryRequest, allSheetSummaryResponse)
import LeagueTable.Update exposing (individualSheetRequest, individualSheetResponse)
import Routing exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        -- League List
        AllSheetSummaryRequest ->
            allSheetSummaryRequest model

        AllSheetSummaryResponse (Err httpError) ->
            logErrorAndNoOp httpError model

        AllSheetSummaryResponse (Ok leagues) ->
            allSheetSummaryResponse model leagues

        -- League Table
        IndividualSheetRequest leagueTitle ->
            individualSheetRequest leagueTitle model

        IndividualSheetResponse (Err httpError) ->
            logErrorAndNoOp httpError model

        IndividualSheetResponse (Ok leagueGames) ->
            individualSheetResponse leagueGames model
        
        -- routing
        OnLocationChange location ->
            -- this relies on the other update cases to actually set the route in the model, probably not the best idea
            case parseLocation location of
                Route.LeagueListRoute ->
                    update AllSheetSummaryRequest model
                Route.LeagueTableRoute leagueTitle ->
                    update (IndividualSheetRequest leagueTitle) model 
                _ ->
                    ( model, Cmd.none )            

logErrorAndNoOp : Http.Error -> Model -> ( Model, Cmd Msg )
logErrorAndNoOp httpError model =
    let
        _ =
            Debug.log "httpError" httpError
    in
        ( model, Cmd.none )
