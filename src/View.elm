module View exposing (view)

import Html exposing (Html)

import Msg exposing (..)
import Models.Model exposing ( Model )
import Models.State as State exposing ( State )
import LeagueList.View exposing (view)
import LeagueTable.View exposing (view)


view : Model -> Html Msg
view model =
    case model.state of
        State.LeagueList ->
            LeagueList.View.view model
        State.LeagueTable ->
            LeagueTable.View.view model
