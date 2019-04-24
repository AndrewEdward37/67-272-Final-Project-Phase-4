module Contexts
  module ShiftJobContexts
      
    def create_shift_jobs
        @ted_shift2_job1        = FactoryBot.create(:shift_job, shift: @ted_shift2, job: @cashier)
        @ted_shift2_job2        = FactoryBot.create(:shift_job, shift: @ted_past_shift2, job: @making)
        @marshal_shift1_job1    = FactoryBot.create(:shift_job, shift: @marshal_shift1, job: @cashier)
        @marshal_shift2_job4    = FactoryBot.create(:shift_job, shift: @marshal_past_shift2, job: @delivery)
    end

    def remove_shift_jobs
        @ted_shift2_job1.delete
        @ted_shift2_job2.delete
        @marshal_shift1_job1.delete
        @marshal_shift2_job4.delete
    end
  end
end