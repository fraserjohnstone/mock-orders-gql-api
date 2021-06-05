class MockProducer
  KAFKA_TOPIC = "notificationEvents".freeze
  KAFKA_BROKERS = ["kafka:9092"].freeze
  KAFKA_CLIENT_ID = "mock-orders".freeze

  def self.produce!(event_type)
    kafka_client = Kafka.new(KAFKA_BROKERS, client_id: KAFKA_CLIENT_ID)
    producer = kafka_client.producer
    producer.produce(message_body(event_type), topic: KAFKA_TOPIC)
    producer.deliver_messages
  end

  def self.message_body(event_type)
    case event_type
    when :panel_invitation_requested
      panel_invitation_requested_body
    else
      {}
    end
  end

  def self.panel_invitation_requested_body
    {
      "type" => "PANEL_INVITATION_REQUESTED",
      "data" => {
        "panelInvitationUUID" => SecureRandom.uuid,
        "tracer" => {
          "eventGuid" => SecureRandom.uuid,
          "timestamp"=>"2021-06-03T04:19:50.131127-07:00"
        }
      }
    }.to_json
  end
end
