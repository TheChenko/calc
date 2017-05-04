{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Sub where

import Foundation
import Yesod.Core
import Yesod.Form
import Home

getSubR :: Int -> Int -> Handler TypedContent
getSubR x y = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Subtraction"
        [whamlet|#{x} - #{y} = #{z}|]
    provideJson $ object ["result" .= z]
  where
    z = x - y

postSubAdvR :: Handler Html
postSubAdvR = do
     ((subRes,_),_) <- runFormPost renderSub
     case subRes of
       FormSuccess (Sub x y) -> do
          defaultLayout $ do
            [whamlet|
                #{show x} - #{y} = #{z} 
            |]
        where
          z = x - y
       _ -> undefined
         
