require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  should belong_to(:assignment)
  should have_many(:shift_jobs)
  should have_many(:jobs).through(:shift_jobs)
  should have_one(:employee).through(:assignment)
  should have_one(:store).through(:assignment)

  should allow_value(Time.now).for(:start_time)  
  should_not allow_value(5.35).for(:start_time)
  should allow_value(1.hour.from_now).for(:start_time)
  should_not allow_value("Mohammed").for(:start_time)
  should_not allow_value(nil).for(:start_time)

  context "Creating a context for shifts" do
    setup do 
      create_stores
      create_employees
      create_assignments
      create_shifts
    end
    
    teardown do
      remove_stores
      remove_employees
      remove_assignments
      remove_shifts
    end

  end
end
