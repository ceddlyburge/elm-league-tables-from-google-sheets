module Pages.TopScorers.View exposing (page)

import Element exposing (..)
--import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import Pages.Responsive exposing (..)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.Player exposing (Player)
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
        [ RefreshHeaderButton <| RefreshResultsFixtures leagueTitle ]

topScorersElement : Responsive -> List Player -> Element Styles variation Msg
topScorersElement responsive resultsFixtures =
    el 
        None 
        []
        (text "hello")

