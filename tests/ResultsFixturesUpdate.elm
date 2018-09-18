module ResultsFixturesUpdate exposing (..)

import Test exposing (..)
import Expect
import RemoteData exposing (WebData)
import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)

apiSuccess : Test
apiSuccess =
    test "Updates model with LeagueGames on success" <|
        \() ->
            update (IndividualSheetResponseForResultsFixtures "" leagueGames) vanillaModel
            |> \(model, msg) -> model.leagueGames
            |> Expect.equal leagueGames

leagueGames: WebData LeagueGames
leagueGames = 
    RemoteData.Success ( LeagueGames "Div 1" [ game ] )

game: Game
game = 
    Game "Castle" (Just 3) "Meridian" (Just 1) "2018-06-04" "1, 6, 4" "2" "Green 3, Yellow 5" "Red 14" "good game"

