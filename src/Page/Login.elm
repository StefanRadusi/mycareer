module Page.Login exposing (Model, Msg, init, update, view)

import Css exposing (height, pct, width)
import Html.Styled exposing (Html, div, input, p, text)
import Html.Styled.Attributes exposing (class, css)
import Html.Styled.Events exposing (onInput)


type alias Model =
    { username : String
    , password : String
    }


type Msg
    = UpdateUsername String


init : Model
init =
    Model "" ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateUsername username ->
            ( { model | username = username }, Cmd.none )


view : Model -> Html Msg
view _ =
    div
        [ css
            [ width (pct 100)
            , height (pct 100)
            ]
        ]
        [ div [ class "form" ]
            [ div []
                [ p [] [ text "Username" ]
                , input [ onInput UpdateUsername ] []
                ]
            ]
        ]
