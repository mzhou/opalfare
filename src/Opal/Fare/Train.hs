module Opal.Fare.Train where

import Opal.Distance

import Opal.Fare.Units (Cents)

data TimeOfDay
    = OffPeak
    | Peak
    deriving (Bounded, Eq, Enum, Ord, Read, Show)

fare :: TimeOfDay -> Metres -> Cents
fare OffPeak x
    | x < 10000 = 231
    | x < 20000 = 287
    | x < 35000 = 329
    | x < 65000 = 441
    | True      = 567

fare Peak x
    | x < 10000 = 330
    | x < 20000 = 410
    | x < 35000 = 470
    | x < 65000 = 630
    | True      = 810

singleTrainFare :: TimeOfDay -> Station -> Station -> Cents
singleTrainFare tod orig dest = fare tod $ trackDistance orig dest

-- This assumes you can trasfer to a different station from the one you got off at
-- Not sure if this is possible, the Opal documentation doesns't say clearly either
-- way, but examples given always use the same station
type Trip = (Station, Station)

transferTrainFare :: TimeOfDay -> [Trip] -> Cents
transferTrainFare tod trips = fare tod $ foldr (+) 0 $ map (uncurry trackDistance) trips
