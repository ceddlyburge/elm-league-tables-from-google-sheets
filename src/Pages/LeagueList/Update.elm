module Pages.LeagueList.Update exposing (showLeagueList, refreshLeagueList, allSheetSummaryResponse)

import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Route as Route exposing (Route)
import GoogleSheet.Api exposing (fetchLeagueSummaries)
import Ports exposing (..)
import Models.Animation as Animation exposing (Animation(..))

showLeagueList : Model -> ( Model, Cmd Msg )
showLeagueList model =
    let
        modelWithRoute = { model | route = Route.LeagueList }
    in
        case model.leagues of
            RemoteData.Success _ ->
                (modelWithRoute, Cmd.none)
            RemoteData.Loading ->
                (modelWithRoute, Cmd.none)
            _ ->
                refreshLeagueList modelWithRoute


refreshLeagueList : Model -> ( Model, Cmd Msg )
refreshLeagueList model =
    ( { model | leagues = RemoteData.Loading }
      , fetchLeagueSummaries model.config AllSheetSummaryResponse )

allSheetSummaryResponse: Model -> WebData (List LeagueSummary) -> ( Model, Cmd Msg )
allSheetSummaryResponse model response = 
    ( { model | 
        leagues = response
        , leagueListAnimation = createAnimation response }
    , RemoteData.toMaybe response
        |> Maybe.map storeLeagues
        |> Maybe.withDefault Cmd.none )

createAnimation: WebData a -> Animation
createAnimation response =
    RemoteData.toMaybe response
    |> Maybe.map (\_ -> SuccessfulFetch 0)
    |> Maybe.withDefault (FailedFetch 0)