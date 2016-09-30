module TextCapture exposing (..)

import Html exposing (..)
import Types exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Animation
import Button

root: Model -> Html Msg
root model =
   div
       (Animation.render model.styles.captureStyle
            ++ [class "capture"])
       [ p
            []
            [ text "Please enter some text in the text box below that you want to speed read" ]
       , div
            []
            [ textarea
                [ rows 20
                , value (Maybe.withDefault "" model.rawText)
                , onInput UpdateRawText ]
                []
            ]
       , Button.root SpeedRead (model.rawText == Nothing) "Speed Read!" model.styles.goStyle
       ]
