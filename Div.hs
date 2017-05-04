{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Div where

import Foundation
import Yesod.Core
import Yesod.Form
import Home


getDivR :: Int -> Int -> Handler TypedContent
getDivR x 0 = selectRep $ do
    provideRep $ defaultLayout $ do
         [whamlet|#{x} cannot be divided by 0|]
getDivR x y = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Division"
        [whamlet|#{x} / #{y} = #{z}|]
    provideJson $ object ["result" .= z]
  where
    z = divfloat x y

divfloat :: Int -> Int -> Double
divfloat x y = (fromIntegral x) / (fromIntegral y)

postDivAdvR :: Handler Html
postDivAdvR = do
     ((divRes,_),_) <- runFormPost renderDiv
     case divRes of
       FormSuccess (Div x y) -> do
          defaultLayout $ do
            [whamlet|
                #{show x} / #{y} = #{z} 
            |]
        where
          z = divfloat x y
       _ -> undefined