module Sniff
    ( bin2dec
    , decodeBase64
    , dec2bin
    , doRealDecode
    , getBase64Values
    , parseBasicAuth
    ) where

import Data.Char (ord, chr)
import Data.List (elemIndex)
import Data.Maybe (fromJust)
import Text.ParserCombinators.Parsec (parse, ParseError)
import Text.Printf (printf)

import Sniff.Internal

parseBasicAuth :: [Char] -> Either ParseError String
parseBasicAuth stringToParse = parse parseBasicAuthHelper "no file name" stringToParse

allBase64Digits :: [Char]
allBase64Digits = ['A'..'Z'] ++ ['a'..'z'] ++ ['0'..'9'] ++ ['+', '/']

base64IndexOf :: Char -> Maybe Int
base64IndexOf char = elemIndex char allBase64Digits

getBase64Values :: String -> [Int]
getBase64Values string = map (fromJust . base64IndexOf) $ takeWhile (not . (== '=')) string

bin2dec :: String -> Int
bin2dec = foldr (\c s -> s * 2 + c) 0 . reverse . map c2i
    where c2i c = if c == '0' then 0 else 1

dec2bin :: Int -> String
dec2bin 0 = "0"
dec2bin 1 = "1"
dec2bin num = dec2bin (num `div` 2) ++ show (num `mod` 2)

decode3Bytes :: [Char] -> [Char]
decode3Bytes bits = let firstByte = chr $ bin2dec $ getCharsFrom 0 8 bits
                        secondByte = chr $ bin2dec $ getCharsFrom 8 16 bits
                        thirdByte = chr $ bin2dec $ getCharsFrom 16 24 bits
                    in firstByte : secondByte : thirdByte : []
  where
        getCharsFrom n m string = drop n . take m $ string

decodeBitSet :: [Char] -> [Char]
decodeBitSet bits =
        if length bits < 24
            then decodeBitSet (bits ++ ['0'])
            else decode3Bytes bits

doRealDecode :: [Char] -> [Char]
doRealDecode [] = []
doRealDecode string =
        let bits = take 24 string
        in decodeBitSet bits ++ doRealDecode (drop 24 string)

decodeBase64 :: String -> String
decodeBase64 string =
        let values = getBase64Values string
            binValues = map dec2bin values
            fullBinValues = (map (printf "%06s") binValues) :: [String]
            fullValue = concat fullBinValues
            decodedChars = doRealDecode fullValue
        in decodedChars
