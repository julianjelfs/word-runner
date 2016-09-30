module TextRunner exposing (..)

import Button
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
                    Button.root Start False "Go!" model.styles.startStyle
                Playing ->
                    Button.root Pause False "Pause" model.styles.pauseStyle
                _ -> div [] []
    in
    div
        [ class "controls" ]
        [ btn
        , Button.root Reset False "Reset" model.styles.resetStyle
        ]

root: Model -> Html Msg
root model =
   div
       (Animation.render model.styles.runnerStyle
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

