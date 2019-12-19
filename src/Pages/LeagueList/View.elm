module Pages.LeagueList.View exposing (page)

import Element exposing (..)
import Element.Events exposing (onClick)
import LeagueStyleElements exposing (..)
import Models.Config exposing (Config)
import Models.LeagueSummary exposing (LeagueSummary)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import Pages.ViewHelpers exposing (..)
import RemoteData exposing (WebData)
import Styles exposing (..)


page : Config -> WebData (List LeagueSummary) -> Responsive -> Page
page config response responsive =
    Page
        (SingleHeader <|
            HeaderBar
                [ HeaderButtonSizedSpace ]
                config.applicationTitle
                [ RefreshHeaderButton RefreshLeagueList ]
        )
        (maybeResponse response <| leagueList responsive)


leagueList : Responsive -> List LeagueSummary -> Element Msg
leagueList responsive leagueSummaries =
    column
        [ width fill
        , dataTestClass "leagues"
        ]
        (List.map (leagueTitle responsive) leagueSummaries)


leagueTitle : Responsive -> LeagueSummary -> Element Msg
leagueTitle responsive league =
    el
        (Styles.leagueListLeagueName responsive ++
        [ padding responsive.mediumGap
        , spacing responsive.smallGap
        , width <| fillPortion responsive.designPortraitPercentageWidth
        , dataTestClass "league"
        , centerX --center
        , onClick <| ShowLeagueTable league.title
        ])
        (paragraph [] [ text league.title ])
