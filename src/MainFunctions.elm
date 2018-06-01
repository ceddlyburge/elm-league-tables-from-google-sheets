module MainFunctions exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)


---- MODEL ----


type alias Config =
    { googleSheet: String
    }


type alias Model =
    { config: Config
    }


---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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

