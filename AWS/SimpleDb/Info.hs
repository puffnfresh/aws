{-# LANGUAGE RecordWildCards #-}
module AWS.SimpleDb.Info
where

import           AWS.Query
import           AWS.Http
import qualified Network.HTTP               as HTTP
import qualified Data.ByteString.Lazy.Char8 as L

data SdbInfo
    = SdbInfo {
        sdbiProtocol :: Protocol
      , sdbiHttpMethod :: HTTP.RequestMethod
      , sdbiHost :: String
      , sdbiPort :: Int
      }
    deriving (Show)
             
sdbUsEast :: String
sdbUsEast = "sdb.amazonaws.com" 

sdbUsWest :: String
sdbUsWest = "sdb.us-west-1.amazonaws.com"

sdbEuWest :: String
sdbEuWest = "sdb.eu-west-1.amazonaws.com"

sdbApSoutheast :: String
sdbApSoutheast = "sdb.ap-southeast-1.amazonaws.com"
             
sdbHttpGet :: String -> SdbInfo
sdbHttpGet endpoint = SdbInfo HTTP HTTP.GET endpoint (defaultPort HTTP)
                          
sdbHttpPost :: String -> SdbInfo
sdbHttpPost endpoint = SdbInfo HTTP HTTP.POST endpoint (defaultPort HTTP)
              
sdbHttpsGet :: String -> SdbInfo
sdbHttpsGet endpoint = SdbInfo HTTPS HTTP.GET endpoint (defaultPort HTTPS)
             
sdbHttpsPost :: String -> SdbInfo
sdbHttpsPost endpoint = SdbInfo HTTPS HTTP.POST endpoint (defaultPort HTTPS)

sdbiBaseQuery :: SdbInfo -> Query
sdbiBaseQuery SdbInfo{..} = Query { 
                              api = SimpleDB
                            , method = sdbiHttpMethod
                            , protocol = sdbiProtocol
                            , host = sdbiHost
                            , port = sdbiPort 
                            , path = "/"
                            , query = [("Version", "2009-04-15")]
                            , date = Nothing
                            , body = L.empty
                            }
