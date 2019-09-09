module Pages.TopScorers.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import Date exposing (..)
import Date.Extra exposing (..)
import Pages.Responsive exposing (..)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.Game exposing (Game)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..) 
import Pages.HeaderBarItem exposing (..)


page : String -> WebData ResultsFixtures -> Responsive -> Page
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
        [ RefreshHeaderButton <| RefreshResultsFixtures leagueTitle ]

topScorersElement : Responsive -> ResultsFixtures -> Element Styles variation Msg
topScorersElement responsive resultsFixtures =
    el 
        None 
        []
        (text "hello")

