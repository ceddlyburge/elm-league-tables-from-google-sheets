port module MainFunctions exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)
import Json.Decode exposing (Decoder, at, list, string, succeed)
import Http

---- MODEL ----


type alias Config =
    { googleSheet: String,
      googleApiKey: String
    }


type alias Model =
    { config: Config,
    leagues: List GoogleSheet
    }

type alias GoogleSheet =
    { title: String
    }

type Msg
    = SheetResponse (Result Http.Error (List GoogleSheet))
    | SheetRequest
    | NoOp

sheetRequest : Config -> Http.Request (List GoogleSheet)
sheetRequest config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeGoogleSheets

googleSheetDecoder : Decoder GoogleSheet
googleSheetDecoder =
    Json.Decode.map GoogleSheet (at [ "properties", "title" ] string)

decodeGoogleSheets : Decoder (List GoogleSheet)
decodeGoogleSheets =
    Json.Decode.field "sheets" (list googleSheetDecoder)

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

                Ok googleSheets ->
                    ( { model | leagues = googleSheets}, Cmd.none )

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

leagueTitle : GoogleSheet -> Html Msg
leagueTitle googleSheet =
    div [ class "league"] [ text googleSheet.title ]
