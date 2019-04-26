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
    validates_presence_of :assignment_id, :date
    validates_time :start_time
    validates_time :end_time, after: :start_time
    validate :is_it_current
    
    
    
    
#-------------------------------------------------------------------------------    
#Scopes
    scope :completed, -> { joins(:shift_jobs).group(:shift_id) }
    scope :incomplete, -> { joins(:shift_jobs).where('shift_jobs.job_id IS NULL') }
    scope :for_store, -> (store_id) { joins(:assignment, :store).where("assignments.store_id = ?", store_id) }
    scope :for_employee, -> (employee_id) { joins(:assignment, :employee).where("assignments.employee_id = ?", employee_id) }
    scope :past, -> { where('date < ?', Date.current) }
    scope :upcoming, -> { where('date >= ?', Date.current) }
    scope :for_next_days, -> (x) { where('date BETWEEN ? AND ?', Date.today, x.days.from_now.to_date) }
    scope :for_past_days, -> (x) { where('date BETWEEN ? AND ?', x.days.ago.to_date, 1.day.ago.to_date) }
    scope :chronological, -> {order(:date)}
    scope :by_store, -> { joins(:shifts, :stores).order('stores.name') }
    scope :by_employee, -> { joins(:employees, :shifts).order('employees.first_name') }

#-------------------------------------------------------------------------------    
#Methods
    def completed?
        self.shift_jobs.count > 0
    end
    
    def start_now
        self.start_time = Time.current
    end
    
    def end_now
        self.end_time = Time.current
    end
#-------------------------------------------------------------------------------    
#Private methods for any callbacks
    before_create :set_shift_time_if_new
    
    private
    def is_it_current
        unless self.assignment.nil? or self.assignment.end_date.nil?
            errors.add(:assignment_id, "is not a current assignment")
        end
    end
    
    def set_shift_time_if_new
        self.end_time = self.start_time + (3*60*60)
    end
        
end
