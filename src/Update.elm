module Update exposing (update)

import Element exposing (classifyDevice)
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Pages.LeagueList.Update exposing (allSheetSummaryRequest, allSheetSummaryResponse)
import Pages.LeagueTable.Update exposing (individualSheetRequest, individualSheetResponse)
import Pages.ResultsFixtures.Update exposing (individualSheetRequestForResultsFixtures, individualSheetResponseForResultsFixtures)
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
        
        -- Fixtures / Results
        IndividualSheetRequestForResultsFixtures leagueTitle ->
            individualSheetRequestForResultsFixtures leagueTitle model

        IndividualSheetResponseForResultsFixtures leagueTitle response ->
            individualSheetResponseForResultsFixtures model response leagueTitle
        
        -- responsiveness
        SetScreenSize size ->
            ({ model | device = classifyDevice size }, Cmd.none)

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
                    case route of
                        Route.LeagueListRoute ->
                            update AllSheetSummaryRequest model
                        Route.LeagueTableRoute leagueTitle ->
                            update (IndividualSheetRequest leagueTitle) model 
                        Route.ResultsFixturesRoute leagueTitle ->
                            update (IndividualSheetRequestForResultsFixtures leagueTitle) model 
                        Route.NotFoundRoute ->
                            ( model, Cmd.none )            
