module Pages.ViewHelpers exposing ( 
    dataTestClass
    )

import Element exposing (..)
import Html.Attributes exposing (..)

dataTestClass namePostfix =
    "data-test-" ++ namePostfix
    |> Html.Attributes.class 
    |> htmlAttribute