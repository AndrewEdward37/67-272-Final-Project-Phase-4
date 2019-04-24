module Contexts
  module ShiftContexts
    def create_shifts
        create_shifts_upcoming
        create_shifts_past
    end

    def remove_shifts
        remove_shifts_upcoming
        remove_shifts_past
    end

    def create_shifts_upcoming
        @ted_shift1       = FactoryBot.create(:shift, assignment: @ted_assignment)
        @ted_shift2       = FactoryBot.create(:shift, assignment: @ted_assignment date: 1.day.from_now.to_date)
        @ted_shift3       = FactoryBot.create(:shift, assignment: @ted_assignment, date: 2.days.from_now.to_date)
        @marshal_shift1   = FactoryBot.create(:shift, assignment: @marshal_assignment)
        @marshal_shift2   = FactoryBot.create(:shift, assignment: @marshal_assignment, date: 1.day.from_now.to_date)
        @barney_shift1    = FactoryBot.create(:shift, assignment: @barney_assignment)
        @rachel_shift1    = FactoryBot.create(:shift, assignment: @rachel_assignment, date: 2.days.from_now.to_date)
    end

    def remove_shifts_upcoming
        @ted_shift1.delete
        @ted_shift2.delete
        @ted_shift3.delete
        @marshal_shift1.delete
        @marshal_shift2.delete
        @barney_shift1.delete
        @rachel_shift1.delete
    end

    def create_shifts_past
        @ted_past_shift1       = FactoryBot.create(:shift, assignment: @ted_assignment, date: 1.week.from_now.to_date)
        @ted_past_shift2       = FactoryBot.create(:shift, assignment: @ted_assignment date: 1.week.from_now.to_date)
        @ted_past_shift3       = FactoryBot.create(:shift, assignment: @ted_assignment, date: 1.week.from_now.to_date)
        @marshal_past_shift1   = FactoryBot.create(:shift, assignment: @marshal_assignment. date: 1.week.from_now.to_date)
        @marshal_past_shift2   = FactoryBot.create(:shift, assignment: @marshal_assignment, date: 1.week.from_now.to_date)
        @barney_past_shift1    = FactoryBot.create(:shift, assignment: @barney_assignment)
        @rachel_past_shift1    = FactoryBot.create(:shift, assignment: @rachel_assignment, date: 1.week.from_now.to_date)
    end

    def remove_shifts_past
        @ted_past_shift1.delete
        @ted_past_shift2.delete
        @ted_past_shift3.delete
        @marshal_past_shift1.delete
        @marshal_past_shift2.delete
        @barney_past_shift1.delete
        @rachel_past_shift1.delete
    end

  end
end
