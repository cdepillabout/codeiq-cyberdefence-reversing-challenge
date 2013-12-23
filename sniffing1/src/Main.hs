
module Main ( main
            )
            where

import Text.Printf (printf)

import Sniff

doDecode :: String -> IO ()
doDecode string = do
        putStrLn $ "Decoded: " ++ decodeBase64 string

main :: IO ()
main = do
        let stringToParse = "Authorization: Basic YWRtaW46SW1BZG1pbg=="
        case parseBasicAuth stringToParse of
            Left err -> print err
            Right value -> do
                    putStrLn $ "Authorization String: " ++  value
                    doDecode value
