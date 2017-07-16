module Shared exposing (..)

import Http exposing (Error)
import Html exposing (Html)
import Html.Attributes exposing (src)
import Header
import Form


-- MODEL


type alias Model =
    { error : String
    , formModel : Form.Model
    , registered : Bool
    , signed : Bool
    , showNavigation : Bool
    , nextEvent : Maybe Event
    , sponsors : List SponsorType
    }


initialModel : Model
initialModel =
    { error = ""
    , formModel = Form.initialModel
    , registered = False
    , signed = False
    , showNavigation = True
    , nextEvent = Nothing
    , sponsors = [ GiG ]
    }


type SponsorType
    = GiG
    | Evoke


type alias Sponsor =
    { description : Html Msg
    , id : SponsorType
    , logoSrc : String
    , website : String
    }



-- TODO: just a string for now?


type Event
    = String



-- MESSAGE


type Msg
    = ToggleNavigation Bool
    | FormMsg Form.Msg
    | PostResult (Result Http.Error String)
    | Register


mapMsgToForm : Model -> Html Msg
mapMsgToForm model =
    Html.map FormMsg (Form.view model.formModel)



-- TYPES


type alias Organizer =
    { name : String
    , email : String
    }


type alias Schedule =
    { start : String
    , end : String
    , title : String
    }


type alias ExtendedSchedule =
    { start : String
    , end : String
    , title : String
    , name : String
    , description : String
    , links : List ( String, String )
    }
