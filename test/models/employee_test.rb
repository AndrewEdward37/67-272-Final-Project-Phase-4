require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:assignments)
  should have_many(:stores).through(:assignments)
  
  # Test basic validations
   should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:ssn)
  should validate_presence_of(:role)
  should validate_presence_of(:date_of_birth)
  # tests for phone
 
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  should allow_value(nil).for(:phone)
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("14122683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  # tests for ssn
  should allow_value("123456789").for(:ssn)
  should_not allow_value("12345678").for(:ssn)
  should_not allow_value("bad").for(:ssn)
   # test date_of_birth
  should allow_value(17.years.ago.to_date).for(:date_of_birth)
  should allow_value(15.years.ago.to_date).for(:date_of_birth)
  should_not allow_value("bad").for(:date_of_birth)
  should_not allow_value(nil).for(:date_of_birth)
   # tests for role
  should allow_value("admin").for(:role)
  should allow_value("manager").for(:role)
  should allow_value("employee").for(:role)
  should_not allow_value("hacker").for(:role)
  should_not allow_value("vp").for(:role)

  context "Creating a context for employees" do
    # create the objects I want with factories
    setup do 
      create_employees
    end
    
    # and provide a teardown method as well
    teardown do
      remove_employees
    end
  
    # now run the tests:
    # test employees must have unique ssn
    should "force employees to have unique ssn" do
      repeat_ssn = FactoryBot.build(:employee, first_name: "Andrew", last_name: "Edward", ssn: "084-35-9822")
      #deny repeat_ssn.valid?
      assert_equal false , repeat_ssn.valid? 
    end
    
    # test scope younger_than_18
    should "show there are two employees under 18" do
      assert_equal 2, Employee.younger_than_18.size
      assert_equal ["Eriksen", "Stinson"], Employee.younger_than_18.map{|e| e.last_name}.sort
    end
    
    # test scope younger_than_18
    should "show there are four employees over 18" do
      assert_equal 4, Employee.is_18_or_older.size
      assert_equal ["Green", "Heimann", "Mosby", "Sherbatsky"], Employee.is_18_or_older.map{|e| e.last_name}.sort
    end
    
    # test the scope 'active'
    should "shows that there are five active employees" do
      assert_equal 5, Employee.active.size
      assert_equal ["Eriksen", "Green", "Heimann", "Mosby", "Sherbatsky"], Employee.active.map{|e| e.last_name}.sort
    end
    
    # test the scope 'inactive'
    should "shows that there is one inactive employee" do
      assert_equal 1, Employee.inactive.size
      assert_equal ["Stinson"], Employee.inactive.map{|e| e.last_name}.sort
    end
    
    # test the scope 'regulars'
    should "shows that there are 3 regular employees: Ed, Cindy and Ralph" do
      assert_equal 3, Employee.regulars.size
      assert_equal ["Eriksen", "Mosby", "Stinson"], Employee.regulars.map{|e| e.last_name}.sort
    end
    
    # test the scope 'managers'
    should "shows that there are 2 managers: Ben and Kathryn" do
      assert_equal 2, Employee.managers.size
      assert_equal ["Green", "Sherbatsky"], Employee.managers.map{|e| e.last_name}.sort
    end
    
    # test the scope 'admins'
    should "shows that there is one admin: Alex" do
      assert_equal 1, Employee.admins.size
      assert_equal ["Heimann"], Employee.admins.map{|e| e.last_name}.sort
    end
    
    # test the method 'name'
    should "shows name as last, first name" do
      assert_equal "Heimann, Alex", @alex.name
    end   
    
    # test the method 'proper_name'
    should "shows proper name as first and last name" do
      assert_equal "Alex Heimann", @alex.proper_name
    end 
    
    # test the method 'current_assignment'
    should "shows return employee's current assignment if it exists" do
      create_stores
      create_assignments
      # person with a current assignment
      assert_equal @robin.current_assignment # only 1 assignment ever
      assert_equal @ted, @ben.current_assignment # 2 assignments, returns right one
      # person had assignments but has no current assignment
      assert_nil @ed.current_assignment
      @assign_cindy.update_attribute(:end_date, Date.current)
      @cindy.reload
      assert_nil @cindy.current_assignment
      # person with no assignments ever has no current assignment
      assert_nil @alex.current_assignment
      remove_assignments
      remove_stores
    end
    
    # test the callback is working 'reformat_ssn'
    should "shows that Marshal's ssn is stripped of non-digits" do
      assert_equal "084359822", @marshal.ssn
    end
    
    # test the callback is working 'reformat_phone'
    should "shows that rachel's phone is stripped of non-digits" do
      assert_equal "4122682323", @rachel.phone
    end
    
    # test the method 'over_18?'
    should "shows that over_18? boolean method works" do
      assert @robin.over_18?
    end
    
    # test the method 'age'
    should "shows that age method returns the correct value" do
      assert_equal 19, @ted.age
      assert_equal 17, @marshal.age
      assert_equal 30, @robin.age
    end
  end
end
