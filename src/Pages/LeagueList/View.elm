module Pages.LeagueList.View exposing (page)

import RemoteData exposing (WebData)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import Pages.Gaps exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing ( .. ) 
import Pages.HeaderBarItem exposing (..)


page : WebData (List LeagueSummary) -> Device -> Page
page response device =
    Page
        ( SingleHeader <| 
            HeaderBar 
                [ HeaderButtonSizedSpace ] 
                "Leagues" 
                [ RefreshHeaderButton AllSheetSummaryRequest ] )
        ( maybeResponse response <| leagueList device )

leagueList: Device -> List LeagueSummary -> Element Styles variation Msg
leagueList device leagueSummaries =
    let
        gaps = gapsForDevice device
    in
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
 