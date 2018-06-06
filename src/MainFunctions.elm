port module MainFunctions exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)
import Json.Decode exposing (Decoder, at, list, string, succeed)
import Http

---- MODEL ----


type alias Config =
    { googleSheet: String
    }


type alias Model =
    { config: Config,
    leagueTitle: String
    }


type Msg
    = SheetResponse (Result Http.Error String)
    | SheetRequest
    | NoOp

sheetRequest : Http.Request String
sheetRequest =
    Http.get "https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE?key=AIzaSyBZyrlDqCe1YooJq8oZ8q1u3-Jp1uL-OEc" decodeSheetResponse

decodeSheetResponse : Decoder String
decodeSheetResponse =
    at [ "properties", "title" ] string

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        NoOp ->
            ( model, Cmd.none )
        SheetRequest ->
            ( model, Http.send SheetResponse sheetRequest )

        SheetResponse result ->
            case result of
                Err httpError ->
                    let
                        _ =
                            Debug.log "sheetResponseError" httpError
                    in
                        ( model, Cmd.none )

                Ok leagueTitle ->
                    ( { model | leagueTitle = leagueTitle }, Cmd.none )

---- VIEW ----


view : Model -> Html Msg
view model =
    div  
        [ class "leagues" ] 
        [
            h1 [] [ text "Leagues" ]
            , div [ class "league"] [ text model.leagueTitle ]
        ]

