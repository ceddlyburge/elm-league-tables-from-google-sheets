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
import Styles exposing (..)


view : ModelAndKey -> Document Msg
view modelAndKey =
    let
        responsive = calculateResponsive modelAndKey.model.viewportWidth
        styles = createStyles responsive
    in
        page modelAndKey.model styles 
        |> renderPage responsive


page : Model -> Styles -> Page
page model styles =
    case model.route of
        Route.LeagueList ->
            Pages.LeagueList.View.page model.config model.leagueSummaries styles

        Route.LeagueTable leagueTitle ->
            Pages.LeagueTable.View.page leagueTitle (getLeague leagueTitle model) styles.responsive

        Route.ResultsFixtures leagueTitle ->
            Pages.ResultsFixtures.View.page leagueTitle (RemoteData.map .resultsFixtures (getLeague leagueTitle model)) styles.responsive

        Route.TopScorers leagueTitle ->
            Pages.TopScorers.View.page leagueTitle (RemoteData.map .players (getLeague leagueTitle model)) styles.responsive

        Route.NotFound ->
            Pages.LeagueList.View.page model.config model.leagueSummaries styles


getLeague : String -> Model -> WebData League
getLeague leagueTitle model =
    Dict.get leagueTitle model.leagues
        |> Maybe.withDefault RemoteData.NotAsked

