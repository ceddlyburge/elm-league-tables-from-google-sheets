module LeagueTable.View exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (class)

import Messages.Msg exposing (..)
import Models.Model exposing (LeagueTableModel)
import Models.Team exposing (Team)


view : LeagueTableModel -> Html Msg
view model =
    div
        [ class "league"
        ]
        [ h1 [] [ text model.league.title ]
        , div [] (List.map teamRow model.league.teams)
        ]


teamRow : Team -> Html Msg
teamRow team =
    div [ class "team" ] 
    [ 
        div [class "name"] [ text team.name ]
        , div [class "points"] [ text (toString team.points) ]
        , div [class "gamesPlayed"] [ text (toString team.gamesPlayed) ]
        , div [class "goalsFor"] [ text (toString team.goalsFor) ]
        , div [class "goalsAgainst"] [ text (toString team.goalsAgainst) ]
        , div [class "goalDifference"] [ text (toString team.goalDifference) ]
    ]
