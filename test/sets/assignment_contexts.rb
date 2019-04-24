module Contexts
  module AssignmentContexts

    def create_assignments
      @ted_assignment      = FactoryBot.create(:assignment, employee: @ted, store: @cmu)
      @marshal_assignment  = FactoryBot.create(:assignment, employee: @marshal, store: @cmu, start_date: 2.years.ago.to_date, end_date: 6.months.ago.to_date, pay_level: 3)
      @barney_assignment   = FactoryBot.create(:assignment, employee: @barney, store: @cmu, start_date: 6.months.ago.to_date, end_date: nil, pay_level: 4)
      @rachel_assignment   = FactoryBot.create(:assignment, employee: @rachel, store: @cmuq, start_date: 14.months.ago.to_date, end_date: nil)
      @robin_assignment     = FactoryBot.create(:assignment, employee: @robin, store: @cmuq, start_date: 10.months.ago.to_date, end_date: nil, pay_level: 3)
    end
    
    def remove_assignments
      @ted_assignment.delete
      @marshal_assignment.delete
      @barney_assignment.delete
      @rachel_assignment.delete
      @robin_assignment.delete
    end
  end
end