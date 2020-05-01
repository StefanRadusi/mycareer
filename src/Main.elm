module Main exposing (Model, Msg, init, main, subscriptions, update, view)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Html.Styled exposing (div, text, toUnstyled)
import Page.Login as Login
import Routes exposing (Route)
import Url exposing (Url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


type alias Model =
    { route : Route
    , page : Page
    , navKey : Nav.Key
    }


type Page
    = NotFoundPage
    | LoginPage Login.Model


type Msg
    = LoginPageMsg Login.Msg
    | UrlChanged Url.Url
    | LinkClicked UrlRequest


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    let
        model =
            { route = Routes.parseUrl url
            , page = NotFoundPage
            , navKey = navKey
            }
    in
    initCurrentPage ( model, Cmd.none )


initCurrentPage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
initCurrentPage ( model, existingCmds ) =
    let
        ( currentPage, mappedPageCmds ) =
            case model.route of
                Routes.NotFound ->
                    ( NotFoundPage, Cmd.none )

                Routes.Login ->
                    ( LoginPage Login.init, Cmd.none )
    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( LoginPageMsg subMsg, LoginPage pageModel ) ->
            let
                ( updatedPageModel, updatedCmd ) =
                    Login.update subMsg pageModel
            in
            ( { model | page = LoginPage updatedPageModel }
            , Cmd.map LoginPageMsg updatedCmd
            )

        ( LinkClicked urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )

        ( UrlChanged url, _ ) ->
            let
                newRoute =
                    Routes.parseUrl url
            in
            ( { model | route = newRoute }, Cmd.none )
                |> initCurrentPage

        ( _, _ ) ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Document Msg
view { page } =
    { title = "My Career"
    , body =
        [ bodyView page |> toUnstyled ]
    }


bodyView : Page -> Html.Styled.Html Msg
bodyView page =
    case page of
        NotFoundPage ->
            div [] [ text "page not found" ]

        LoginPage model ->
            Login.view model |> Html.Styled.map LoginPageMsg
