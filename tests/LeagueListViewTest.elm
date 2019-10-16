module LeagueListViewTest exposing (multipleLeagues)

import RemoteData exposing (WebData)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Fuzz exposing (list, string)

import Pages.LeagueList.View exposing (..)
import Pages.RenderPage exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Config exposing ( Config, vanillaConfig )
import Pages.Responsive exposing (..)


multipleLeagues : Test
multipleLeagues =
    fuzz (list string) "Displays multiple leagues correctly" <|
        \leagueTitles ->
                renderTestablePage 
                    vanillaResponsive
                    (page vanillaConfig (leagueListResponse leagueTitles) vanillaResponsive)
                |> Query.fromHtml
                |> Query.has (List.map text leagueTitles)


leagueListResponse : List String -> WebData (List LeagueSummary)
leagueListResponse leagueTitles =
    RemoteData.Success <| List.map LeagueSummary leagueTitles
