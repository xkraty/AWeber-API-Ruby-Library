module AWeber
  module Resources
    class CustomField < Resource
      basepath "/custom_fields"
      
      api_attr :name
      api_attr :is_subscriber_updateable
            
      alias_attribute :is_subscriber_updateable?, :is_subscriber_updateable
    end
  end
end