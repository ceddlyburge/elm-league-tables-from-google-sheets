module LeagueTable.View exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (class)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Team exposing (Team)


view : Model -> Html Msg
view model =
    div
        [ class "league"
        ]
        [ h1 [] [ text model.leagueTable.title ]
        , div [] (List.map teamRow model.leagueTable.teams)
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
