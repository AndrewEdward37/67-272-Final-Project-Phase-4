FactoryBot.define do
 
    factory :employee do
        first_name { "Alex" }
        last_name { "Heimann" }
        ssn { rand(9 ** 9).to_s.rjust(9,'0') }
        date_of_birth { 19.years.ago.to_date }
        phone { rand(10 ** 10).to_s.rjust(10,'0') }
        role { "employee" }
        active { true }
    end
      
    factory :store do
        name {"CMU"}
        street {"5000 Forbes Avenue"}
        city {"Pittsburgh"}
        state {"PA"}
        zip {"15213"}
        phone { rand(10 ** 10).to_s.rjust(10,'0') }
        active {true}
    end
      
    factory :assignment do
        association :store
        association :employee
        start_date {1.year.ago.to_date}
        end_date {1.month.ago.to_date}
        pay_level {1}
    end
  
    factory :shift do
        association :assignment
        date {Date.today}
        start_time {"11:00am".to_time}
        end_time {"2:00pm".to_time}
        notes {"Johnny was a boy on this shift"}
    end
    
    factory :shift_job do
        association :shift
        association :job
    end
  
    factory :job do
        name {"Work cash register"}
        description {"Serving ice cream is a hard task"}
        active {true}
    end
    
    factory :flavor do
        name {"Chocolate"}
        active {true}
    end
    
    factory :store_flavor do
        association :store
        association :flavor
    end
    
    factory :user do
        sequence :email do |n|
      "usermail#{n}@example.com"
    end
    association :employee
    password_digest {"$2a$10$o6xZS3B73OZ8GqRoM6uGPOEzZL0pOh6Yhk3qIMp2Qr2Fap.bshK5S"}
        # password "secret"
        # password_confirmation "secret"
    end
end
