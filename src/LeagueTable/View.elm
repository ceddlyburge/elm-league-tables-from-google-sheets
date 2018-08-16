module LeagueTable.View exposing (..)

import Html exposing (Html, span)
import Html.Attributes exposing (class)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Team exposing (Team)


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        column LeagueTable [ width (percent 100), spacing 25, center ]
        [
            row 
                Title 
                [ width (percent 100), padding 25, verticalCenter ] 
                [
                    row None [ center, spacing 25, width (percent 100)   ]
                    [
                        row TitleButton [ onClick AllSheetSummaryRequest ] [ backIcon ]
                        , el Title [ width fill, center ] (text model.leagueTable.title)
                        , row TitleButton [ onClick (IndividualSheetRequest model.leagueTable.title) ] [ refreshIcon ]
                    ]
                ]
            , column None [ Element.Attributes.class "teams" ]
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

backIcon : Element style variation msg
backIcon =
    Html.span [ Html.Attributes.class "fas fa-arrow-alt-circle-left" ] []
        |> Element.html

refreshIcon : Element style variation msg
refreshIcon =
    Html.span [ Html.Attributes.class "fas fa-sync-alt" ] []
        |> Element.html

teamRow : Team -> Element Styles variation Msg
teamRow team =
    row DataRow [ padding 10, spacing 7, center, Element.Attributes.class "team" ] 
    [ 
        el LeagueTableTeamName [ width (px 200), Element.Attributes.class "name" ] (text team.name)
        , el LeagueTablePoints [ width (px 100), Element.Attributes.class "points" ] (text (toString team.points) )
        , el LeagueTableGamesPlayed [ width (px 100), Element.Attributes.class "gamesPlayed" ] (text (toString team.gamesPlayed) )
        , el LeagueTableGoalDifference [ width (px 120), Element.Attributes.class "goalDifference" ] (text (toString team.goalDifference) )
        , el LeagueTableGoalsFor [ width (px 100), Element.Attributes.class "goalsFor" ] (text (toString team.goalsFor) )
        , el LeagueTableGoalsAgainst [ width (px 100), Element.Attributes.class "goalsAgainst" ] (text (toString team.goalsAgainst) )
    ]
