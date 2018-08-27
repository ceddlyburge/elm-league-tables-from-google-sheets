module Update exposing (update)

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

        AllSheetSummaryResponse response ->
            allSheetSummaryResponse model response

        -- League Table
        IndividualSheetRequest leagueTitle ->
            individualSheetRequest leagueTitle model

        IndividualSheetResponse leagueTitle response ->
            individualSheetResponse model response leagueTitle
        
        -- routing
        OnLocationChange location ->
            -- this relies on the other update cases to actually set the route in the model, probably not the best idea
            let
                route = parseLocation location
            in
                -- If we are already on the page, then don't do anything (otherwise there will be an infinite loop)
                if ((toUrl route) == (toUrl model.route)) then
                    ( model, Cmd.none )
                else 
                    case parseLocation location of
                        Route.LeagueListRoute ->
                            update AllSheetSummaryRequest model
                        Route.LeagueTableRoute leagueTitle ->
                            update (IndividualSheetRequest leagueTitle) model 
                        _ ->
                            ( model, Cmd.none )            


-- logErrorAndNoOp : Http.Error -> Model -> ( Model, Cmd Msg )
-- logErrorAndNoOp httpError model =
--     let
--         _ =
--             Debug.log "httpError" httpError
--     in
--         ( model, Cmd.none )
