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
import Pages.Progressive exposing (..)


view : Model -> Html Msg
view model =
    let
        progressive = calculateProgressive <| toFloat model.device.width
    in
        renderPage progressive <| page model progressive

page : Model -> Progressive -> Page
page model progressive =
    case model.route of
        Route.LeagueListRoute ->
            Pages.LeagueList.View.page model.leagues progressive
        Route.LeagueTableRoute leagueTitle ->
            Pages.LeagueTable.View.page leagueTitle model.leagueTable progressive
        Route.ResultsFixturesRoute leagueTitle ->
            Pages.ResultsFixtures.View.page leagueTitle model.resultsFixtures progressive
        Route.NotFoundRoute ->
            Pages.LeagueList.View.page model.leagues progressive -- return 404 later

-- notFoundView : Html msg
-- notFoundView =
--     div []
--         [ text "Not found"
--         ]