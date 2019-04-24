module Contexts
  module FlavorContexts
    def create_flavors
        @chocolate  = FactoryBot.create(:flavor)
        @cheesechake  = FactoryBot.create(:flavor, name: "Cheesecake", active: true)
        @strawberry = FactoryBot.create(:flavor, name: "Strawberry", active: true)
        @vanilla    = FactoryBot.create(:flavor, name: "Vanilla", active: false)
      
    end
    
    def remove_flavors
        @chocolate.destroy
        @vanilla.destroy
        @strawberry.destroy
        @cheesecake.destroy
    end
  end
end