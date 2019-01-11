module Pages.LeagueList.View exposing (page)

import RemoteData exposing (WebData)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import Pages.Responsive exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing ( .. ) 
import Pages.HeaderBarItem exposing (..)


page : WebData (List LeagueSummary) -> Responsive -> Page
page response responsive =
    Page
        ( SingleHeader <| 
            HeaderBar 
                [ HeaderButtonSizedSpace ] 
                "Leagues" 
                [ RefreshHeaderButton AllSheetSummaryRequest ] )
        ( maybeResponse response <| leagueList responsive )

leagueList: Responsive -> List LeagueSummary -> Element Styles variation Msg
leagueList responsive leagueSummaries =
    column 
        None 
        [ 
            width (percent 100)
            , class "data-test-leagues"   
        ] 
        (List.map (leagueTitle responsive) leagueSummaries)

leagueTitle : Responsive -> LeagueSummary -> Element Styles variation Msg
leagueTitle responsive league =
    el 
        LeagueListLeagueTitle 
        [ 
            padding responsive.mediumGap
            , spacing responsive.smallGap
            , width (percent responsive.percentageWidthToUse)
            , class "data-test-league"
            , center
            , onClick <| IndividualSheetRequest league.title
        ] 
        (paragraph None [] [ text league.title ] )
 