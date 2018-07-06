port module MainFunctions exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)
import Http

import Messages.Msg exposing ( Msg )
import Models.League exposing (League)
import Models.Model exposing (Model)
import Models.Config exposing (Config)
import Updates.DecodeGoogleSheetToLeagueList exposing (..)
import Updates.RequestGoogleSheetAllTabs exposing (..)

---- MODEL ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        Messages.Msg.NoOp ->
            ( model, Cmd.none )
        Messages.Msg.SheetRequest ->
            sheetRequest model 
            --( model, Http.send Messages.Msg.SheetResponse (sheetRequest model.config) )

        Messages.Msg.SheetResponse result ->
            case result of
                Err httpError ->
                    let
                        _ =
                            Debug.log "sheetResponseError" httpError
                    in
                        ( model, Cmd.none )

                Ok leagues ->
                    ( { model | leagues = leagues}, Cmd.none )

---- VIEW ----


view : Model -> Html Msg
view model =
    div  
        [ 
            class "leagues"
            , onClick Messages.Msg.SheetRequest
        ] 
        [
            h1 [] [ text "Leagues" ]
            , div [] (List.map leagueTitle model.leagues)
        ]

leagueTitle : League -> Html Msg
leagueTitle league =
    div [ class "league"] [ text league.title ]
