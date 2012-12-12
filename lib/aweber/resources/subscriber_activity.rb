module AWeber
  module Resources
    class SubscriberActivity < Resource
      basepath "/subscriber_activity"

      api_attr :event_time
      api_attr :http_etag
      api_attr :id
      api_attr :resource_type_link
      api_attr :self_link
      api_attr :subscriber_link
      api_attr :type
    end
  end
end
