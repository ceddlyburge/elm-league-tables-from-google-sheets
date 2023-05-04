module Pages.ViewHelpers exposing (dataTestClass)

import Element exposing (Attribute, htmlAttribute)
import Html.Attributes


dataTestClass : String -> Attribute msg
dataTestClass namePostfix =
    "data-test-"
        ++ namePostfix
        |> Html.Attributes.class
        |> htmlAttribute
