{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Foundation where

import Yesod.Core
import Yesod.Form

data App = App

-- Tells our application to use the standard English messages.
instance RenderMessage App FormMessage where
    renderMessage _ _ =  defaultFormMessage

mkYesodData "App" $(parseRoutesFile "routes")

instance Yesod App
