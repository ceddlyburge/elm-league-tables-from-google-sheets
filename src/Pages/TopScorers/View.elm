module Pages.TopScorers.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import Pages.Responsive exposing (..)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.Player exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..) 
import Pages.HeaderBarItem exposing (..)


page : String -> WebData (List Player) -> Responsive -> Page
page leagueTitle response progessive =
    Page
        ( DoubleHeader  
            (headerBar leagueTitle)
            (SubHeaderBar "Top Scorers"))
        ( maybeResponse response <| topScorersElement progessive )

headerBar: String -> HeaderBar
headerBar leagueTitle = 
    HeaderBar 
        [ BackHeaderButton <| ShowLeagueTable leagueTitle ] 
        (Maybe.withDefault "" <| decodeUri leagueTitle)
        [ RefreshHeaderButton <| RefreshTopScorers leagueTitle ]

topScorersElement : Responsive -> List Player -> Element Styles variation Msg
topScorersElement responsive players =
    column 
        None 
        [ width (percent 100)
        , center
        , class "data-test-top-scorers"   
        , padding responsive.bigGap
        , spacing responsive.bigGap
        ] 
        (List.map (topScorer responsive) players)

topScorer : Responsive -> Player -> Element Styles variation Msg
topScorer responsive player =
    column
        None
        [ spacing responsive.smallGap ]
        [ row
            None
            [ spacing responsive.bigGap
            ] 
            [ paragraph 
                TopScorerPlayerName 
                [ minWidth <| px responsive.designPlayerNamePixelWidthBigFont ] 
                [ text <| playerName player ]
            , el 
                TopScorerGoalCount 
                [ verticalCenter ] 
                (text <| toString player.goalCount)
            ]
        , paragraph TopScorerTeamName [] [ text <| teamName player ]    
        ]
