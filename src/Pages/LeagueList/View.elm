module Pages.LeagueList.View exposing (view)

import RemoteData exposing (WebData)
import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import Pages.ViewComponents exposing (..)
import Pages.MaybeResponse exposing (..)


body: Device -> Gaps -> List (Element Styles variation msg) -> Html msg
body device gaps elements = 
    Element.layout (stylesheet device) <|         
        column 
            Body 
            [ width (percent 100), spacing gaps.big, center ]
            elements

header: Gaps -> List (Element Styles variation msg) -> Element.Element Styles variation msg
header gaps elements = 
    row 
        Title 
        [ width (percent 100), padding gaps.big, verticalCenter, center ] 
        [
            row 
                None 
                [ center, spacing gaps.big, width (percent 100) ]
                elements
        ]
      
view : WebData (List LeagueSummary) -> Device -> Html Msg
view response device =
    let
        gaps = gapsForDevice device
    in
        body 
            device
            gaps  
            [
                header
                    gaps
                    [
                        el Hidden [ ] backIcon
                        , el Title [ width fill, center ] (text "Leagues")
                        , el TitleButton [ class "refresh", onClick AllSheetSummaryRequest ] refreshIcon
                    ]
                , maybeResponse response (leagueList gaps)
            ]
        -- Element.layout (stylesheet device) <|         
        --     column Body [ width (percent 100), spacing gaps.big, center ]
        --         [
        --             row 
        --                 Title 
        --                 [ width (percent 100), padding gaps.big, verticalCenter, center ] 
        --                 [
        --                     row None [ center, spacing gaps.big, width (percent 100)   ]
        --                     [
        --                         el Hidden [ ] backIcon
        --                         , el Title [ width fill, center ] (text "Leagues")
        --                         , el TitleButton [ class "refresh", onClick AllSheetSummaryRequest ] refreshIcon
        --                     ]
        --                 ]
        --             , maybeResponse response (leagueList gaps)
        --         ]

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
 