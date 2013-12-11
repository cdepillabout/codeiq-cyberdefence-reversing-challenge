
-- code taken from http://themonadreader.files.wordpress.com/2010/01/issue15.pdf

import Control.Monad (MonadPlus, msum, guard, forM_)
import Control.Monad.Logic (Logic, observeAll, observeMany, (>>-))

choices :: MonadPlus m => [a] -> m a
choices = msum . map return

---------------------------------------
-- This apparentely doesn't work...? --
---------------------------------------
--
--numRange :: Logic Int
--numRange = choices [0..10]
--
--allNumbers :: Logic (Int, Int, Int, Int, Int, Int)
--allNumbers =
--        numRange >>- \n1 ->
--        numRange >>- \n2 ->
--        numRange >>- \n3 ->
--        numRange >>- \n4 ->
--        numRange >>- \n5 ->
--        numRange >>- \n6 ->
--        return (n1, n2, n3, n4, n5, n6)
--
--myLogic :: Logic (Int, Int, Int, Int, Int, Int)
--myLogic = do
--        (n1, n2, n3, n4, n5, n6) <- allNumbers
--        guard $ n1 == n3
--        guard $ n2 - 2 == n1
--        guard $ n3 + n4 == 13
--        guard $ n5 /= 0
--        guard $ n3 `div` n5 == 2
--        guard $ n4 - n6 == n3
--        guard $ n6 - 1 == n1
--        return (n1, n2, n3, n4, n5, n6)
--
--main :: IO ()
--main = forM_ (observeAll myLogic) $ \nums -> do
--    print nums
--    putStrLn ""

myLogic :: Logic [Int]
myLogic = do
        [n1, n2, n3, n4, n5, n6] <- choices $ sequence $ replicate 6 [0..10]

        guard $ n1 == n3
        guard $ n2 - 2 == n1
        guard $ n3 + n4 == 13
        guard $ n5 /= 0
        guard $ n3 `div` n5 == 2
        guard $ n4 - n6 == n3
        guard $ n6 - 1 == n1

        return [n1, n2, n3, n4, n5, n6]

main :: IO ()
main = forM_ (observeAll myLogic) $ \nums -> do
    mapM_ (\num -> putStr $ show num ++ " ") nums
    putStrLn ""

