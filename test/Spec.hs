{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Map.Strict as M
import           Lib (encodeDataset, encodeRow)
import           Test.Hspec
import           Test.Tasty
import           Test.Tasty.Hspec

spec :: Spec
spec = do
  describe "encodeDataset" $
    it "encodes entire dataset" $ do

      let inputDataset    = [ ["left"  , "2.7", "84321"   , "low"    ]
                            , ["right" , "7.7", "47238"   , "low"    ]
                            , ["middle", "9.4", "7526237" , "medium" ]
                            , ["middle", "2.3", "823732"  , "medium" ]
                            , ["left"  , "9.3", "71262634", "high"   ]
                            , ["right" , "6.2", "48342901", "high"   ]
                            ]

          encodings       = M.fromList [ (0, ["left", "middle", "right"])
                                       , (3, ["low" , "medium", "high" ])
                                       ]

          expectedDataset = [ ["1", "0", "0", "2.7", "84321"   , "1", "0", "0" ]
                            , ["0", "0", "1", "7.7", "47238"   , "1", "0", "0" ]
                            , ["0", "1", "0", "9.4", "7526237" , "0", "1", "0" ]
                            , ["0", "1", "0", "2.3", "823732"  , "0", "1", "0" ]
                            , ["1", "0", "0", "9.3", "71262634", "0", "0", "1" ]
                            , ["0", "0", "1", "6.2", "48342901", "0", "0", "1" ]
                            ]


      encodeDataset inputDataset encodings `shouldBe` expectedDataset


  describe "encodeRow" $ do
    it "replaces indexed element in row with list of strings SIMPLE" $ do
      let inputRow = ["left"]
          encodings = M.fromList [(0, ["left", "right", "middle"])]
          expectedRow = ["1", "0", "0"]

      encodeRow encodings inputRow `shouldBe` expectedRow
      
    it "replaces indexed element in row with list of strings Complete" $ do
      let inputRow = ["left", "100", "middle", "100", "200"]

          encodings = M.fromList [ (0, ["left", "middle", "right"])
                                 , (2, ["left", "middle", "right"])
                                 ]

          expectedRow = ["1", "0", "0", "100", "0", "1", "0", "100", "200"]

      encodeRow encodings inputRow `shouldBe` expectedRow

encodingSpec :: IO TestTree
encodingSpec = testSpec "Encoding Spec" spec

main :: IO ()
main = do
  encodingTests <- encodingSpec
  let tests = testGroup "Tests" [ encodingTests ]
  defaultMain tests
