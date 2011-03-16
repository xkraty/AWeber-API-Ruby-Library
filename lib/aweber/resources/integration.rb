module AWeber
  module Resources
    class Integration < Resource
      basepath "/integrations"
      
      api_attr :login
      api_attr :service_name
    end
  end
end