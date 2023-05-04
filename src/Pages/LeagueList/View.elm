module Pages.LeagueList.View exposing (page)

import Element exposing (Element, centerX, column, fill, paragraph, text, width)
import Element.Events exposing (onClick)
import Models.Config exposing (Config)
import Models.LeagueSummary exposing (LeagueSummary)
import Msg exposing (Msg(..))
import Pages.HeaderBar exposing (HeaderBar, PageHeader(..))
import Pages.HeaderBarItem exposing (HeaderBarItem(..))
import Pages.MaybeResponse exposing (maybeResponse)
import Pages.Page exposing (Page)
import Pages.ViewHelpers exposing (dataTestClass)
import RemoteData exposing (WebData)
import Styles exposing (Styles)


page : Config -> WebData (List LeagueSummary) -> Styles -> Page
page config response styles =
    Page
        (SingleHeader <|
            HeaderBar
                [ HeaderButtonSizedSpace ]
                config.applicationTitle
                [ RefreshHeaderButton RefreshLeagueList ]
        )
        (maybeResponse response (leagueList styles) styles)


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
        [ styles.mediumPadding
        , styles.smallSpacing
        , width styles.fillToDesignPortraitWidth
        , centerX
        , onClick <| ShowLeagueTable league.title
        , dataTestClass "league"
        ]
        (paragraph [] [ text league.title ])
