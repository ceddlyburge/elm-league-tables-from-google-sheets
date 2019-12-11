module Pages.TopScorers.View exposing (page)

import Element exposing (..)
-- import Element.Attributes exposing (..)
import LeagueStyleElements exposing (..)
import Models.Player exposing (..)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import RemoteData exposing (WebData)
import Pages.ViewHelpers exposing (..)


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


topScorersElement : Responsive -> Players -> Element msg
topScorersElement responsive players =
    column
        None
        [ width fill
        , centerX --center
        , dataTestClass "top-scorers"
        , padding responsive.bigGap
        , spacing responsive.bigGap
        ]
        (List.map (topScorer responsive) players.players)


topScorer : Responsive -> Player -> Element msg
topScorer responsive player =
    column
        None
        [ spacing responsive.smallGap
        , dataTestClass "top-scorer"
        ]
        [ row
            None
            [ spacing responsive.bigGap
            ]
            [ paragraph
                TopScorerPlayerName
                [ minWidth <| px responsive.designPlayerNamePixelWidthBigFont
                , dataTestClass "top-scorer-player-name"
                ]
                [ text <| playerName player ]
            , el
                TopScorerGoalCount
                [ centerY --verticalCenter
                , dataTestClass "top-scorer-goal-count"
                ]
                (text <| String.fromInt player.goalCount)
            ]
        , paragraph
            TopScorerTeamName
            [ dataTestClass "top-scorer-team-name" ]
            [ text <| teamName player ]
        ]
