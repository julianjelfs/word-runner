module State exposing (..)

import String
import Types exposing (..)
import Debug exposing (log)

parseRawText : Maybe String -> List String
parseRawText raw =
    case raw of
        Nothing -> []
        Just txt ->
            String.split " " txt

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
            ( { model | words = []
               , state = Capturing }, Cmd.none )

        Start ->
            ( { model | state = Playing }, Cmd.none )

        UpdateWpm str ->
            ( { model | wpm = (Result.withDefault 200 (String.toInt str)) }, Cmd.none )

        Pause ->
            ( { model | state = Paused }, Cmd.none )

        SpeedRead ->
            ( { model | state = Paused
              , words = parseRawText model.rawText }, Cmd.none )

