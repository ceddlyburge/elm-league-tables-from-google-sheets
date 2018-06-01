port module MainFunctions exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)


---- MODEL ----


type alias Config =
    { googleSheet: String
    }


type alias Model =
    { config: Config
    }


-- SUBSCRIPTIONS


port returnSheet : (String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
    returnSheet ReturnedSheet


---- UPDATE ----


port requestSheet : String -> Cmd msg


type Msg
    = NoOp
    | RequestSheet
    | ReturnedSheet String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        NoOp ->
            ( model, Cmd.none )
        RequestSheet ->
            ( model, requestSheet model.config.googleSheet )
        ReturnedSheet sheet ->
            -- update model with new sheet here once got the basics working
            ( model, Cmd.none )


---- VIEW ----


view : Model -> Html Msg
view model =
    div  
        [ class "leagues" ] 
        [
            h1 [] [ text "Leagues" ]
            , div [ class "league"] [ text "Regional Div 2" ]
        ]

