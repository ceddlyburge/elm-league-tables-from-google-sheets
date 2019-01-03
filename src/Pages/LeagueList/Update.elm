module Pages.LeagueList.Update exposing (allSheetSummaryRequest, allSheetSummaryResponse)

import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Route as Route exposing (Route)
import Routing exposing (toUrl)
import GoogleSheet.Api exposing (fetchLeagueSummaries)


allSheetSummaryRequest : Model -> ( Model, Cmd Msg )
allSheetSummaryRequest model =
    ( { model | 
            leagues = RemoteData.Loading
            , route = Route.LeagueListRoute 
      }
      , fetchLeagueSummaries model.config AllSheetSummaryResponse )

allSheetSummaryResponse: Model -> WebData (List LeagueSummary) -> ( Model, Cmd Msg )
allSheetSummaryResponse model response = 
    ( { model | leagues = response }, newUrl <| toUrl <| model.route )

