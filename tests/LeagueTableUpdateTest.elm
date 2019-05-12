module LeagueTableUpdateTest exposing (..)

import Dict exposing (Dict)
import Test exposing (..)
import Expect
import RemoteData exposing (WebData)
import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.Game exposing (Game, vanillaGame)
import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueTable exposing (LeagueTable)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)

apiSuccess : Test
apiSuccess = 
    test "Calculates league table on success and adds to league table dictionary" <|
        \() ->
            update 
                (successResponseForGame leagueTitle game) 
                vanillaModel
            |> \(model, msg) -> model.leagueTables
            |> Expect.equal 
                (Dict.singleton 
                    leagueTitle
                    (calculatedLeagueTableRemoteData game)
                )

leagueTitle : String                
leagueTitle =
    "Regional Div 1"

game: Game
game = 
    { vanillaGame | 
        homeTeamName = "Castle",
        homeTeamGoals = Just 3, 
        awayTeamGoals = Just 1,
        awayTeamName = "Meridian"
    }

successResponseForGame : String -> Game -> Msg
successResponseForGame leagueTitle game = 
    IndividualSheetResponse 
        leagueTitle 
        (RemoteData.Success 
            (LeagueGames 
                leagueTitle
                [ game ]
            )
        ) 

calculatedLeagueTableRemoteData: Game -> WebData LeagueTable
calculatedLeagueTableRemoteData game = 
    RemoteData.Success 
        (calculateLeagueTable 
            (LeagueGames leagueTitle [ game ])
        ) 
    
