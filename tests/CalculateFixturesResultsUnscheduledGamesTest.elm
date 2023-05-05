module CalculateFixturesResultsUnscheduledGamesTest exposing (groupsUnscheduledGamesInNothingDay)

import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Expect exposing (Expectation)
import Fuzz exposing (intRange)
import Models.DecodedGame exposing (DecodedGame)
import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import ResultsFixturesHelpers exposing (expectDays, expectFirstDay, unscheduledGame)
import Test exposing (Test, fuzz)
import Time exposing (Posix)


groupsUnscheduledGamesInNothingDay : Test
groupsUnscheduledGamesInNothingDay =
    fuzz (intRange 1 100) "Groups all unscheduled games in a LeagueGamesForDay with a 'Nothing' day" <|
        \numberOfGames ->
            let
                games : List DecodedGame
                games =
                    List.repeat numberOfGames unscheduledGame
            in
            calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> Expect.all
                    [ expectDays 1
                    , expectFirstDay <| expectDate Nothing
                    , expectFirstDay <| expectNumberOfGames numberOfGames
                    ]


expectDate : Maybe Posix -> Maybe LeagueGamesForDay -> Expectation
expectDate expectedDate leagueGamesForDay =
    Expect.equal expectedDate (Maybe.andThen .date leagueGamesForDay)


expectNumberOfGames : Int -> Maybe LeagueGamesForDay -> Expectation
expectNumberOfGames expectedNumberOfGames leagueGamesForDay =
    Expect.equal (Just expectedNumberOfGames) (Maybe.map (\day -> List.length day.games) leagueGamesForDay)
