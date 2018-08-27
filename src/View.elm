module View exposing (view)

import Html exposing (Html)

import Msg exposing (..)
import Models.Model exposing ( Model )
import Models.Route as Route exposing ( Route )
import LeagueList.View exposing (view)
import LeagueTable.View exposing (view)


view : Model -> Html Msg
view model =
    case model.route of
        Route.LeagueListRoute ->
            LeagueList.View.view model.leagues
        Route.LeagueTableRoute leagueTitle ->
            LeagueTable.View.view leagueTitle model.leagueTable
        Route.NotFoundRoute ->
            LeagueList.View.view model.leagues -- return 404 later

-- notFoundView : Html msg
-- notFoundView =
--     div []
--         [ text "Not found"
--         ]