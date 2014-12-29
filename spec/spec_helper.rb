require './lib/letsfreckle/client'
require 'pry'

def setup_connection
  Letsfreckle::Client.configure do
    token 'scbp72wdc528hm8n52fowkma321tn58-jc1l2dkil0pnb75xjni48ad2wwsgr1d'
    name 'letsfreckle-client'
  end
end
