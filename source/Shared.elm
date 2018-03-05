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
    , nextEvent =
        Just
            { title = "A-Frame - Building virtual reality experiences in the browser"
            , description =
                """
              A-Frame is a framework for developing 3D and virtual reality applications. It builds on top of the native functionality provided by web components to enable developers to create virtual worlds using markup. In this presentation we'll get hands-on with it and explain concepts like scene graphs as well as the entity component mechanism that comes bundled with the framework.
              """
            , speaker = "Yannis Gravezas"
            , speakerPicture = "yannis_gravezas.jpg"
            , speakerDescription =
                """
        Yannis has been working in visual programming for over a decade in sectors ranging from 3d printing and medical rehabilitation to digital agencies and, lately,  iGaming. Being passionate about creative coding, he contributes frequently to major open source projects like A-Frame and Three.js. Currently working at Play'N'GO, he makes sure that the company's games look and perform great.
        """
            , links =
                [ ( "linkedin", "https://www.linkedin.com/in/wizgrav/" )
                , ( "github", "https://github.com/wizgrav" )
                ]
            }
    , sponsors = [ Knipster ]
    }


type SponsorType
    = GiG
    | Evoke
    | Knipster


type alias Sponsor =
    { description : Html Msg
    , id : SponsorType
    , logoSrc : String
    , website : String
    }



-- TODO: just a string for now?


type alias Event =
    { title : String
    , description : String
    , speaker : String
    , speakerDescription : String
    , speakerPicture : String
    , links : List ( String, String )
    }



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
    , event : Event
    }
