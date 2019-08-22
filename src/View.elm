module View exposing (view)

import Dict exposing (Dict)
import Html exposing (Html)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing ( Model )
import Models.Config exposing ( Config )
import Models.Route as Route exposing ( Route )
import Pages.LeagueList.View exposing (..)
import Pages.LeagueTable.View exposing (..)
import Pages.ResultsFixtures.View exposing (..)
import Pages.Page exposing (..)
import Pages.RenderPage exposing (..)
import Pages.Responsive exposing (..)
import Models.LeagueTable exposing (LeagueTable)
import Models.ResultsFixtures exposing (ResultsFixtures)


view : Model -> Html Msg
view model =
    let
        responsive = calculateResponsive <| toFloat model.device.width
    in
        page model responsive
        |> renderPage responsive    

page : Model -> Responsive -> Page
page model responsive =
    case model.route of
        Route.LeagueList ->
            Pages.LeagueList.View.page model.config model.leagues responsive
        Route.LeagueTable leagueTitle ->
            Pages.LeagueTable.View.page leagueTitle (getLeagueTable leagueTitle model) responsive
        Route.ResultsFixtures leagueTitle ->
            Pages.ResultsFixtures.View.page leagueTitle (getResultsFixtures leagueTitle model) responsive
        Route.NotFound ->
            Pages.LeagueList.View.page model.leagues responsive -- return 404 later

getLeagueTable : String -> Model -> WebData LeagueTable
getLeagueTable leagueTitle model =
    Dict.get leagueTitle model.leagueTables
    |> Maybe.withDefault RemoteData.NotAsked

getResultsFixtures : String -> Model -> WebData ResultsFixtures
getResultsFixtures leagueTitle model =
    Dict.get leagueTitle model.resultsFixtures
    |> Maybe.withDefault RemoteData.NotAsked

-- notFoundView : Html msg
-- notFoundView =
--     div []
--         [ text "Not found"
--         ]