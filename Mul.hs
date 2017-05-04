{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Mul where

import Foundation
import Yesod.Core
import Yesod.Form
import Home

getMulR :: Int -> Int -> Handler TypedContent
getMulR x y = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "multiplication"
        [whamlet|#{x} * #{y} = #{z}|]
    provideJson $ object ["result" .= z]
  where
    z = x * y

postMulAdvR :: Handler Html
postMulAdvR = do
     ((mulRes,_),_) <- runFormPost renderMul
     case mulRes of
       FormSuccess (Mul x y) -> do
          defaultLayout $ do
            [whamlet|
                #{show x} * #{y} = #{z} 
            |]
        where
          z = x * y
       _ -> undefined