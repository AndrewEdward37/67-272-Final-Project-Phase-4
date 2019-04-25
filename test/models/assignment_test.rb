require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  # Test relationships
   should belong_to(:employee)
   should belong_to(:store)
   should have_many(:shifts)

#-------------------------------------------------------------------------------    
#Basic methods, no need for contexts to test
  should allow_value(1).for(:pay_level)
  should allow_value(2).for(:pay_level)
  should allow_value(3).for(:pay_level)
  should allow_value(4).for(:pay_level)
  should allow_value(5).for(:pay_level)
  should allow_value(6).for(:pay_level)
  should_not allow_value("bad").for(:pay_level)
  should_not allow_value(0).for(:pay_level)
  should_not allow_value(7).for(:pay_level)
  should_not allow_value(2.5).for(:pay_level)
  should_not allow_value(-2).for(:pay_level)
  # # for start date
  should allow_value(7.weeks.ago.to_date).for(:start_date)
  should allow_value(2.years.ago.to_date).for(:start_date)
  should_not allow_value(1.week.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(nil).for(:start_date)

#-------------------------------------------------------------------------------    
#Need context to test

  context "Creating a context for assignments" do
    setup do
      create_stores
      create_employees
      create_assignments
    end

    teardown do
      remove_stores
      remove_employees
      remove_assignments
    end

    should "have a scope 'for_store' that works" do
      assert_equal 2, Assignment.for_store(@cmu.id).size
      assert_equal 2, Assignment.for_store(@cmuq.id).size
    end
  
    should "have a scope 'for_employee' that works" do
      assert_equal 1, Assignment.for_employee(@ted.id).size
      assert_equal 1, Assignment.for_employee(@marshal.id).size
    end

    should "have a scope 'for_pay_level' that works" do
      assert_equal 2, Assignment.for_pay_level(1).size
      assert_equal 0, Assignment.for_pay_level(2).size
    end

    should "have a scope 'for_role' that works" do
      assert_equal 2, Assignment.for_role("employee").size
      assert_equal 2, Assignment.for_role("manager").size
    end

    should "have all the assignments listed alphabetically by store name" do
      assert_equal ["CMU", "CMU", "CMUQ", "CMUQ"], Assignment.by_store.map{|a| a.store.name}
    end

    should "have all the assignments listed chronologically by start date" do
      assert_equal ["Robin", "Ted", "Rachel", "Marshal"], Assignment.chronological.map{|a| a.employee.first_name}
    end

    should "have all the assignments listed alphabetically by employee name" do
      assert_equal ["Eriksen", "Green", "Mosby", "Sherbatsky"], Assignment.by_employee.map{|a| a.employee.last_name}
     end

    should "have a scope to find all current assignments for a store or employee" do
      assert_equal 0, Assignment.current.for_store(@cmu.id).size
      assert_equal 2, Assignment.current.for_store(@cmuq.id).size
      assert_equal 0, Assignment.current.for_employee(@ted.id).size
      assert_equal 0, Assignment.current.for_employee(@marshal.id).size
    end

    should "have a scope to find all past assignments for a store or employee" do
      assert_equal 2, Assignment.past.for_store(@cmu.id).size
      assert_equal 0, Assignment.past.for_store(@cmuq.id).size
      assert_equal 1, Assignment.past.for_employee(@ted.id).size
      assert_equal 0, Assignment.past.for_employee(@robin.id).size
    end

    should "allow for a end date in the past (or today) but after the start date" do
      @assign_alex = FactoryBot.build(:assignment, employee: @alex, store: @cmuq, start_date: 3.months.ago.to_date, end_date: 1.month.ago.to_date)
      assert @assign_alex.valid?
      @second_assignment_for_alex = FactoryBot.build(:assignment, employee: @alex, store: @cmuq, start_date: 3.weeks.ago.to_date, end_date: Date.current)
      assert @second_assignment_for_alex.valid?
    end

    should "not allow for a end date in the future or before the start date" do
      # since Ed finished his last assignment a month ago, let's try to assign the lovable loser again ...
      @second_assignment_for_ted = FactoryBot.build(:assignment, employee: @ted, store: @cmu, start_date: 2.weeks.ago.to_date, end_date: 3.weeks.ago.to_date)
      assert_not_equal true, @second_assignment_for_ted.valid?
      @third_assignment_for_ted = FactoryBot.build(:assignment, employee: @ted, store: @cmu, start_date: 2.weeks.ago.to_date, end_date: 3.weeks.from_now.to_date)
      assert_equal false, @third_assignment_for_ted.valid?
    end

    should "identify a non-active store as part of an invalid assignment" do
      inactive_store = FactoryBot.build(:assignment, store: @alsadd, employee: @ted, start_date: 1.day.ago.to_date, end_date: nil)
      assert_equal false,inactive_store.valid?
    end

    should "identify a non-active employee as part of an invalid assignment" do
       @bob = FactoryBot.build(:employee, first_name: "Bob", active: false)
       inactive_employee = FactoryBot.build(:assignment, store: @cmuq, employee: @bob, start_date: 1.day.ago.to_date, end_date: nil)
       assert_equal false, inactive_employee.valid?
    end

    should "end the current assignment if it exists before adding a new assignment for an employee" do
      @promote_ted = FactoryBot.create(:assignment, employee: @ted, store: @cmu, start_date: 1.day.ago.to_date, end_date: nil, pay_level: 4)
      assert_equal 1.month.ago.to_date, @ted.assignments.first.end_date
      @promote_ted.destroy
    end
    
    #should "allow an assignment with no past shifts to be destroyed" do 
    #  create_shifts_upcoming
    #  assert @marshal_robin.shifts.past.empty?
    #  assert @marshal_robin.destroy
    #  remove_shifts_upcoming
    #end

    # should "allow a destroyable assignment has upcoming shifts removed" do 
    #   create_shifts_upcoming
    #   deny Shift.for_employee(@marshal.id).empty?
    #   assert @marshal_assignment.destroy
    #   assert Shift.for_employee(@marshal.id).empty?
    #   remove_shifts_upcoming
       
    # end

    # should "not allow an assignment with past shifts to be destroyed" do 
    #   create_past_shifts
    #   deny @assign_ed_2.shifts.past.empty?
    #   deny @assign_ed_2.destroy
    #   remove_past_shifts
    # end

    # should "remove upcoming shifts from an assignment that was attempted to be destroyed" do 
    #   create_shifts
    #   deny Shift.for_employee(@kathryn.id).upcoming.empty?
    #   deny @assign_kathryn.destroy
    #   assert Shift.for_employee(@kathryn.id).upcoming.empty?
    #   remove_shifts  
    # end

    # should "remove upcoming shifts from an assignment that was ended" do 
    #   create_shifts
    #   deny @assign_kathryn.shifts.upcoming.empty?
    #   @assign_kathryn.end_date = Date.current
    #   @assign_kathryn.save
    #   @assign_kathryn.reload
    #   assert @assign_kathryn.shifts.upcoming.empty?
    #   remove_shifts
    # end
  end
end
