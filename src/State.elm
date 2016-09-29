module State exposing (..)

import String
import Types exposing (..)
import Debug exposing (log)
import Animation exposing (px)
import Time exposing (second)

parseRawText : Maybe String -> List String
parseRawText raw =
    case raw of
        Nothing -> []
        Just txt ->
            String.split " " txt

zoom t =
    let
        ang = Animation.turn t
        zero = Animation.turn 0
    in
        Animation.interrupt
            [ Animation.to
                [ Animation.rotate3d zero ang zero ]
            ]

update : Msg -> Model -> (Model,  Cmd Msg)
update msg model =
    case msg of
        None ->
            (model, Cmd.none)

        Tick t ->
            let
                updated =
                    case model.words of
                        [] -> { model | state = Paused, words = parseRawText model.rawText }
                        [x] -> { model | words = [] }
                        x::xs -> { model | words = xs }
            in
                (updated, Cmd.none)

        UpdateRawText txt ->
            ( { model | rawText = if txt == "" then Nothing else Just txt }, Cmd.none )

        Reset ->
            let
                cs =
                    zoom 0 model.captureStyle
                rs =
                    zoom -0.5 model.runnerStyle
            in
                ( { model | words = []
                   , state = Capturing
                   , captureStyle = cs
                   , runnerStyle = rs }, Cmd.none )

        Start ->
            ( { model | state = Playing }, Cmd.none )

        UpdateWpm str ->
            ( { model | wpm = (Result.withDefault 200 (String.toInt str)) }, Cmd.none )

        Pause ->
            ( { model | state = Paused }, Cmd.none )

        SpeedRead ->
            let
                rs =
                    zoom 0 model.runnerStyle
                cs =
                    zoom -0.5 model.captureStyle
            in
            ( { model | state = Paused
              , words = parseRawText model.rawText
              , runnerStyle = rs
              , captureStyle = cs }, Cmd.none )

        Animate sub ->
            ( { model | captureStyle = Animation.update sub model.captureStyle
             , runnerStyle = Animation.update sub model.runnerStyle }, Cmd.none )

