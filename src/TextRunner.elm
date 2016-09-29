module TextRunner exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Animation

wpm: Model -> Html Msg
wpm model =
    div
        [ class "wpm" ]
        [ span [] [ text "100" ]
        , input
            [ type' "range"
            , Attr.min "100"
            , Attr.max "900"
            , value (toString model.wpm)
            , onInput UpdateWpm ]
            []
        , span [] [text "900"] ]


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

controls: Model -> Html Msg
controls model =
    let
        btn =
            case model.state of
                Paused ->
                    button
                        [ class "go"
                        , onClick Start ]
                        [ text "Go!" ]
                Playing ->
                    button
                        [ class "paused"
                        , onClick Pause ]
                        [ text "Pause" ]
                _ -> div [] []
    in
    div
        [ class "controls" ]
        [ btn
        , button
            [ class "reset"
            , onClick Reset]
            [ text "Reset" ]
        ]

root: Model -> Html Msg
root model =
   div
       (Animation.render model.runnerStyle
            ++ [class "runner"])
            (case model.words of
                [] -> []
                [x] -> [ text ("final word " ++ x) ]
                x::xs ->
                   [ currentWord x
                   , remainingWords xs
                   , controls model
                   , wpm model
                   ])

