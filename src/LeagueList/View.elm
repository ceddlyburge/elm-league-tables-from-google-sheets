module LeagueList.View exposing (view)

import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)
import ViewComponents exposing (backIcon, refreshIcon)
import Routing exposing (..)


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
                        el Hidden [ ] backIcon
                        , el Title [ width fill, center ] (text "Leagues")
                        , el TitleButton [ class "refresh", onClick AllSheetSummaryRequest ] refreshIcon
                    ]
                ]
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
            , onClick <| IndividualSheetRequest league.title
        ] 
        (text league.title)
