module Page.Login exposing (Model, Msg, init, update, view)

import Css
    exposing
        ( active
        , alignItems
        , backgroundColor
        , center
        , displayFlex
        , height
        , int
        , justifyContent
        , marginBottom
        , marginLeft
        , padding
        , paddingRight
        , paddingTop
        , pct
        , position
        , px
        , relative
        , right
        , textAlign
        , transform
        , translateY
        , width
        , zIndex
        )
import Html.Styled
    exposing
        ( Attribute
        , Html
        , button
        , div
        , input
        , p
        , text
        )
import Html.Styled.Attributes exposing (autocomplete, class, css, type_)
import Html.Styled.Events exposing (onInput)
import Reusable.Style
    exposing
        ( blue
        , boxShadow
        , boxShadowSmall
        , defaultBorder
        , mediumFontSize
        , noOutline
        , roundedBorder
        , secondaryText
        , whiteBrackground
        , whiteText
        )


type alias Model =
    { username : String
    , password : String
    }


type Msg
    = UpdateUsername String
    | UpdatePassword String


init : Model
init =
    Model "" ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateUsername username ->
            ( { model | username = username }, Cmd.none )

        UpdatePassword password ->
            ( { model | password = password }, Cmd.none )


view : Model -> Html Msg
view _ =
    div
        [ css
            [ width (pct 100)
            , height (pct 100)
            , displayFlex
            , justifyContent center
            , alignItems center
            ]
        ]
        [ div [ class "form" ]
            [ field "Username" UpdateUsername "text"
            , field "Password" UpdatePassword "password"
            , button [ loginButtonCss ] [ text "Login" ]
            ]
        ]


loginButtonCss : Attribute msg
loginButtonCss =
    css
        [ mediumFontSize
        , width (px 200)
        , textAlign right
        , secondaryText
        , roundedBorder
        , backgroundColor blue
        , height (px 30)
        , whiteText
        , noOutline
        , boxShadow
        , paddingRight (px 20)
        , active [ boxShadowSmall, transform (translateY (px 2)) ]
        ]


field : String -> (String -> Msg) -> String -> Html Msg
field label msg typeInput =
    div []
        [ p [ fieldPCss ] [ text label ]
        , input [ onInput msg, fieldInputCss, type_ typeInput, autocomplete False ] []
        ]


fieldPCss : Attribute msg
fieldPCss =
    css
        [ mediumFontSize
        , marginLeft (px 10)
        , marginBottom (px -10)
        , whiteBrackground
        , zIndex (int 1)
        , position relative
        , width (px 100)
        , textAlign center
        , secondaryText
        , roundedBorder
        ]


fieldInputCss : Attribute msg
fieldInputCss =
    css
        [ defaultBorder
        , width (px 200)
        , padding (px 8)
        , mediumFontSize
        , noOutline
        , marginBottom (px 30)
        , roundedBorder
        , paddingTop (px 18)
        , boxShadow
        ]
