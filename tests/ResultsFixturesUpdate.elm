module ResultsFixturesUpdate exposing (..)

import Test exposing (..)
import Date exposing (..)
import Time exposing (..)
import Expect
import RemoteData exposing (WebData)
import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)
import ResultsFixturesHelpers exposing (..)

oneGame : Test
oneGame =
    test "oneGame" <|
        \() ->
            update (IndividualSheetResponseForResultsFixtures "" anyLeagueGames) vanillaModel
            |> \(model, msg) -> model.leagueGames
            |> Expect.equal anyLeagueGames

gameOrder : Test
gameOrder =
    test "Games should be ordered in descending date order. Games with no date should be displayed last" <|
        \() ->
            update 
                (
                    IndividualSheetResponseForResultsFixtures 
                    "" 
                    ( leagueGames [ gameWithNoDate, gameWithDate 1, gameWithDate 0] )
                ) 
                vanillaModel
            |> \(model, msg) -> model.leagueGames
            |> Expect.equal (leagueGames [ gameWithDate 1, gameWithDate 0, gameWithNoDate])

anyLeagueGames: WebData LeagueGames
anyLeagueGames = 
    RemoteData.Success ( LeagueGames "Div 1" [ game ] )

leagueGames: List Game -> WebData LeagueGames
leagueGames games = 
    RemoteData.Success ( LeagueGames "Div 1" games )

game: Game
game = 
    vanillaGame

gameWithNoDate: Game
gameWithNoDate = 
    vanillaGame

gameWithDate: Float -> Game
gameWithDate timestamp = 
    { vanillaGame | datePlayed = Just <| Date.fromTime <| Time.second * timestamp }

