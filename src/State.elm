module State exposing (..)

import String
import Types exposing (..)
import Debug exposing (log)
import Animation exposing (px)

parseRawText : Maybe String -> List String
parseRawText raw =
    case raw of
        Nothing -> []
        Just txt ->
            String.split " " txt

zoom l o =
    Animation.interrupt
        [ Animation.to
            [ Animation.left (px l)
            , Animation.opacity o ]
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
                    zoom 0.0 1.0 model.captureStyle
                rs =
                    zoom -1000.0 0.0 model.runnerStyle
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
                    zoom 0.0 1.0 model.runnerStyle
                cs =
                    zoom -1000.0 0.0 model.captureStyle
            in
            ( { model | state = Paused
              , words = parseRawText model.rawText
              , runnerStyle = rs
              , captureStyle = cs }, Cmd.none )

        Animate sub ->
            ( { model | captureStyle = Animation.update sub model.captureStyle
             , runnerStyle = Animation.update sub model.runnerStyle }, Cmd.none )

