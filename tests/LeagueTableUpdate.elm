module LeagueTableUpdate exposing (..)

import Test exposing (..)
import Expect
import RemoteData exposing (WebData)
import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)
import Models.Team exposing (Team)

apiSuccess : Test
apiSuccess =
    test "Returns model and Leagues on success" <|
        \() ->
            update (IndividualSheetResponse "" (RemoteData.Success (LeagueGames "Regional Div 1" [ game ]))) vanillaModel
            |> \(model, msg) -> model.leagueTable
            |> Expect.equal leagueTable

game: Game
game = 
    Game "Castle" (Just 3) "Meridian" (Just 1) Nothing "1, 6, 4" "2" "Green 3, Yellow 5" "Red 14" "good game"

leagueTable: WebData LeagueTable
leagueTable = 
    RemoteData.Success 
        (LeagueTable 
            "Regional Div 1" 
            [ 
                Team 1 "Castle" 1 1 0 0 3 3 1 2
                , Team 2 "Meridian" 1 0 0 1 0 1 3 -2
            ]
        )
