module Pages.TopScorers.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
--import Http exposing (decodeUri)
import LeagueStyleElements exposing (..)
import Models.Player exposing (..)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import RemoteData exposing (WebData)


page : String -> WebData Players -> Responsive -> Page
page leagueTitle response progessive =
    Page
        (DoubleHeader
            (headerBar leagueTitle)
            (SubHeaderBar "Top Scorers")
        )
        (maybeResponse response <| topScorersElement progessive)


headerBar : String -> HeaderBar
headerBar leagueTitle =
    HeaderBar
        [ BackHeaderButton <| ShowLeagueTable leagueTitle ]
        leagueTitle
        [ RefreshHeaderButton <| RefreshTopScorers leagueTitle ]


topScorersElement : Responsive -> Players -> Element Styles variation Msg
topScorersElement responsive players =
    column
        None
        [ width (percent 100)
        , center
        , class "data-test-top-scorers"
        , padding responsive.bigGap
        , spacing responsive.bigGap
        ]
        (List.map (topScorer responsive) players.players)


topScorer : Responsive -> Player -> Element Styles variation Msg
topScorer responsive player =
    column
        None
        [ spacing responsive.smallGap
        , class "data-test-top-scorer"
        ]
        [ row
            None
            [ spacing responsive.bigGap
            ]
            [ paragraph
                TopScorerPlayerName
                [ minWidth <| px responsive.designPlayerNamePixelWidthBigFont
                , class "data-test-top-scorer-player-name"
                ]
                [ text <| playerName player ]
            , el
                TopScorerGoalCount
                [ verticalCenter
                , class "data-test-top-scorer-goal-count"
                ]
                (text <| String.fromInt player.goalCount)
            ]
        , paragraph
            TopScorerTeamName
            [ class "data-test-top-scorer-team-name" ]
            [ text <| teamName player ]
        ]
