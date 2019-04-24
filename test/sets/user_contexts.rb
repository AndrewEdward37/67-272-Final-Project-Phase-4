module Contexts
  module UserContexts
      
    def create_users
        @ted_user = FactoryBot.create(:user, employee: @ted, email: "ted@gmail.com")
        @robin_user = FactoryBot.create(:user, employee: @robin, email: "robin@gmail.com")
        @alex_user = FactoryBot.create(:user, employee: @alex, email: "alex@gmail.com")
    end
    
    def remove_users
        @ted_user.delete
        @robin_user.delete
        @alex_user.delete
    end

  end
end