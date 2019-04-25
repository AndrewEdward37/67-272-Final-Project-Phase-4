require 'test_helper'

class JobTest < ActiveSupport::TestCase

  should have_many(:shift_jobs)
  should have_many(:shifts).through(:shift_jobs)

  should validate_presence_of(:name)

  context "Creating a context for jobs" do
    setup do 
      create_jobs
    end
    
    teardown do
      remove_jobs
    end
    
    should "show jobs in alphabetical order" do
      assert_equal ["Delivery guy", "Ice cream making", "Mover", "Work cash register"], Job.alphabetical.map{|j| j.name}
    end
    
    should "shows the active jobs" do
      assert_equal 3, Job.active.size
      assert_equal ["Delivery guy", "Ice cream making", "Work cash register"], Job.active.map{|j| j.name}.sort
    end
    
    should "shows that there is one inactive job" do
      assert_equal 1, Job.inactive.size
      assert_equal ["Mover"], Job.inactive.map{|j| j.name}.sort
    end
    
    should "correctly assess that jobs are not destroyable" do
      @cashier.destroy
      assert_equal ["Delivery guy", "Ice cream making", "Mover", "Work cash register"], Job.alphabetical.map{|f| f.name}
    end
    
    should "make an undestroyed job inactive" do
      @cashier.destroy
      @cashier.reload
      assert_equal true, @cashier.active
    end
  end
end
