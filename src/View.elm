module View exposing (view)

import Html exposing (Html)

import Msg exposing (..)
import Models.Model exposing ( Model )
import Models.Route as Route exposing ( Route )
import Pages.LeagueList.View exposing (view)
import Pages.LeagueTable.View exposing (view)
import Pages.ResultsFixtures.View exposing (view)


view : Model -> Html Msg
view model =
    case model.route of
        Route.LeagueListRoute ->
            Pages.LeagueList.View.view model.leagues model.device
        Route.LeagueTableRoute leagueTitle ->
            Pages.LeagueTable.View.view leagueTitle model.leagueTable model.device
        Route.ResultsFixturesRoute leagueTitle ->
            Pages.ResultsFixtures.View.view leagueTitle model.leagueGames model.device
        Route.NotFoundRoute ->
            Pages.LeagueList.View.view model.leagues model.device -- return 404 later

-- notFoundView : Html msg
-- notFoundView =
--     div []
--         [ text "Not found"
--         ]