module View exposing (view)

import Html exposing (Html)

import Msg exposing (..)
import Models.Model exposing ( Model )
--import Models.State as State exposing ( State )
import Models.Route as Route exposing ( Route )
import LeagueList.View exposing (view)
import LeagueTable.View exposing (view)


view : Model -> Html Msg
view model =
    case model.route of
        Route.LeagueListRoute ->
            LeagueList.View.view model
        Route.LeagueTableRoute leagueTitle ->
            LeagueTable.View.view model
        Route.NotFoundRoute ->
            LeagueList.View.view model -- return 404 later
    -- case model.state of
    --     State.LeagueList ->
    --         LeagueList.View.view model
    --     State.LeagueTable ->
    --         LeagueTable.View.view model

-- notFoundView : Html msg
-- notFoundView =
--     div []
--         [ text "Not found"
--         ]