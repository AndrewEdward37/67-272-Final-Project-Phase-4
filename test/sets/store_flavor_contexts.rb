module Contexts
  module StoreFlavorContexts
    def create_store_flavors
        @chocolate_cmu    = FactoryBot.create(:store_flavor, flavor: @chocolate, store: @cmu)
        @chocolate_cmuq   = FactoryBot.create(:store_flavor, flavor: @chocolate, store: @cmuq)
        @strawberry_cmu   = FactoryBot.create(:store_flavor, flavor: @strawberry, store: @cmu)
        @cheesecake_cmuq  = FactoryBot.create(:store_flavor, flavor: @cheesecake, store: @cmuq)
    end
    
    def remove_store_flavors
        @chocolate_cmu.destroy
        @chocolate_cmuq.destroy
        @strawberry_cmu.destroy
        @cheesecake_cmuq.destroy
    end
  end
end