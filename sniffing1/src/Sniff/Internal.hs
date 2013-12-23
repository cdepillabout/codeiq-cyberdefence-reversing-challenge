{-# LANGUAGE FlexibleContexts #-}

module Sniff.Internal
    ( allValidBase64Digits
    , base64Digit
    , isBase64Digit
    , parseBasicAuthHelper
    ) where

import Text.ParserCombinators.Parsec (GenParser)
import Text.Parsec ((<?>), ParsecT, many1, satisfy, string, Stream)

allValidBase64Digits :: [Char]
allValidBase64Digits = ['A'..'Z'] ++ ['a'..'z'] ++ ['0'..'9'] ++ ['+', '/', '=']

isBase64Digit :: Char -> Bool
isBase64Digit digit = digit `elem` allValidBase64Digits

base64Digit :: (Stream s m Char) => ParsecT s u m Char
base64Digit = satisfy isBase64Digit <?> "base 64 digit"

parseBasicAuthHelper :: GenParser Char st String
parseBasicAuthHelper = do
        _ <- string "Authorization"
        _ <- string ": "
        _ <- string "Basic "
        many1 base64Digit
