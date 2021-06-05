class MockProducer
  KAFKA_TOPIC = "notificationEvents".freeze
  KAFKA_BROKERS = ["kafka:9092"].freeze
  KAFKA_CLIENT_ID = "mock-orders".freeze

  def self.produce!
    kafka = Kafka.new(KAFKA_BROKERS, client_id: KAFKA_CLIENT_ID)
    producer = kafka.producer
    producer.produce(message_body.to_json, topic: KAFKA_TOPIC)
    producer.deliver_messages
  end

  def self.message_body
    {
      "type" => "PANEL_INVITATION_REQUESTED",
      "data" => {
        "panelInvitationUUID" => SecureRandom.uuid,
        "tracer" => {
          "eventGuid" => SecureRandom.uuid,
          "timestamp"=>"2021-06-03T04:19:50.131127-07:00"
        }
      }
    }
  end
end
