module TextCapture exposing (..)

import Html exposing (..)
import Types exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Animation

root: Model -> Html Msg
root model =
   div
       (Animation.render model.captureStyle
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
       , button
            [ onClick SpeedRead
            , disabled (model.rawText == Nothing) ]
            [ text "Speed Read!" ]

       ]
