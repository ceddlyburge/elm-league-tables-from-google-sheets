module ViewComponents exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (class)
import Element exposing (..)


backIcon : Element style variation msg
backIcon =
    Html.span [ Html.Attributes.class "fas fa-arrow-alt-circle-left" ] []
        |> Element.html

refreshIcon : Element style variation msg
refreshIcon =
    Html.span [ Html.Attributes.class "fas fa-sync-alt" ] []
        |> Element.html

-- It is nice to wait before showing the loading animation, to avoid Jank
-- style-elements doesn't really support this, so using standard html / css
loading: Element style variation msg
loading =
    Html.div 
        [ Html.Attributes.class "loading" ] 
        [
            Html.div 
                [ Html.Attributes.class "la-ball-newton-cradle la-3x" ] 
                [
                    Html.div [] []
                    , Html.div [] []
                    , Html.div [] []
                    , Html.div [] []
                ]
        ]
    |> Element.html
