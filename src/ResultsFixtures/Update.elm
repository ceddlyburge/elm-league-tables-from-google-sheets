module ResultsFixtures.Update exposing (individualSheetRequestForResultsFixtures, individualSheetResponseForResultsFixtures)

import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Date exposing (..)
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueGames exposing (LeagueGames)
import Models.Game exposing (Game)
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
            , leagueGames = RemoteData.map orderLeagueGames response 
        }
        , newUrl <| toUrl <| Route.ResultsFixturesRoute leagueTitle
    )

fetchLeagueGames : String -> Config -> Cmd Msg
fetchLeagueGames leagueTitle config =
    fetchIndividualSheet leagueTitle config
    |> Cmd.map (IndividualSheetResponseForResultsFixtures leagueTitle)

orderLeagueGames : LeagueGames -> LeagueGames
orderLeagueGames leagueGames =
    {leagueGames | games = List.sortWith descendingDate leagueGames.games }

descendingDate: Game -> Game -> Order
descendingDate game1 game2 =
    case (game1.datePlayed, game2.datePlayed) of
        (Nothing, Nothing) -> 
            EQ
        (Nothing, Just _) ->
            GT
        (Just _, Nothing) ->
            LT
        (Just date1, Just date2) ->
            if Date.toTime date1 > Date.toTime date2 then
                LT
            else if Date.toTime date1 < Date.toTime date2 then
                GT
            else
                EQ
