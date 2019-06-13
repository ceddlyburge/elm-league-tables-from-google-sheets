module LeagueListUpdateTest exposing (..)

import Http exposing (..)
import Test exposing (..)
import Fuzz exposing (list, string)
import Expect exposing (..)
import RemoteData exposing (WebData)

import Update exposing (update)
import Msg exposing (..)
import Models.Model exposing (Model, vanillaModel)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Route as Route exposing (Route)
import Models.Animation as Animation exposing (Animation(..))

   
whenFetchFailsSetsAnimationTimerStateToFailedFetch : Test
whenFetchFailsSetsAnimationTimerStateToFailedFetch =
    test "whenFetchFailsSetsAnimationTimerStateToFailedFetch" <|
        \() ->
            let 
                response = RemoteData.Failure NetworkError
            in 
                update (AllSheetSummaryResponse response) vanillaModel
                |> getModel
                |> .leagueListAnimation
                |> expectFailedFetch

apiError : Test
apiError =
    test "Retains response on error" <|
        \() ->
            let 
                response = RemoteData.Failure NetworkError
            in 
                update (AllSheetSummaryResponse response) vanillaModel
                |> getModel
                |> .leagues
                |> Expect.equal response

-- this doesn't completely test that the api call gets make, but it would be strange code
-- that set leagues to RemoteData.Loading without also calling the Api
callsApi : Test
callsApi =
    test "Calls the APi if the results arent already available in the model" <|
        \() ->
            update 
                ShowLeagueList 
                vanillaModel
            |> getModel
            |> Expect.equal 
                { vanillaModel | 
                    leagues = RemoteData.Loading
                    , route = Route.LeagueList }

cachesApiResult : Test
cachesApiResult =
    test "Only calls the api if the results isn't already available in the model" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagues = RemoteData.Success []
                        , route = Route.LeagueList }
            in 
                update 
                    ShowLeagueList 
                    model
                |> Expect.equal ( model, Cmd.none )


refreshesAPi : Test
refreshesAPi =
    test "Calls the APi if asked to, even if the data already exists" <|
        \() ->
            let 
                model = 
                    { vanillaModel | 
                        leagues = RemoteData.Success []
                        , route = Route.LeagueList }
            in 
                update 
                    RefreshLeagueList 
                    model
                |> getModel
                |> Expect.equal { model | leagues = RemoteData.Loading }


apiSuccess : Test
apiSuccess =
    fuzz (list string) "Returns model and Leagues on success" <|
        \leagues ->
            let 
                response = RemoteData.Success <| List.map LeagueSummary leagues
            in 
                update (AllSheetSummaryResponse response) vanillaModel
                |> getModel
                |> .leagues
                |> Expect.equal response

getModel : (Model, Cmd Msg) -> Model
getModel (model, cmd) = 
    model

expectInactive: Animation -> Expectation
expectInactive animation = 
    case animation of
        Inactive ->
            Expect.pass
        _ ->
            Expect.fail <| "Expecting Inactive" ++ toString(animation)

expectsucccessfulFetch: Animation -> Expectation
expectsucccessfulFetch animation = 
    case animation of
        SuccessfulFetch _ ->
            Expect.pass
        _ ->
            Expect.fail <| "Expecting SuccessfulFetch, but was " ++ toString(animation)

expectFailedFetch: Animation -> Expectation
expectFailedFetch animation = 
    case animation of
        FailedFetch _ ->
            Expect.pass
        _ ->
            Expect.fail <| "Expecting FailedFetch"  ++ toString(animation)