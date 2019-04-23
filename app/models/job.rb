class Job < ApplicationRecord
#-------------------------------------------------------------------------------    
#Callbacks

#-------------------------------------------------------------------------------    
#Relationships
    has_many :shift_jobs
    has_many :shifts, through: :shift_jobs

#-------------------------------------------------------------------------------    
#Validations
    validates_presence_of :name

#-------------------------------------------------------------------------------    
#Scopes
    scope :active, -> {where('active = ?', true)}
    scope :inactive, -> {where('active = ?', false)}
    scope :alphabetical, -> {order(:name)}
    
#-------------------------------------------------------------------------------    
#Methods

#-------------------------------------------------------------------------------    
#Private methods for any callbacks
    before_destroy :destroyable?
    after_rollback :make_inactive
    private
    def destroyable?
        @destroyable = self.shift_jobs.empty?
    end
    
    def make_inactive
        self.update_attribute(:active, false) if !@destroyable.nil? && @destroyable == false
        @destroyable = nil
    end
    
end
