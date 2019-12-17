module Update exposing (update, updatewithoutBrowserHistory)

import Element exposing (classifyDevice)
import Models.Model exposing (Model, ModelAndKey)
import Models.Route as Route exposing (Route)
import Msg exposing (..)
import Url exposing (Url)
import Browser exposing (UrlRequest(..))
import Browser.Navigation exposing (pushUrl, Key)
import Pages.LeagueList.Update exposing (..)
import Pages.LeagueTable.Update exposing (refreshLeagueTable, showLeagueTable)
import Pages.ResultsFixtures.Update exposing (refreshResultsFixtures, showResultsFixtures)
import Pages.TopScorers.Update exposing (refreshTopScorers, showTopScorers)
import Pages.UpdateHelpers exposing (individualSheetResponse)
import Routing exposing (..)



-- At the moment, ModelAndKey can't be tested, due to the nonsense with pushUrl and Key
-- https://github.com/elm-explorations/test/issues/24


update : Msg -> ModelAndKey -> ( ModelAndKey, Cmd Msg )
update msg modelAndKey =
    let
        (newModel, newMsg) = 
            updatewithoutBrowserHistory msg modelAndKey.model
                |> addBrowserHistory msg modelAndKey.model modelAndKey.key
    in
        ( { modelAndKey | model = newModel }, newMsg )    


-- This should be a private function, but being as I can't test `update`, 
-- I export this so it can be tested.
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
            ( { 
                model | 
                    device = classifyDevice { width = width, height = height }
                    , viewportWidth = width
                    , viewportHeight = height
                }
            , Cmd.none )

        -- routing
        OnUrlChange url ->
            updateFromLocation model url

        OnUrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    updateFromLocation model url

                External _ ->
                    ( model, Cmd.none )

addBrowserHistory : Msg -> Model ->  Key -> (Model, Cmd Msg) -> ( Model, Cmd Msg )
addBrowserHistory oldMsg oldModel  key (newModel, newMsg) =
    case oldMsg of
        OnUrlChange _ ->
            ( newModel, newMsg )

        _ ->
            if newModel.route == oldModel.route then
                ( newModel, newMsg )

            else
                ( newModel, Cmd.batch [ newMsg, newModel.route |> toUrl |> pushUrl key ] )


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
            -- let
            --    _ =
            --        Debug.log "Route not found" location
            -- in
            ( model, Cmd.none )


stopInfiniteLoop : Model -> Route -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
stopInfiniteLoop originalModel route ( model, cmd ) =
    -- If we are already on the page, then don't do anything (otherwise there will be an infinite loop).
    if toUrl route == toUrl originalModel.route then
        ( originalModel, Cmd.none )

    else
        ( model, cmd )
