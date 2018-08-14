module LeagueTable.View exposing (..)

import Html exposing (Html, div, h1, img)
import Element exposing (..)
import Element.Attributes exposing (..)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Team exposing (Team)


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        column LeagueTable [ width (percent 100), spacing 25, center ]
        [
            el Title [ width (percent 100), padding 25, center ] (text model.leagueTable.title)
            , column None [ class "teams" ]
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
                (List.map teamRow model.leagueTable.teams)
            )
        ]

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

-- view : Model -> Html Msg
-- view model =
--     div
--         [ class "league"
--         ]
--         [ h1 [] [ text model.leagueTable.title ]
--         , div [class "teams"] (List.map teamRow model.leagueTable.teams)
--         ]


-- teamRow : Team -> Html Msg
-- teamRow team =
--     div [ class "team" ] 
--     [ 
--         div [class "name"] [ text team.name ]
--         , div [class "points"] [ text (toString team.points) ]
--         , div [class "gamesPlayed"] [ text (toString team.gamesPlayed) ]
--         , div [class "goalsFor"] [ text (toString team.goalsFor) ]
--         , div [class "goalsAgainst"] [ text (toString team.goalsAgainst) ]
--         , div [class "goalDifference"] [ text (toString team.goalDifference) ]
--     ]
