module View exposing (view)

import Html exposing (Html)

import Msg exposing (..)
import Models.Model exposing ( Model )
import LeagueList.View exposing (view)
import LeagueTable.View exposing (view)


view : Model -> Html Msg
view model =
    if (model.leagueTable.title /= "") then
        LeagueTable.View.view model
    else
        LeagueList.View.view model



