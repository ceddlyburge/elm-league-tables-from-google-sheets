module View exposing (view)

import Browser exposing (Document)
import Dict
import Models.League exposing (League)
import Models.Model exposing (Model, ModelAndKey)
import Models.Route as Route
import Msg exposing (Msg)
import Pages.LeagueList.View
import Pages.LeagueTable.View
import Pages.Page exposing (Page)
import Pages.RenderPage exposing (renderPage)
import Pages.Responsive exposing (Responsive, calculateResponsive)
import Pages.ResultsFixtures.View
import Pages.TopScorers.View
import RemoteData exposing (WebData)
import Styles exposing (Styles, createStyles)


view : ModelAndKey -> Document Msg
view modelAndKey =
    let
        responsive : Responsive
        responsive =
            calculateResponsive modelAndKey.model.device modelAndKey.model.viewportWidth

        styles : Styles
        styles =
            createStyles responsive
    in
    page modelAndKey.model styles
        |> renderPage styles


page : Model -> Styles -> Page
page model styles =
    case model.route of
        Route.LeagueList ->
            Pages.LeagueList.View.page model.config model.leagueSummaries styles

        Route.LeagueTable leagueTitle ->
            Pages.LeagueTable.View.page leagueTitle (getLeague leagueTitle model) styles

        Route.ResultsFixtures leagueTitle ->
            Pages.ResultsFixtures.View.page leagueTitle (RemoteData.map .resultsFixtures (getLeague leagueTitle model)) styles

        Route.TopScorers leagueTitle ->
            Pages.TopScorers.View.page leagueTitle (RemoteData.map .players (getLeague leagueTitle model)) styles

        Route.NotFound ->
            Pages.LeagueList.View.page model.config model.leagueSummaries styles


getLeague : String -> Model -> WebData League
getLeague leagueTitle model =
    Dict.get leagueTitle model.leagues
        |> Maybe.withDefault RemoteData.NotAsked
