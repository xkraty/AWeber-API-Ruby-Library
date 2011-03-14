module AWeber
  module Resources
    class Open < Resource
      basepath "/opens"
      
      api_attr :event_time
      api_attr :subscriber_link
      
      has_one :subscriber
    end
  end
end