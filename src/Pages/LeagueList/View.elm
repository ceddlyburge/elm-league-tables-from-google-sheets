module Pages.LeagueList.View exposing (page)

import Element exposing (..)
import Element.Events exposing (onClick)
import Models.Config exposing (Config)
import Models.LeagueSummary exposing (LeagueSummary)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.ViewHelpers exposing (..)
import RemoteData exposing (WebData)
import Styles exposing (..)


page : Config -> WebData (List LeagueSummary) -> Styles-> Page
page config response styles =
    Page
        (SingleHeader <|
            HeaderBar
                [ HeaderButtonSizedSpace ]
                config.applicationTitle
                [ RefreshHeaderButton RefreshLeagueList ]
        )
        (maybeResponse response <| leagueList styles)


leagueList : Styles -> List LeagueSummary -> Element Msg
leagueList styles leagueSummaries =
    column
        [ width fill
        , dataTestClass "leagues"
        ]
        (List.map (leagueTitle styles) leagueSummaries)


leagueTitle : Styles -> LeagueSummary -> Element Msg
leagueTitle styles league =
    Styles.elWithStyle
        styles.leagueListLeagueName
        [ padding styles.responsive.mediumGap
        , spacing styles.responsive.smallGap
        , width styles.fillToDesignPortraitWidth
        , centerX
        , onClick <| ShowLeagueTable league.title
        , dataTestClass "league"
        ]
        (paragraph [] [ text league.title ])
