module View exposing (view)

import Dict exposing (Dict)
import Html exposing (Html)
import Models.League exposing (League)
import Models.LeagueTable exposing (LeagueTable)
import Models.Model exposing (Model, ModelAndKey)
import Models.Player exposing (..)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.Route as Route exposing (Route)
import Msg exposing (..)
import Pages.LeagueList.View exposing (..)
import Pages.LeagueTable.View exposing (..)
import Pages.Page exposing (..)
import Pages.RenderPage exposing (..)
import Pages.Responsive exposing (..)
import Pages.ResultsFixtures.View exposing (..)
import Pages.TopScorers.View exposing (..)
import RemoteData exposing (WebData)
import Browser exposing (Document)


view : ModelAndKey -> Document Msg
view modelAndKey =
    let
        responsive =
            calculateResponsive <| toFloat modelAndKey.model.device.width
    in
    page modelAndKey.model responsive
        |> renderPage responsive


page : Model -> Responsive -> Page
page model responsive =
    case model.route of
        Route.LeagueList ->
            Pages.LeagueList.View.page model.config model.leagueSummaries responsive

        Route.LeagueTable leagueTitle ->
            Pages.LeagueTable.View.page leagueTitle (getLeague leagueTitle model) responsive

        Route.ResultsFixtures leagueTitle ->
            Pages.ResultsFixtures.View.page leagueTitle (RemoteData.map .resultsFixtures (getLeague leagueTitle model)) responsive

        Route.TopScorers leagueTitle ->
            Pages.TopScorers.View.page leagueTitle (RemoteData.map .players (getLeague leagueTitle model)) responsive

        Route.NotFound ->
            Pages.LeagueList.View.page model.config model.leagueSummaries responsive



-- return 404 later
-- namedPlayerDataAvailable : String -> Model -> Bool
-- namedPlayerDataAvailable leagueTitle model =
--     let
--         players = getTopScorers leagueTitle model
--     in
--         case players of
--             RemoteData.Success players ->
--                 players.namedPlayerDataAvailable
--             _ ->
--                 False


getLeague : String -> Model -> WebData League
getLeague leagueTitle model =
    Dict.get leagueTitle model.leagues
        |> Maybe.withDefault RemoteData.NotAsked



-- getResultsFixtures : String -> Model -> WebData ResultsFixtures
-- getResultsFixtures leagueTitle model =
--     Dict.get leagueTitle model.resultsFixtures
--     |> Maybe.withDefault RemoteData.NotAsked
-- getTopScorers : String -> Model -> WebData Players
-- getTopScorers leagueTitle model =
--     Dict.get leagueTitle model.players
--     |> Maybe.withDefault RemoteData.NotAsked
-- notFoundView : Html msg
-- notFoundView =
--     div []
--         [ text "Not found"
--         ]
