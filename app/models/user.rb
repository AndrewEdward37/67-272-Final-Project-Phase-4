class User < ApplicationRecord
#-------------------------------------------------------------------------------    
#Method password hashing
    has_secure_password
    
#-------------------------------------------------------------------------------    
#Callbacks
    before_create :is_active

#-------------------------------------------------------------------------------    
#Relationships
    belongs_to :employee

#-------------------------------------------------------------------------------    
#Validations
    validates_presence_of :employee_id, :email, :password_digest
    #validate :is_active
    
    #found on stackoverflow
    validates_uniqueness_of :email, case_sensitive: false
    validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i

    
#-------------------------------------------------------------------------------    
#Scopes

#-------------------------------------------------------------------------------    
#Methods
    def role?(authorized_role)
        return false if self.employee.nil?
        return false if self.employee.role.nil?
        self.employee.role.downcase.to_sym == authorized_role
    end
    
    def is_active
        @act_employee = self.employee.active 
    end
    

#-------------------------------------------------------------------------------    
#Private methods for any callbacks
    private
    #def active_employee
    #    self.employee.active
    #end
    
    #from lectures
    def self.authenticate(email,password)
        find_by_email(email).try(:authenticate, password)
    end
    
    
end
