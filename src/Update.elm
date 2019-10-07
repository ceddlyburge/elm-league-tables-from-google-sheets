module Update exposing (update)

import Element exposing (classifyDevice)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Msg exposing (..)
--import Navigation exposing (Location, newUrl)
import Url exposing (Url)
import Browser.Navigation exposing (pushUrl)
import Pages.LeagueList.Update exposing (..)
import Pages.LeagueTable.Update exposing (refreshLeagueTable, showLeagueTable)
import Pages.ResultsFixtures.Update exposing (refreshResultsFixtures, showResultsFixtures)
import Pages.TopScorers.Update exposing (refreshTopScorers, showTopScorers)
import Pages.UpdateHelpers exposing (individualSheetResponse)
import Routing exposing (..)



-- This module has no unit tests, but its quite simple stuff, and mostly well checked
-- by the transpiler, and I don't think writing tests would bring much benefit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updatewithoutBrowserHistory msg model
        |> addBrowserHistory msg model


addBrowserHistory : Msg -> Model -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
addBrowserHistory oldMsg oldModel ( newModel, newMsg ) =
    case oldMsg of
        OnLocationChange _ ->
            ( newModel, newMsg )

        _ ->
            if newModel.route == oldModel.route then
                ( newModel, newMsg )

            else
                ( newModel, newMsg )
                --( newModel, Cmd.batch [ newMsg, newModel.route |> toUrl |> pushUrl ] )


updatewithoutBrowserHistory : Msg -> Model -> ( Model, Cmd Msg )
updatewithoutBrowserHistory msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        -- League List
        ShowLeagueList ->
            showLeagueList model

        RefreshLeagueList ->
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

        ShowTopScorers leagueTitle ->
            showTopScorers leagueTitle model

        RefreshTopScorers leagueTitle ->
            refreshTopScorers leagueTitle model

        IndividualSheetResponse leagueTitle response ->
            individualSheetResponse model response leagueTitle

        -- responsiveness
        SetScreenSize width height ->
            ( { model | device = classifyDevice { width = width, height = height } }, Cmd.none )

        -- routing
        OnLocationChange location ->
            updateFromLocation model location


updateFromLocation : Model -> Url -> ( Model, Cmd Msg )
updateFromLocation model location =
    let
        route =
            parseLocation location
    in
    updateFromRoute model location route
        |> stopInfiniteLoop model route


updateFromRoute : Model -> Url -> Route -> ( Model, Cmd Msg )
updateFromRoute model location route =
    case route of
        Route.LeagueList ->
            updatewithoutBrowserHistory ShowLeagueList model

        Route.LeagueTable leagueTitle ->
            updatewithoutBrowserHistory (ShowLeagueTable leagueTitle) model

        Route.ResultsFixtures leagueTitle ->
            updatewithoutBrowserHistory (ShowResultsFixtures leagueTitle) model

        Route.TopScorers leagueTitle ->
            updatewithoutBrowserHistory (ShowTopScorers leagueTitle) model

        Route.NotFound ->
            let
                _ =
                    Debug.log "Route not found" location
            in
            ( model, Cmd.none )


stopInfiniteLoop : Model -> Route -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
stopInfiniteLoop originalModel route ( model, cmd ) =
    -- If we are already on the page, then don't do anything (otherwise there will be an infinite loop).
    if toUrl route == toUrl originalModel.route then
        ( originalModel, Cmd.none )

    else
        ( model, cmd )
