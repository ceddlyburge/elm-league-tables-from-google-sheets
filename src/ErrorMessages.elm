module ErrorMessages exposing (..)

import Http exposing (..)

errorMessage : Http.Error -> String
errorMessage error =
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

