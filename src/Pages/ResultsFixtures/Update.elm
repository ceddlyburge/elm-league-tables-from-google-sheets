module Pages.ResultsFixtures.Update exposing (individualSheetRequestForResultsFixtures, individualSheetResponseForResultsFixtures)

import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueGames exposing (LeagueGames)
import Models.Config exposing (Config)
import Models.Route as Route exposing (Route)
import Routing exposing (toUrl)
import GoogleSheet.Api exposing (fetchIndividualSheet)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)

individualSheetRequestForResultsFixtures : String -> Model -> ( Model, Cmd Msg )
individualSheetRequestForResultsFixtures leagueTitle model  =
    ( { model | 
            leagueGames = RemoteData.Loading
            , resultsFixtures = RemoteData.Loading
            , route = Route.ResultsFixturesRoute leagueTitle
       }
       , fetchLeagueGames leagueTitle model.config )

individualSheetResponseForResultsFixtures : Model -> WebData LeagueGames -> String -> ( Model, Cmd Msg )
individualSheetResponseForResultsFixtures  model response leagueTitle =
    -- probably define a new shared function that takes the model and returns the newUrl with the route in the model
    -- this will reduce duplication and make it impossible to mismatch the change in urls
    ( 
        { model | 
            leagueGames = response
            , resultsFixtures = RemoteData.map calculateResultsFixtures response }
        , newUrl <| toUrl <| Route.ResultsFixturesRoute leagueTitle
    )

fetchLeagueGames : String -> Config -> Cmd Msg
fetchLeagueGames leagueTitle config =
    fetchIndividualSheet 
        leagueTitle 
        config 
        (IndividualSheetResponseForResultsFixtures leagueTitle)
