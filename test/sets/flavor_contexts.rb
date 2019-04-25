module Contexts
  module FlavorContexts
    def create_flavors
        @chocolate  = FactoryBot.create(:flavor, name: "Chocolate", active: true)
        @cheesecake  = FactoryBot.create(:flavor, name: "Cheesecake", active: true)
        @strawberry = FactoryBot.create(:flavor, name: "Strawberry", active: true)
        @vanilla    = FactoryBot.create(:flavor, name: "Vanilla", active: false)
      
    end
    
    def remove_flavors
        @chocolate.destroy
        @cheesecake.destroy
        @strawberry.destroy
        @vanilla.destroy
    end
  end
end