module Pages.TopScorers.View exposing (page)

import Element exposing (..)
import Styles exposing (..)
import Models.Player exposing (..)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import RemoteData exposing (WebData)
import Pages.ViewHelpers exposing (..)


page : String -> WebData Players -> Styles -> Page
page leagueTitle response styles =
    Page
        (DoubleHeader
            (headerBar leagueTitle)
            (SubHeaderBar "Top Scorers")
        )
        (maybeResponse response (topScorersElement styles) styles)


headerBar : String -> HeaderBar
headerBar leagueTitle =
    HeaderBar
        [ BackHeaderButton <| ShowLeagueTable leagueTitle ]
        leagueTitle
        [ RefreshHeaderButton <| RefreshTopScorers leagueTitle ]


topScorersElement : Styles -> Players -> Element Msg
topScorersElement styles players =
    column
        [ centerX
        , styles.bigPadding
        , styles.bigSpacing
        , dataTestClass "top-scorers"
        ]
        (List.map (topScorer styles) players.players)


topScorer : Styles -> Player -> Element Msg
topScorer styles player =
    column
        [ styles.smallSpacing
        , dataTestClass "top-scorer"
        ]
        [ row
            [ styles.bigSpacing ]
            [ paragraphWithStyle
                styles.topScorerPlayerName
                [ -- probably worth making this width tidier somehow 
                  width (styles.designPlayerNameWidthBigFont |> maximum (styles.percentagePageWidth 0.8)) 
                , dataTestClass "top-scorer-player-name" ]
                [ text <| playerName player ]
            , elWithStyle
                styles.topScorerGoalCount
                [ centerY
                , dataTestClass "top-scorer-goal-count"
                ]
                (text <| String.fromInt player.goalCount)
            ]
            , paragraphWithStyle
                styles.topScorerTeamName
                [ width fill
                , dataTestClass "top-scorer-team-name" 
                ]
                [ text <| teamName player ]
        ]
