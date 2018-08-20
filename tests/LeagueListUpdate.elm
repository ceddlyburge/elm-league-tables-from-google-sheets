module LeagueListUpdate exposing (..)

import Http exposing (..)
import Test exposing (..)
import Fuzz exposing (list, string)
import Expect
import Update exposing (update)
import Msg exposing (..)
--import Models.Config exposing (Config)
import Models.Model exposing (Model, vanillaModel)
import Models.LeagueSummary exposing (LeagueSummary)
--import Models.LeagueTable exposing (LeagueTable)
import Models.State exposing (State)

apiError : Test
apiError =
    test "Returns model and cmd.none on error" <|
        \() ->
            update (AllSheetSummaryResponse (Err NetworkError)) vanillaModel
                |> Expect.equal ( vanillaModel, Cmd.none )


apiSuccess : Test
apiSuccess =
    fuzz (list string) "Returns model and Leagues on success" <|
        \leagues ->
            update (AllSheetSummaryResponse (Ok <| List.map LeagueSummary leagues)) vanillaModel
                |> Expect.equal ( { vanillaModel | state = Models.State.LeagueList, leagues = (List.map LeagueSummary leagues) }, Cmd.none )



