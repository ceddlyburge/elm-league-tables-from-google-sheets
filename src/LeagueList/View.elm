module LeagueList.View exposing (view)

import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        column LeagueTable [ width (percent 100), spacing 25, center ]
        [
            el 
                Title 
                [ 
                    width (percent 100)
                    , padding 25
                    , center
                    , onClick AllSheetSummaryRequest 
                    , class "leaguesTitle"   
                ] 
                (text "Leagues")
            , column 
                None 
                [ 
                    width (percent 100)
                    , class "leagues"   
                ] 
                (List.map leagueTitle model.leagues)
        ]

leagueTitle : LeagueSummary -> Element Styles variation Msg
leagueTitle league =
    el 
        LeagueListLeagueTitle 
        [ 
            padding 10
            , spacing 7
            , width (percent 60)
            , class "league"
            , center
            , onClick (IndividualSheetRequest league.title)
        ] 
        (text league.title) 
