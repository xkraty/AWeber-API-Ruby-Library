module AWeber
  module Resources
    class Stat < Resource
      basepath "/stats"
      
      api_attr :description
      api_attr :value
      
    end
  end
end

