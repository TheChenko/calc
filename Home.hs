{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Home where

import Foundation
import Yesod.Core
import Yesod.Form
import Control.Applicative ((<$>),(<*>))

--create data type for addition form
data Add = Add {
int1 :: Int
,int2 :: Int
}
--create data type for substraction form
data Sub = Sub {
int3 :: Int
,int4 :: Int
}
--create data type for multiplication form
data Mul = Mul {
int5 :: Int
,int6 :: Int
}
--create data type for division form
data Div = Div {
int7 :: Int
,int8 :: Int
}
  deriving Show

--it handles the form 
addAForm :: AForm Handler Add
addAForm = Add
--those are fields for user inputs
  <$> areq intField "First Integer" Nothing
  <*> areq intField "Second Integer" Nothing
--it handles the form 
addBForm :: AForm Handler Sub
addBForm = Sub
--those are fields for user inputs
  <$> areq intField "First Integer" Nothing
  <*> areq intField "Second Integer" Nothing
--it handles the form 
addCForm :: AForm Handler Mul
addCForm = Mul
--those are fields for user inputs
  <$> areq intField "First Integer" Nothing
  <*> areq intField "Second Integer" Nothing
--it handles the form 
addDForm :: AForm Handler Div
addDForm = Div
--those are fields for user inputs
  <$> areq intField "First Integer" Nothing
  <*> areq intField "Second Integer" Nothing

-- those are renders for the forms on the page, each renders its own form
renderAdd :: Html -> MForm Handler (FormResult Add, Widget)
renderAdd = renderTable addAForm

renderSub :: Html -> MForm Handler (FormResult Sub, Widget)
renderSub = renderTable addBForm

renderMul :: Html -> MForm Handler (FormResult Mul, Widget)
renderMul = renderTable addCForm

renderDiv :: Html -> MForm Handler (FormResult Div, Widget)
renderDiv = renderTable addDForm

getHomeR :: Handler Html
getHomeR = do
    --These instead of binding to existing parameters, acts as if there are none. 
    (afInt, asInt) <- generateFormPost renderAdd
    (sfInt, ssInt) <- generateFormPost renderSub
    (mfInt, msInt) <- generateFormPost renderMul
    (dfInt, dsInt) <- generateFormPost renderDiv

    defaultLayout $ do
    setTitle "Calculator"
    [whamlet|
        <p>
            <a href=@{AddR 5 7}>HTML addition
        <p>
            <a href=@{AddR 5 7}?_accept=application/json>JSON addition
        <p>
        <h3> Add form
        
        <form method=post action=@{AddAdvR} enctype=#{asInt}>
            ^{afInt}
            <button>Submit
        <p>
            <a href=@{SubR 7 5}>HTML substraction
        <p>
            <a href=@{SubR 7 5}?_accept=application/json>JSON substraction
        <p>
        <h3> Sub Form
        
        <form method=post action=@{SubAdvR} enctype=#{ssInt}>
            ^{sfInt}
            <button>Submit
        <p>
            <a href=@{MulR 7 9}>HTML multiplication
        <p>
            <a href=@{MulR 7 9}?_accept=application/json>JSON multiplication
        <p>
        <h3> Mul Form
        
        <form method=post action=@{MulAdvR} enctype=#{msInt}>
            ^{mfInt}
            <button>Submit
        <p>
            <a href=@{DivR 21 3}> HTML Division
        <p>
            <a href=@{DivR 21 3}?_accept=application/json> Json Division

        <h3> Div Form
        
        <form method=post action=@{DivAdvR} enctype=#{dsInt}>
            ^{dfInt}
            <button>Submit
        <p>

    |]
