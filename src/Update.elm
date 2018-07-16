module Update exposing (update)

import Messages.Msg exposing (..)
import Models.Model exposing (..)
import LeagueList.Update exposing (update)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case model of
        LeagueList leagueListModel ->
            LeagueList.Update.update msg leagueListModel
            |> (leagueListModel, Cmd msg) -> (Models.LeagueList leagueListModel, Cmd msg)

        LeagueTable leagueTableModel ->
            ( model, Cmd.none )
