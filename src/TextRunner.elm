module TextRunner exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Types exposing (..)


currentWord: String -> Html Msg
currentWord w =
    div
        [ class "current-word" ]
        [ text w ]

remainingWords: List String -> Html Msg
remainingWords words =
    div
        [ class "remaining-words" ]
        (words
            |> (List.take 10)
            |> List.map
                (\w ->
                    span [] [ text w ] ))

controls: Html Msg
controls =
    div
        [ class "controls" ]
        [ button
            [ class "pause" ]
            [ text "Pause" ]
        , button
            [ class "reset"
            , onClick Reset]
            [ text "Reset" ]
        ]

root: Model -> Html Msg
root model =
    case model.words of
        [] -> div [] []
        [x] -> div [] [ text ("final word " ++ x) ]
        x::xs ->
           div
               [ class "runner" ]
               [ currentWord x
               , remainingWords xs
               , controls
               ]

