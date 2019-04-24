module Contexts
  module StoreContexts
    def create_stores
      @alsadd       = FactoryBot.create(:store, name: "Alsadd", phone: "431235123", active: false)
      @cmuq         = FactoryBot.create(:store, name: "CMUQ")
      @cmu          = FactoryBot.create(:store)
    end
    
    def remove_stores
      @alsadd.delete
      @cmuq.delete
      @cmu.delete
    end
  end
end
