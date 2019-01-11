module Pages.LeagueList.View exposing (page)

import RemoteData exposing (WebData)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import Pages.Progressive exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing ( .. ) 
import Pages.HeaderBarItem exposing (..)


page : WebData (List LeagueSummary) -> Progressive -> Page
page response progressive =
    Page
        ( SingleHeader <| 
            HeaderBar 
                [ HeaderButtonSizedSpace ] 
                "Leagues" 
                [ RefreshHeaderButton AllSheetSummaryRequest ] )
        ( maybeResponse response <| leagueList progressive )

leagueList: Progressive -> List LeagueSummary -> Element Styles variation Msg
leagueList progressive leagueSummaries =
    column 
        None 
        [ 
            width (percent 100)
            , class "data-test-leagues"   
        ] 
        (List.map (leagueTitle progressive) leagueSummaries)

leagueTitle : Progressive -> LeagueSummary -> Element Styles variation Msg
leagueTitle progressive league =
    el 
        LeagueListLeagueTitle 
        [ 
            padding progressive.mediumGap
            , spacing progressive.smallGap
            , width (percent progressive.percentageWidthToUse)
            , class "data-test-league"
            , center
            , onClick <| IndividualSheetRequest league.title
        ] 
        (paragraph None [] [ text league.title ] )
 