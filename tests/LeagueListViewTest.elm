module LeagueListViewTest exposing (multipleLeagues)

import Fuzz exposing (list, string)
import Models.Config exposing (vanillaConfig)
import Models.LeagueSummary exposing (LeagueSummary)
import Pages.LeagueList.View exposing (..)
import Pages.RenderPage exposing (..)
import RemoteData exposing (WebData)
import Styles exposing (vanillaStyles)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text)


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
