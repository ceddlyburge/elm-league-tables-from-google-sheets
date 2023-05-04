module Pages.TopScorers.View exposing (page)

import Element exposing (Element, centerX, centerY, column, fill, maximum, row, text, width)
import Models.Player exposing (Player, Players, playerName, teamName)
import Msg exposing (Msg(..))
import Pages.HeaderBar exposing (HeaderBar, PageHeader(..), SubHeaderBar)
import Pages.HeaderBarItem exposing (HeaderBarItem(..))
import Pages.MaybeResponse exposing (maybeResponse)
import Pages.Page exposing (Page)
import Pages.ViewHelpers exposing (dataTestClass)
import RemoteData exposing (WebData)
import Styles exposing (Styles, elWithStyle, paragraphWithStyle)


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
                , dataTestClass "top-scorer-player-name"
                ]
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
