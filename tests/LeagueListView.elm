module LeagueListView exposing (multipleLeagues)

import RemoteData exposing (WebData)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Fuzz exposing (list, string)

import LeagueList.View exposing (view)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Model exposing (vanillaModel)


multipleLeagues : Test
multipleLeagues =
    fuzz (list string) "Displays multiple leagues correctly" <|
        \leagueTitles ->
            view (leagueListResponse leagueTitles) vanillaModel.device
                |> Query.fromHtml
                |> Query.has (List.map text leagueTitles)


leagueListResponse : List String -> WebData (List LeagueSummary)
leagueListResponse leagueTitles =
    RemoteData.Success <| List.map LeagueSummary leagueTitles
