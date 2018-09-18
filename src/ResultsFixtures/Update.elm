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
    ( { model | leagueTable = RemoteData.Loading }, fetchLeagueGames leagueTitle model.config )

individualSheetResponseForResultsFixtures : Model -> WebData LeagueGames -> String -> ( Model, Cmd Msg )
individualSheetResponseForResultsFixtures  model response leagueTitle =
    ( 
        { model | 
            route = Route.ResultsFixturesRoute leagueTitle
            , leagueGames = response 
        }
        , newUrl <| toUrl <| Route.LeagueTableRoute leagueTitle
    )

fetchLeagueGames : String -> Config -> Cmd Msg
fetchLeagueGames leagueTitle config =
    fetchIndividualSheet leagueTitle config
    |> Cmd.map (IndividualSheetResponseForResultsFixtures leagueTitle)

        
