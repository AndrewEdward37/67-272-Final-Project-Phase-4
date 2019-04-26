module Contexts
  module UserContexts
      
    def create_users
        @ted_user = FactoryBot.create(:user, employee: @ted, email: "ted@gmail.com", password: "abc123")
        @robin_user = FactoryBot.create(:user, employee: @robin, email: "robin@gmail.com")
        @alex_user = FactoryBot.create(:user, employee: @alex, email: "alex@gmail.com")
    end
    
    def remove_users
        @ted_user.destroy
        @robin_user.destroy
        @alex_user.destroy
    end

  end
end