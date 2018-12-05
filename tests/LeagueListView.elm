module LeagueListView exposing (multipleLeagues)

import RemoteData exposing (WebData)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Fuzz exposing (list, string)

import Pages.LeagueList.View exposing (..)
import Pages.RenderPage exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Model exposing (vanillaModel)


multipleLeagues : Test
multipleLeagues =
    fuzz (list string) "Displays multiple leagues correctly" <|
        \leagueTitles ->
            renderPage 
                vanillaModel.device
                (page (leagueListResponse leagueTitles) vanillaModel.device)
            |> Query.fromHtml
            |> Query.has (List.map text leagueTitles)


leagueListResponse : List String -> WebData (List LeagueSummary)
leagueListResponse leagueTitles =
    RemoteData.Success <| List.map LeagueSummary leagueTitles
