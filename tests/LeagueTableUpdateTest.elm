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
import Models.LeagueTable exposing (..)
import Models.ResultsFixtures exposing (..)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Models.Route as Route exposing (Route)

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

-- this doesn't completely test that the api call gets make, but it would be strange code
-- that set leagues to RemoteData.Loading without also calling the Api
callsApi : Test
callsApi =
    test "Calls the APi if the results arent already available in the model" <|
        \() ->
            update 
                (ShowLeagueTable leagueTitle)
                vanillaModel
            |> getModel
            |> Expect.equal 
                { vanillaModel | 
                    leagueTables = Dict.singleton leagueTitle RemoteData.Loading
                    , resultsFixturess = Dict.singleton leagueTitle RemoteData.Loading
                    , route = Route.LeagueTableRoute leagueTitle }

cachesApiResult : Test
cachesApiResult =
    test "Only calls the api if the results isn't already available in the model" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagueTables = Dict.singleton leagueTitle (RemoteData.Success vanillaLeagueTable)
                        , resultsFixturess = Dict.singleton leagueTitle (RemoteData.Success vanillaResultsFixtures)
                    }
            in 
                update 
                    (ShowLeagueTable leagueTitle)
                    model
                |> Expect.equal ( { model | route = Route.LeagueTableRoute leagueTitle }, Cmd.none )


refreshesApi : Test
refreshesApi =
    test "Calls the APi if asked to, even if the data already exists" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagueTables = Dict.singleton leagueTitle (RemoteData.Success vanillaLeagueTable)
                        , resultsFixturess = Dict.singleton leagueTitle (RemoteData.Success vanillaResultsFixtures)
                    }
            in 
                update 
                    (RefreshLeagueTable leagueTitle)
                    model
                |> getModel
                |> Expect.equal 
                    { model | 
                        leagueTables = Dict.singleton leagueTitle RemoteData.Loading
                        , resultsFixturess = Dict.singleton leagueTitle RemoteData.Loading
                        , route = Route.LeagueTableRoute leagueTitle }


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
    
getModel : (Model, Cmd Msg) -> Model
getModel (model, cmd) = 
    model
