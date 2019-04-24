#-------------------------------------------------------------------------------    
#require the needed files
require './test/sets/assignment_contexts'
require './test/sets/employee_contexts'
require './test/sets/flavor_contexts'
require './test/sets/job_contexts'
require './test/sets/shift_contexts'
require './test/sets/shift_job_contexts'
require './test/sets/store_contexts'
require './test/sets/store_flavor_contexts'
require './test/sets/user_contexts'


#-------------------------------------------------------------------------------    
#Include the required contexts
module Contexts
    include Contexts::StoreContexts
    include Contexts::EmployeeContexts
    include Contexts::FlavorContexts
    include Contexts::JobContexts
    include Contexts::ShiftContexts
    include Contexts::ShiftJobContexts
    include Contexts::StoreContexts
    include Contexts::StoreFlavorContexts
    include Contexts::UserContexts
  
    def create_contexts
      
        create_stores
        create_employees
        create_flavors
        create_jobs
        create_shifts
        create_shift_jobs
        create_stores
        create_store_flavors
        create_users
    
    end
  
    def destroy_contexts
        
        destroy_stores
        destroy_employees
        destroy_flavors
        destroy_jobs
        destroy_shifts
        destroy_shift_jobs
        destroy_stores
        destroy_store_flavors
        destroy_users
    end
  

end