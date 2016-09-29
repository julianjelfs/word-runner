module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import Html.Attributes exposing (..)
import TextCapture
import TextRunner

root: Model -> Html Msg
root model =
   div
       [ class "container" ]
       [ h1
           []
           [ text "Word Runner" ]
{-       , div
            []
            [ case model.state of
                Capturing -> TextCapture.root model
                _ -> TextRunner.root model ]-}
       , TextCapture.root model
       , TextRunner.root model
       ]
