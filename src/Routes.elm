module Routes exposing (Route(..), parseUrl, pushUrl)

import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)


type Route
    = NotFound
    | Login


parseUrl : Url -> Route
parseUrl url =
    case parse matchRoute url of
        Just route ->
            route

        Nothing ->
            NotFound


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ map Login (s "app-login")
        ]


pushUrl : Route -> Nav.Key -> Cmd msg
pushUrl route navkey =
    routeToString route |> Nav.pushUrl navkey


routeToString : Route -> String
routeToString route =
    case route of
        NotFound ->
            "/not-found"

        Login ->
            "/Login"
