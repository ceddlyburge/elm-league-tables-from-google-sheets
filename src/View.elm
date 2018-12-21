module View exposing (view)

import Html exposing (Html)

import Msg exposing (..)
import Models.Model exposing ( Model )
import Models.Route as Route exposing ( Route )
import Pages.LeagueList.View exposing (..)
import Pages.LeagueTable.View exposing (..)
import Pages.ResultsFixtures.View exposing (..)
import Pages.Page exposing (..)
import Pages.RenderPage exposing (..)


view : Model -> Html Msg
view model =
    renderPage model.device <| page model

page : Model -> Page
page model =
    case model.route of
        Route.LeagueListRoute ->
            Pages.LeagueList.View.page model.leagues model.device
        Route.LeagueTableRoute leagueTitle ->
            Pages.LeagueTable.View.page leagueTitle model.leagueTable model.device
        Route.ResultsFixturesRoute leagueTitle ->
            Pages.ResultsFixtures.View.page leagueTitle model.resultsFixtures model.device
        Route.NotFoundRoute ->
            Pages.LeagueList.View.page model.leagues model.device -- return 404 later

-- notFoundView : Html msg
-- notFoundView =
--     div []
--         [ text "Not found"
--         ]