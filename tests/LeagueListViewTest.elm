module LeagueListViewTest exposing (multipleLeagues)

import RemoteData exposing (WebData)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text)
import Fuzz exposing (list, string)

import Pages.LeagueList.View exposing (..)
import Pages.RenderPage exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Config exposing ( vanillaConfig )
import Styles exposing (vanillaStyles)


multipleLeagues : Test
multipleLeagues =
    fuzz (list string) "Displays multiple leagues correctly" <|
        \leagueTitles ->
                renderTestablePage 
                    vanillaStyles
                    (page vanillaConfig (leagueListResponse leagueTitles) vanillaStyles)
                |> Query.fromHtml
                |> Query.has (List.map text leagueTitles)


leagueListResponse : List String -> WebData (List LeagueSummary)
leagueListResponse leagueTitles =
    RemoteData.Success <| List.map LeagueSummary leagueTitles
