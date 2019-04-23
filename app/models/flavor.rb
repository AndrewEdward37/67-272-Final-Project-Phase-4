class Flavor < ApplicationRecord
#-------------------------------------------------------------------------------    
#Callbacks

#-------------------------------------------------------------------------------    
#Relationships
  has_many :store_flavors
  has_many :stores, through: :store_flavors
  
#-------------------------------------------------------------------------------    
#Validations
  validates_presence_of :name
  
#-------------------------------------------------------------------------------    
#Scopes


#-------------------------------------------------------------------------------    
#Privat methods for any callbacks
  
end
