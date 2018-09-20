module ResultsFixtures.Update exposing (individualSheetRequestForResultsFixtures, individualSheetResponseForResultsFixtures)

import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueGames exposing (LeagueGames)
import Models.Config exposing (Config)
import Models.Route as Route exposing (Route)
import Routing exposing (toUrl)
import UpdateSharedFunctions exposing (fetchIndividualSheet)

individualSheetRequestForResultsFixtures : String -> Model -> ( Model, Cmd Msg )
individualSheetRequestForResultsFixtures leagueTitle model  =
    ( { model | leagueGames = RemoteData.Loading }, fetchLeagueGames leagueTitle model.config )

individualSheetResponseForResultsFixtures : Model -> WebData LeagueGames -> String -> ( Model, Cmd Msg )
individualSheetResponseForResultsFixtures  model response leagueTitle =
    -- probably define a new shared function that takes the model and returns the newUrl with the route in the model
    -- this will reduce duplication and make it impossible to mismatch the change in urls
    ( 
        { model | 
            route = Route.ResultsFixturesRoute leagueTitle
            , leagueGames = response 
        }
        , newUrl <| toUrl <| Route.ResultsFixturesRoute leagueTitle
    )

fetchLeagueGames : String -> Config -> Cmd Msg
fetchLeagueGames leagueTitle config =
    fetchIndividualSheet leagueTitle config
    |> Cmd.map (IndividualSheetResponseForResultsFixtures leagueTitle)

        
