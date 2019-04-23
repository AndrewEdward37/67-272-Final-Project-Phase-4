class Shift < ApplicationRecord
#-------------------------------------------------------------------------------    
#Callbacks

#-------------------------------------------------------------------------------    
#Relationships
    has_many :shift_jobs
    has_many :jobs, through: :shift_jobs
    belongs_to :assignment
    has_one :employee, through: :assignment
    has_one :store, through: :assignment
    
#-------------------------------------------------------------------------------    
#Validations
    validates_presence_of :assignment_id, :date, :start_date
    validate :is_it_current
    
    
    
    
#-------------------------------------------------------------------------------    
#Scopes


#-------------------------------------------------------------------------------    
#Private methods for any callbacks
    private
    def is_it_current
        unless self.assignment.nil? or self.assignment.end_date.nil?
            errors.add(:assignment_id, "is not a current assignment")
        end
    end
end
