import System.Environment (getArgs)

import Opal.Distance.Stations

import Opal.Fare.Train

main = do
    (tarrif:orig:dest:_) <- getArgs
    putStrLn $ show $ singleTrainFare (read tarrif) (read orig) (read dest)
