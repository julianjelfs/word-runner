module Types exposing (..)

import Animation exposing (px)
import Time exposing (millisecond)
import Color exposing (rgba)
import Styles

type alias Model =
    { rawText : Maybe String
    , state: State
    , words: List String
    , wpm: Int
    , styles: Styles.Model
    }

type State =
    Capturing
    | Paused
    | Playing
    | Finished

type Msg =
    None
    | UpdateRawText String
    | SpeedRead
    | Start
    | Pause
    | Reset
    | Tick Float
    | UpdateWpm String
    | StylesMsg Styles.Msg
    | MouseOverButton Animation.State (Animation.State -> Styles.Model)
    | MouseOutButton Animation.State (Animation.State -> Styles.Model)

initialModel : Model
initialModel =
    Model (Just sampleTxt) Capturing [] 200 Styles.initialModel

sampleTxt =
    "Hi, I’m Evan Czaplicki. Depending on where you’re from, you might say it different. I designed this programming language called Elm that’s focused on front-end programming, so doing stuff in the browser, interactive applications, games, this kind of thing. I’m coming from a perspective of typed functional programming, and one thing that I think of a lot is this question, if typed functional programming is so great, how come nobody ever uses it?\n\nI think this is a question that people outside of this community ask, and I think it’s a reasonable question for them, just as a filter. Obscure things aren’t always amazing. It’s something that I don’t think we ask within that community enough. Why is it that we don’t have more users if it is true that we’re doing something really great? The rough theory is that we’re engaged in a decent amount of self-destructive behavior.\n\nI want to talk about how Elm… how I think about these things and how Elm tries to do a better job dealing with those things. I also don’t want to be a mean guy, so I tried to frame things in a positive way and not be too mean or anything. This is all meant as a \"How can we do better?\" kind of thing."
