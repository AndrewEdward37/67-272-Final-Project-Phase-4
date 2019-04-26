module Contexts
  module ShiftContexts

    def create_shifts
        @shift_assign_ted       = FactoryBot.create(:shift, assignment: @ted_assignment)
        @shift_assign_ted1      = FactoryBot.create(:shift, assignment: @ted_assignment)
        @shift_assign_marshal   = FactoryBot.create(:shift, assignment: @marshal_assignment)
        @shift_assign_rachel    = FactoryBot.create(:shift, assignment: @rachel_assignment)
    end
        
    end

    def remove_shifts
        @shift_assign_ted.destroy
        @shift_assign_ted1.destroy
        @shift_assign_marshal.destroy
        @shift_assign_rachel.destroy

    end
end
