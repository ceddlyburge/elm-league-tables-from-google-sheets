module Updates.RespondGoogleSheetAllTabs exposing (sheetRespond)

import Http

import Messages.Msg exposing ( .. )
import Models.Model exposing ( Model )
import Models.League exposing ( League )

sheetRespond : (Result Http.Error (List League)) -> Model -> ( Model, Cmd Msg )
sheetRespond result model =
    case result of
        Err httpError ->
            let
                _ =
                    Debug.log "sheetResponseError" httpError
            in
                ( model, Cmd.none )

        Ok leagues ->
            ( { model | leagues = leagues}, Cmd.none )
