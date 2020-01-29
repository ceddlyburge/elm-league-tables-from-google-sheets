module Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)

import Dict exposing (..)
import Dict.Extra exposing (..)
import Time exposing (..)
import Time.Extra exposing (..)
import List.Extra exposing (gatherWith)
import Models.DecodedGame exposing (DecodedGame)
import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.ResultsFixtures exposing (ResultsFixtures)


calculateResultsFixtures : LeagueGames -> ResultsFixtures
calculateResultsFixtures leagueGames =
    ResultsFixtures
        leagueGames.leagueTitle
        (groupGamesByDate leagueGames.games
            |> List.map leagueGamesForDay
            |> List.sortWith daysDescendingDate
        )


groupGamesByDate : List DecodedGame -> List ( DecodedGame, List DecodedGame )
groupGamesByDate games =
    gatherWith gameDatesEqual games


gameDatesEqual : DecodedGame -> DecodedGame -> Bool
gameDatesEqual game1 game2 =
    maybeDatesEqual game1.datePlayed game2.datePlayed


maybeDatesEqual : Maybe Posix -> Maybe Posix -> Bool
maybeDatesEqual maybeDate1 maybeDate2 =
    Maybe.map2 datesEqual maybeDate1 maybeDate2
        == Just True
        || maybeDate1
        == maybeDate2


datesEqual : Posix -> Posix -> Bool
datesEqual date1 date2 =
    Time.Extra.floor Day utc date1 == Time.Extra.floor Day utc date2


leagueGamesForDay : ( DecodedGame, List DecodedGame ) -> LeagueGamesForDay
leagueGamesForDay ( firstGame, remainingGames ) =
    LeagueGamesForDay
        (Maybe.map (Time.Extra.floor Day utc) firstGame.datePlayed)
        (List.sortWith gamesAscendingDate (firstGame :: remainingGames))


gamesAscendingDate : DecodedGame -> DecodedGame -> Order
gamesAscendingDate game1 game2 =
    compareMaybeDate game1.datePlayed game2.datePlayed


daysDescendingDate : LeagueGamesForDay -> LeagueGamesForDay -> Order
daysDescendingDate day1 day2 =
    compareMaybeDate day2.date day1.date


compareMaybeDate : Maybe Posix -> Maybe Posix -> Order
compareMaybeDate date1 date2 =
    case ( date1, date2 ) of
        ( Nothing, Nothing ) ->
            EQ

        ( Nothing, Just _ ) ->
            LT

        ( Just _, Nothing ) ->
            GT

        ( Just dateOne, Just dateTwo ) ->
            compare (posixToMillis  dateOne) (posixToMillis dateTwo)