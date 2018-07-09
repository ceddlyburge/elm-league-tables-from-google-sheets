port module MainFunctions exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)

import Messages.Msg exposing ( Msg )
import Models.League exposing (League)
import Models.Model exposing (Model)

---- MODEL ----



---- VIEW ----


view : Model -> Html Msg
view model =
    div  
        [ 
            class "leagues"
            , onClick Messages.Msg.SheetRequest
        ] 
        [
            h1 [] [ text "Leagues" ]
            , div [] (List.map leagueTitle model.leagues)
        ]

leagueTitle : League -> Html Msg
leagueTitle league =
    div [ class "league"] [ text league.title ]
