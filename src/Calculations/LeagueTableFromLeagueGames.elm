module Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)

import Calculations.SortBy exposing (..)
import List.Extra exposing (unique)
import Models.DecodedGame exposing (DecodedGame)
import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueTable exposing (LeagueTable)
import Models.Team exposing (Team)


calculateLeagueTable : LeagueGames -> LeagueTable
calculateLeagueTable leagueGames =
    let
        homeTeams =
            List.map (\game -> game.homeTeamName) leagueGames.games

        awayTeams =
            List.map (\game -> game.awayTeamName) leagueGames.games

        teamNames =
            List.append homeTeams awayTeams |> unique

        goalsFor2 =
            List.map (goalsFor leagueGames.games) teamNames

        goalsAgainst2 =
            List.map (goalsAgainst leagueGames.games) teamNames

        gamesPlayed2 =
            List.map (gamesPlayed leagueGames.games) teamNames

        points2 =
            List.map (points leagueGames.games) teamNames

        unpositionedTeams =
            List.map (unpositionedTeam leagueGames.games) teamNames

        sortedTeams =
            List.sortWith (by .points DESC |> andThen .goalDifference DESC |> andThen .goalsFor DESC) unpositionedTeams

        positionedTeams =
            List.indexedMap positionedTeam sortedTeams
    in
    LeagueTable
        leagueGames.leagueTitle
        positionedTeams


positionedTeam : Int -> Team -> Team
positionedTeam position team =
    { team | position = position + 1 }


unpositionedTeam : List DecodedGame -> String -> Team
unpositionedTeam games teamName =
    Team
        0
        teamName
        (gamesPlayed games teamName)
        (won games teamName)
        (drawn games teamName)
        (lost games teamName)
        (points games teamName)
        (goalsFor games teamName)
        (goalsAgainst games teamName)
        (goalsFor games teamName - goalsAgainst games teamName)


won : List DecodedGame -> String -> Int
won games teamName =
    List.foldl (\current total -> total + current) 0 (List.map (\game -> gameWon teamName game) games)


gameWon : String -> DecodedGame -> Int
gameWon teamName game =
    if teamName == game.homeTeamName then
        homeWon game

    else if teamName == game.awayTeamName then
        awayWon game

    else
        0


homeWon : DecodedGame -> Int
homeWon game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            if homeTeamGoalCount > awayTeamGoalCount then
                1

            else
                0

        ( _, _ ) ->
            0


awayWon : DecodedGame -> Int
awayWon game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            if homeTeamGoalCount < awayTeamGoalCount then
                1

            else
                0

        ( _, _ ) ->
            0


drawn : List DecodedGame -> String -> Int
drawn games teamName =
    -- could turn this in to a function (aggregateIntegers or something)
    List.foldl (\current total -> total + current) 0 (List.map (\game -> gameDrawn teamName game) games)


gameDrawn : String -> DecodedGame -> Int
gameDrawn teamName game =
    if teamName == game.homeTeamName then
        homeDrawn game

    else if teamName == game.awayTeamName then
        awayDrawn game

    else
        0


homeDrawn : DecodedGame -> Int
homeDrawn game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            if homeTeamGoalCount == awayTeamGoalCount then
                1

            else
                0

        ( _, _ ) ->
            0


awayDrawn : DecodedGame -> Int
awayDrawn game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            if homeTeamGoalCount == awayTeamGoalCount then
                1

            else
                0

        ( _, _ ) ->
            0


lost : List DecodedGame -> String -> Int
lost games teamName =
    List.foldl (\current total -> total + current) 0 (List.map (\game -> gameLost teamName game) games)


gameLost : String -> DecodedGame -> Int
gameLost teamName game =
    if teamName == game.homeTeamName then
        homeLost game

    else if teamName == game.awayTeamName then
        awayLost game

    else
        0


homeLost : DecodedGame -> Int
homeLost game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            if homeTeamGoalCount < awayTeamGoalCount then
                1

            else
                0

        ( _, _ ) ->
            0


awayLost : DecodedGame -> Int
awayLost game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            if homeTeamGoalCount > awayTeamGoalCount then
                1

            else
                0

        ( _, _ ) ->
            0


points : List DecodedGame -> String -> Int
points games teamName =
    List.foldl (\gameGoals totalGoals -> totalGoals + gameGoals) 0 (List.map (\game -> gamePoints teamName game) games)


gamePoints : String -> DecodedGame -> Int
gamePoints teamName game =
    if teamName == game.homeTeamName then
        homePoints game

    else if teamName == game.awayTeamName then
        awayPoints game

    else
        0


homePoints : DecodedGame -> Int
homePoints game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            if homeTeamGoalCount > awayTeamGoalCount then
                3

            else if homeTeamGoalCount < awayTeamGoalCount then
                0

            else
                1

        ( _, _ ) ->
            0


awayPoints : DecodedGame -> Int
awayPoints game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just homeTeamGoalCount, Just awayTeamGoalCount ) ->
            if homeTeamGoalCount > awayTeamGoalCount then
                0

            else if homeTeamGoalCount < awayTeamGoalCount then
                3

            else
                1

        ( _, _ ) ->
            0


gamesPlayed : List DecodedGame -> String -> Int
gamesPlayed games teamName =
    List.foldl (\gameGoals totalGoals -> totalGoals + gameGoals) 0 (List.map (\game -> gameGamesPlayed teamName game) games)


gameGamesPlayed : String -> DecodedGame -> Int
gameGamesPlayed teamName game =
    case ( game.homeTeamGoalCount, game.awayTeamGoalCount ) of
        ( Just _, Just _ ) ->
            if teamName == game.homeTeamName then
                1

            else if teamName == game.awayTeamName then
                1

            else
                0

        ( _, _ ) ->
            0


goalsAgainst : List DecodedGame -> String -> Int
goalsAgainst games teamName =
    List.foldl (\gameGoals totalGoals -> totalGoals + gameGoals) 0 (List.map (\game -> gameGoalsAgainst teamName game) games)


gameGoalsAgainst : String -> DecodedGame -> Int
gameGoalsAgainst teamName game =
    if teamName == game.homeTeamName then
        Maybe.withDefault 0 game.awayTeamGoalCount

    else if teamName == game.awayTeamName then
        Maybe.withDefault 0 game.homeTeamGoalCount

    else
        0


goalsFor : List DecodedGame -> String -> Int
goalsFor games teamName =
    List.foldl (\gameGoals totalGoals -> totalGoals + gameGoals) 0 (List.map (\game -> gameGoalsFor teamName game) games)


gameGoalsFor : String -> DecodedGame -> Int
gameGoalsFor teamName game =
    if teamName == game.homeTeamName then
        Maybe.withDefault 0 game.homeTeamGoalCount

    else if teamName == game.awayTeamName then
        Maybe.withDefault 0 game.awayTeamGoalCount

    else
        0
