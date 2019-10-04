module Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)

import Date exposing (..)
import Date.Extra exposing (..)
import List.Gather exposing (..)
import Models.Game exposing (Game)
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


groupGamesByDate : List Game -> List ( Game, List Game )
groupGamesByDate games =
    List.Gather.gatherWith gameDatesEqual games


gameDatesEqual : Game -> Game -> Bool
gameDatesEqual game1 game2 =
    maybeDatesEqual game1.datePlayed game2.datePlayed


maybeDatesEqual : Maybe Date -> Maybe Date -> Bool
maybeDatesEqual maybeDate1 maybeDate2 =
    Maybe.map2 datesEqual maybeDate1 maybeDate2
        == Just True
        || maybeDate1
        == maybeDate2


datesEqual : Date -> Date -> Bool
datesEqual date1 date2 =
    Date.Extra.floor Day date1 == Date.Extra.floor Day date2


leagueGamesForDay : ( Game, List Game ) -> LeagueGamesForDay
leagueGamesForDay ( firstGame, remainingGames ) =
    LeagueGamesForDay
        (Maybe.map (Date.Extra.floor Day) firstGame.datePlayed)
        (List.sortWith gamesAscendingDate (firstGame :: remainingGames))


dateOfFirstGame : List Game -> Maybe Date
dateOfFirstGame games =
    Maybe.andThen .datePlayed (List.head games)


gamesAscendingDate : Game -> Game -> Order
gamesAscendingDate game1 game2 =
    compareMaybeDate game1.datePlayed game2.datePlayed


daysDescendingDate : LeagueGamesForDay -> LeagueGamesForDay -> Order
daysDescendingDate day1 day2 =
    compareMaybeDate day2.date day1.date


compareMaybeDate : Maybe Date -> Maybe Date -> Order
compareMaybeDate date1 date2 =
    case ( date1, date2 ) of
        ( Nothing, Nothing ) ->
            EQ

        ( Nothing, Just _ ) ->
            LT

        ( Just _, Nothing ) ->
            GT

        ( Just date1, Just date2 ) ->
            Date.Extra.compare date1 date2
