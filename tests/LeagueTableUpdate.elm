module LeagueTableUpdate exposing (..)

import Http exposing (..)
import Test exposing (..)
import Expect
import Update exposing (update)
import Msg exposing (..)
import Models.Config exposing (Config)
import Models.Model exposing (Model, vanillaModel)
import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (Game, LeagueGames)
import Models.Team exposing (Team)
import Models.State exposing (State)

apiError : Test
apiError =
    test "Returns model and cmd.none on error" <|
        \() ->
            update (IndividualSheetResponse (Err NetworkError)) vanillaModel
                |> Expect.equal ( vanillaModel, Cmd.none )


apiSuccess : Test
apiSuccess =
    test "Returns model and Leagues on success" <|
        \() ->
            update (IndividualSheetResponse (Ok (LeagueGames "Regional Div 1" [ game ]))) vanillaModel
            |> \(model, msg) -> model.leagueTable
            |> Expect.equal leagueTable

game: Game
game = 
    Game "Castle" 3 "Meridian" 1 "2018-06-04" "1, 6, 4" "2" "Green 3, Yellow 5" "Red 14" "good game"

leagueTable: LeagueTable
leagueTable = 
    LeagueTable 
        "Regional Div 1" 
        [ 
            Team "Castle" 1 3 3 1 2
            , Team "Meridian" 1 0 1 3 -2
        ]
