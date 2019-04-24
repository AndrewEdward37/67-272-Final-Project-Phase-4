module Contexts
  module JobContexts
    def create_jobs
      @cashier = FactoryBot.create(:job)
      @making  = FactoryBot.create(:job, name: "Ice cream making")
      @mover   = FactoryBot.create(:job, name: "Mover", active: false)
      @delivery   = FactoryBot.create(:job, name: "Delivery guy", active: true)
    end

    def remove_jobs
      @cashier.delete
      @making.delete
      @mover.delete
      @delivery.delete
    end
  end
end