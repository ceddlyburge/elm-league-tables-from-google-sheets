module LeagueTable.View exposing (..)

import Html exposing (Html, span)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import ViewComponents exposing (backIcon, refreshIcon, loading)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueTable exposing (LeagueTable)
import Models.Team exposing (Team)
import ErrorMessages exposing (httpErrorMessage, unexpectedNotAskedMessage)


view : String -> WebData LeagueTable -> Device -> Html Msg
view leagueTitle response device =
    Element.layout (stylesheet device) <|         
        column Body [ width (percent 100), spacing 25, center ]
        [
            row 
                Title 
                [ width (percent 100), padding 25, verticalCenter ] 
                [
                    row None [ center, spacing 25, width (percent 100)   ]
                    [
                        el TitleButton [ onClick AllSheetSummaryRequest ] backIcon
                        , el Title [ width fill, center ] (text <| Maybe.withDefault "" (decodeUri leagueTitle))
                        , el TitleButton [ onClick <| IndividualSheetRequest leagueTitle ] refreshIcon
                    ]
                ]
                , maybeLeagueTable response
            ]

maybeLeagueTable : WebData LeagueTable -> Element Styles variation Msg
maybeLeagueTable response =
    case response of
        RemoteData.NotAsked ->
            leagueTableText unexpectedNotAskedMessage

        RemoteData.Loading ->
            loading

        RemoteData.Success leagueTable ->
            leagueTableElement leagueTable

        RemoteData.Failure error ->
            leagueTableText <| httpErrorMessage error

leagueTableElement : LeagueTable -> Element Styles variation Msg
leagueTableElement leagueTable =
    column None [ class "teams" ]
    (
        [
            row HeaderRow [ padding 10, spacing 7, center ] 
            [
                el LeagueTableTeamName [ width (px 200) ] (text "Team")
                , el LeagueTablePoints [ width (px 100) ] (text "Points")
                , el LeagueTableGamesPlayed [ width (px 100) ] (text "Played")
                , el LeagueTableGoalDifference [ width (px 120) ] (text "Goal\nDifference")
                , el LeagueTableGoalsFor [ width (px 100) ] (text "Goals\nFor")
                , el LeagueTableGoalsAgainst [ width (px 100) ] (text "Goals\nAgainst")
            ]
        ]
        ++ 
        (List.map teamRow leagueTable.teams)
    )

teamRow : Team -> Element Styles variation Msg
teamRow team =
    row DataRow [ padding 10, spacing 7, center, class "team" ] 
    [ 
        el LeagueTableTeamName [ width (px 200), class "name" ] (text team.name)
        , el LeagueTablePoints [ width (px 100), class "points" ] (text (toString team.points) )
        , el LeagueTableGamesPlayed [ width (px 100), class "gamesPlayed" ] (text (toString team.gamesPlayed) )
        , el LeagueTableGoalDifference [ width (px 120), class "goalDifference" ] (text (toString team.goalDifference) )
        , el LeagueTableGoalsFor [ width (px 100), class "goalsFor" ] (text (toString team.goalsFor) )
        , el LeagueTableGoalsAgainst [ width (px 100), class "goalsAgainst" ] (text (toString team.goalsAgainst) )
    ]

leagueTableText: String -> Element Styles variation Msg
leagueTableText string =
    el LeagueListText [] <| text string