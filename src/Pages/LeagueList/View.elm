module Pages.LeagueList.View exposing (view)

import RemoteData exposing (WebData)
import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import Pages.Components exposing (..)
import Pages.MaybeResponse exposing (..)


view : WebData (List LeagueSummary) -> Device -> Html Msg
view response device =
    let
        gaps = gapsForDevice device
    in
        body 
            device
            gaps  
            [
                heading
                    gaps
                    [
                        titleButtonSizedSpace
                        , title "Leagues"
                        , refreshTitleButton AllSheetSummaryRequest
                    ]
                , maybeResponse response (leagueList gaps)
            ]

leagueList: Gaps -> List LeagueSummary -> Element Styles variation Msg
leagueList gaps leagueSummaries =
    column 
        None 
        [ 
            width (percent 100)
            , class "leagues"   
        ] 
        (List.map (leagueTitle gaps) leagueSummaries)

leagueTitle : Gaps -> LeagueSummary -> Element Styles variation Msg
leagueTitle gaps league =
    el 
        LeagueListLeagueTitle 
        [ 
            padding gaps.medium
            , spacing gaps.small
            , width (percent gaps.percentageWidthToUse)
            , class "league"
            , center
            , onClick <| IndividualSheetRequest league.title
        ] 
        (paragraph None [] [ text league.title ] )
 