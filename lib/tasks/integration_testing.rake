namespace :integration_testing do
  desc "Runs the notifications service integration tests"
  task produce_message: :environment do
    MockProducer.produce!(:panel_invitation_requested)
  end
end
