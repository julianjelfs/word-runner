module TextRunner exposing (..)

import Html exposing (..)
import Types exposing (..)

root: Model -> Html Msg
root model =
   div
       []
       [ text "text runner"
       ]
