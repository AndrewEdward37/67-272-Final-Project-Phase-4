module Contexts
    module EmployeeContexts
        
      def create_employees
        @ted      = FactoryBot.create(:employee)
        @marshal  = FactoryBot.create(:employee, first_name: "Ted", last_name: "Mosby", ssn: "084-35-9822", date_of_birth: 17.years.ago.to_date)
        @barney   = FactoryBot.create(:employee, first_name: "Marshal", last_name: "Eriksen", active: false, date_of_birth: 16.years.ago.to_date)
        @rachel   = FactoryBot.create(:employee, first_name: "Barney", last_name: "Stinson", role: "manager", phone: "412-268-2323")
        @robin    = FactoryBot.create(:employee, first_name: "Robin", last_name: "Sherbatsky", role: "manager", date_of_birth: 30.years.ago.to_date)
        @alex     = FactoryBot.create(:employee, first_name: "Alex", last_name: "Heimann", role: "admin")
      end
      
      def remove_employees
        @ted.delete
        @marshal.delete
        @barney.delete
        @rachel.delete
        @robin.delete
        @alex.delete
      end
    end
end