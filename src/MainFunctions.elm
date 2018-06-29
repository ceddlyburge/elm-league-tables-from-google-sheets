port module MainFunctions exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)
import Json.Decode exposing (Decoder, at, list, string, succeed)
import Http

import Updates.DecodeGoogleSheetToLeagueList exposing (..)
import Models.League exposing (League)

---- MODEL ----


type alias Config =
    { googleSheet: String,
      googleApiKey: String
    }


type alias Model =
    { config: Config,
    leagues: List League
    }

type Msg
    = SheetResponse (Result Http.Error (List League))
    | SheetRequest
    | NoOp

sheetRequest : Config -> Http.Request (List League)
sheetRequest config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeGoogleSheets

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        NoOp ->
            ( model, Cmd.none )
        SheetRequest ->
            ( model, Http.send SheetResponse (sheetRequest model.config) )

        SheetResponse result ->
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
            , onClick SheetRequest
        ] 
        [
            h1 [] [ text "Leagues" ]
            , div [] (List.map leagueTitle model.leagues)
        ]

leagueTitle : League -> Html Msg
leagueTitle league =
    div [ class "league"] [ text league.title ]
