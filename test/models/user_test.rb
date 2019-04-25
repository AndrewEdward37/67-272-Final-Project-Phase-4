require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should allow_value("omar@omar.com").for(:email)
  should allow_value("omar@andrew.cmu.edu").for(:email)
  should allow_value("my_omar@omar.org").for(:email)
  should allow_value("omar123@omar.gov").for(:email)
  should allow_value("my.omar@omar.net").for(:email)
  
  should_not allow_value("omar").for(:email)
  should_not allow_value("x@x,com").for(:email)
  should_not allow_value("x@x.uk").for(:email)
  should_not allow_value("omar@omar.con").for(:email)

  should validate_uniqueness_of(:email).case_insensitive

  context "Creating a context for users" do
    setup do 
      create_employees
      create_users
    end
    
    teardown do
      remove_employees
      remove_users
    end

    should "shows that only active employees can have users" do
      # demonstrate an active employee with an associated user
      assert @ted.active
      assert_not_nil @ted_user
      # test a non-existent employee can't be a user
      @x = FactoryBot.build(:employee)
      assert @x.valid?
      @x = FactoryBot.build(:user, employee: @x)
      assert false, @x.valid?
      
      # test an inactive employee can't be a user
      @inactive = FactoryBot.build(:user, employee: @barney)
      deny @inactive.valid?
      
    end

    # test role? method
    should "have working role? method" do 
      assert @ted_user.role?(:employee)
      deny @robin_user.role?(:manager)
      assert @alex_user.role?(:admin)
    end
  end
end
