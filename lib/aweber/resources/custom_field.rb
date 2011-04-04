module AWeber
  module Resources
    class CustomField < Resource
      basepath "/custom_fields"
      
      api_attr :name,                     :writable => true
      api_attr :is_subscriber_updateable, :writable => true
            
      alias_attribute :is_subscriber_updateable?, :is_subscriber_updateable
    end
  end
end