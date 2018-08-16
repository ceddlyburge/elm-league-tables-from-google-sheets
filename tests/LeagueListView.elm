module LeagueListView exposing (multipleLeagues)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Fuzz exposing (list, string)
import LeagueList.View exposing (view)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Model exposing (Model, vanillaModel)


multipleLeagues : Test
multipleLeagues =
    fuzz (list string) "Displays multiple leagues correctly" <|
        \leagueTitles ->
            view (modelWithLeagues leagueTitles)
                |> Query.fromHtml
                |> Query.has (List.map text leagueTitles)


modelWithLeagues : List String -> Model
modelWithLeagues leagueTitles =
    { vanillaModel | leagues = List.map LeagueSummary leagueTitles }
