class Flavor < ApplicationRecord
#-------------------------------------------------------------------------------    
#Callbacks
before_destroy :destroyable?
after_rollback :make_inactive

#-------------------------------------------------------------------------------    
#Relationships
  has_many :store_flavors
  has_many :stores, through: :store_flavors
  
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
    
    
    private
    
    def destroyable?
        self.errors.add(:base, "Cannot Delete flavors")
        throw(:abort)
    end
    
    def make_inactive
        self.update_attribute(:active, false)
    end
  
end
