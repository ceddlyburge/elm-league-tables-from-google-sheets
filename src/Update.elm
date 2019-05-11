module Update exposing (update)

import Element exposing (classifyDevice)
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Pages.LeagueList.Update exposing (..)
import Pages.LeagueTable.Update exposing (individualSheetRequest, individualSheetResponse)
import Pages.ResultsFixtures.Update exposing (individualSheetRequestForResultsFixtures, individualSheetResponseForResultsFixtures)
import Routing exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        -- League List
        ShowLeagueList  ->
            showLeagueList model

        RefreshLeagueList  ->
            refreshLeagueList model

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
            -- split this out in to a new function
            -- this relies on the other update cases to actually set the route in the model, probably not the best idea
            let
                route = parseLocation location
            in
                -- If we are already on the page, then don't do anything (otherwise there will be an infinite loop).
                -- toUrl doesn't encode at the moment, so this can mean that this function executes twice. The first
                -- time with the unencoded version, then with the version from the browser. This is hard to fix, I 
                -- think because I am still on elm 0.18 and so can't install the packages that do the encoding. 
                if ((toUrl route) == (toUrl model.route)) then
                    ( model, Cmd.none )
                else 
                    case route of
                        Route.LeagueListRoute ->
                            update ShowLeagueList model
                        Route.LeagueTableRoute leagueTitle ->
                            update (IndividualSheetRequest leagueTitle) model 
                        Route.ResultsFixturesRoute leagueTitle ->
                            update (IndividualSheetRequestForResultsFixtures leagueTitle) model 
                        Route.NotFoundRoute ->
                            let
                                _ = Debug.log "Route not found" location
                            in
                                ( model, Cmd.none )            
