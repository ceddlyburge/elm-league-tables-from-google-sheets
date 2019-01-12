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
import Pages.Responsive exposing (..)


view : Model -> Html Msg
view model =
    let
        responsive = calculateResponsive <| toFloat model.device.width
    in
        renderPage responsive <| page model responsive

page : Model -> Responsive -> Page
page model responsive =
    case model.route of
        Route.LeagueListRoute ->
            Pages.LeagueList.View.page model.leagues responsive
        Route.LeagueTableRoute leagueTitle ->
            Pages.LeagueTable.View.page leagueTitle model.leagueTable responsive
        Route.ResultsFixturesRoute leagueTitle ->
            Pages.ResultsFixtures.View.page leagueTitle model.resultsFixtures responsive
        Route.NotFoundRoute ->
            Pages.LeagueList.View.page model.leagues responsive -- return 404 later

-- notFoundView : Html msg
-- notFoundView =
--     div []
--         [ text "Not found"
--         ]