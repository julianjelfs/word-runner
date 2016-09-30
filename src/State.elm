module State exposing (..)

import Color exposing (rgba)
import String
import Types exposing (..)
import Debug exposing (log)
import Time exposing (second)
import Styles exposing (buttonFade, toCapture, toRun, zoom)

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

        MouseOverButton ->
            ( { model | styles = (buttonFade 0.2 model.styles) }, Cmd.none )

        MouseOutButton ->
            ( { model | styles = (buttonFade 0.1 model.styles) }, Cmd.none )

        Reset ->
            ( { model | state = Capturing
               , styles = toCapture model.styles
               }, Cmd.none )

        Start ->
            ( { model | state = Playing }, Cmd.none )

        UpdateWpm str ->
            ( { model | wpm = (Result.withDefault 200 (String.toInt str)) }, Cmd.none )

        Pause ->
            ( { model | state = Paused }, Cmd.none )

        StylesMsg sub ->
            ( { model | styles = Styles.update sub model.styles }, Cmd.none )

        SpeedRead ->
            ( { model | state = Paused
              , words = parseRawText model.rawText
              , styles = toRun model.styles }, Cmd.none )


