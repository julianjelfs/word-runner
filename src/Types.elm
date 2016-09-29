module Types exposing (..)

import Animation exposing (px)
import Time exposing (millisecond)

type alias Model =
    { rawText : Maybe String
    , state: State
    , words: List String
    , wpm: Int
    , captureStyle: Animation.State
    , runnerStyle: Animation.State
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
    | Animate Animation.Msg

spring =
    Animation.spring
        { stiffness = 250
        , damping = 10 }

easing =
    Animation.easing
        { duration = 250 * millisecond
        , ease = (\x -> x^2) }

flat = Animation.turn 0.0
back = Animation.turn -0.5

initialModel : Model
initialModel =
    Model (Just sampleTxt) Capturing [] 200
        (Animation.styleWith
            easing
            [ Animation.rotate3d flat flat flat ])
        (Animation.styleWith
            easing
            [ Animation.rotate3d flat back flat ])

sampleTxt =
    "Where does it come from?\n\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.\n\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
