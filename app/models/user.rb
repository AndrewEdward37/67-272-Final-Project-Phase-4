class User < ApplicationRecord
#-------------------------------------------------------------------------------    
#Method password hashing
    has_secure_password
    
#-------------------------------------------------------------------------------    
#Callbacks

#-------------------------------------------------------------------------------    
#Relationships
    belongs_to :employee

#-------------------------------------------------------------------------------    
#Validations
    validates_presence_of :employee_id, :email, :password_digest
    validate :active_employee
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

#-------------------------------------------------------------------------------    
#Private methods for any callbacks
    private
    def active_employee
        is_active_in_system(:employee)
    end
    
    #from lectures
    def self.authenticate(email,password)
        find_by_email(email).try(:authenticate, password)
    end
end
