module LeagueTable.View exposing (..)

import Html exposing (Html, text, div, h1, img)


--import Html.Attributes exposing (src, class)
--import Html.Events exposing (onClick)

import Messages.Msg exposing (..)
import Models.Model exposing (LeagueTableModel)


--import Models.LeagueSummary exposing ( LeagueSummary )


view : LeagueTableModel -> Html Msg
view model =
    div [] []
