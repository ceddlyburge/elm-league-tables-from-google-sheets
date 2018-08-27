module ErrorMessages exposing (..)

import Http exposing (..)

unexpectedNotAskedMessage : String
unexpectedNotAskedMessage =
  "Hmmm, There is a bug in my code. You could report a bug at https://github.com/ceddlyburge/elm-league-tables-from-google-sheets/issues/new, or maybe try going back to the homepage and starting again"  

httpErrorMessage : Http.Error -> String
httpErrorMessage error =
  case error of
    Http.Timeout ->
      "Timeout, maybe your WiFi is disabled or there is no connection to the internet."
    Http.NetworkError  ->
      "Network error, maybe your WiFi is disabled or there is no connection to the internet."
    Http.BadPayload _ _ ->
      "Unexpected Payload. Hmmm, there is probably a problem in my configuration, please contact the League Administrator"
    Http.BadStatus _ ->
      "Bad Response. Hmmm, there is probably a problem in my configuration, please contact the League Administrator"
    Http.BadUrl _ ->
      "Bad Url. Hmmm, there is probably a problem in my configuration, please contact the League Administrator"

