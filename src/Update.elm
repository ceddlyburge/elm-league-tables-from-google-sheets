module Update exposing (update)

import Element exposing (classifyDevice)
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Pages.LeagueList.Update exposing (..)
import Pages.LeagueTable.Update exposing (showLeagueTable, refreshLeagueTable)
import Pages.ResultsFixtures.Update exposing (showResultsFixtures, refreshResultsFixtures)
import Pages.UpdateHelpers exposing (individualSheetResponse)
import Routing exposing (..)
import Navigation exposing (Location)

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

        -- Fixtures / Results, League Table
        ShowLeagueTable leagueTitle ->
            showLeagueTable leagueTitle model

        RefreshLeagueTable leagueTitle ->
            refreshLeagueTable leagueTitle model

        ShowResultsFixtures leagueTitle ->
            showResultsFixtures leagueTitle model

        RefreshResultsFixtures leagueTitle ->
            refreshResultsFixtures leagueTitle model

        IndividualSheetResponse leagueTitle response ->
            individualSheetResponse model response leagueTitle
        
        -- responsiveness
        SetScreenSize size ->
            ({ model | device = classifyDevice size }, Cmd.none)

        -- routing
        OnLocationChange location ->
            updateFromLocation model location


updateFromLocation : Model -> Location -> ( Model, Cmd Msg )
updateFromLocation model location =
    let
        route = parseLocation location
    in
        updateFromRoute model location route
        |> stopInfiniteLoop model route  


updateFromRoute : Model -> Location -> Route -> ( Model, Cmd Msg )
updateFromRoute model location route =
    case route of
        Route.LeagueListRoute ->
            update ShowLeagueList model
        Route.LeagueTableRoute leagueTitle ->
            update (ShowLeagueTable leagueTitle) model 
        Route.ResultsFixturesRoute leagueTitle ->
            update (ShowResultsFixtures leagueTitle) model 
        Route.NotFoundRoute ->
            let
                _ = Debug.log "Route not found" location
            in
                ( model, Cmd.none )            


stopInfiniteLoop : Model -> Route -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
stopInfiniteLoop originalModel route ( model, cmd ) =
    -- If we are already on the page, then don't do anything (otherwise there will be an infinite loop).
    -- toUrl doesn't encode at the moment, so this can mean that this function executes twice. The first
    -- time with the unencoded version, then with the version from the browser. This is hard to fix, I 
    -- think because I am still on elm 0.18 and so can't install the packages that do the encoding. 
    if ((toUrl route) == (toUrl originalModel.route)) then
        ( originalModel, Cmd.none )
    else 
        ( model, cmd )
