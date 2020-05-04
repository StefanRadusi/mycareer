module Reusable.Style exposing
    ( blue
    , boxShadow
    , boxShadowSmall
    , defaultBorder
    , mediumFontSize
    , noOutline
    , primaryText
    , roundedBorder
    , scondary
    , secondaryText
    , separetorColor
    , whiteBrackground
    , whiteText
    )

import Css
    exposing
        ( Color
        , Style
        , backgroundColor
        , border3
        , borderRadius
        , boxShadow4
        , color
        , fontSize
        , hex
        , outline
        , px
        , rgba
        , solid
        , zero
        )



-- COLORS


primary : Color
primary =
    hex "#565656"


scondary : Color
scondary =
    hex "#8B8B8B"


separetorColor : Color
separetorColor =
    hex "#dcdcdc"


white : Color
white =
    hex "#ffffff"


blue : Color
blue =
    hex "#2B4586"



--
-- TEXT


primaryText : Style
primaryText =
    color primary


secondaryText : Style
secondaryText =
    color scondary


whiteText : Style
whiteText =
    color white



--
--BOXSHADOW


boxShadow : Style
boxShadow =
    boxShadow4 (px 0) (px 4) (px 4) (rgba 0 0 0 0.25)


boxShadowSmall : Style
boxShadowSmall =
    boxShadow4 (px 0) (px 2) (px 2) (rgba 0 0 0 0.25)


mediumFontSize : Style
mediumFontSize =
    fontSize (px 16)


noOutline : Style
noOutline =
    outline zero


defaultBorder : Style
defaultBorder =
    border3 (px 1) solid separetorColor


roundedBorder : Style
roundedBorder =
    borderRadius (px 8)


whiteBrackground : Style
whiteBrackground =
    backgroundColor white
