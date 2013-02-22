module AWeber
  module Resources
    class WebForm < Resource
      basepath "/web_forms"
      
      api_attr :conversion_percentage
      api_attr :is_active
      api_attr :name
      api_attr :total_displays
      api_attr :total_submissions
      api_attr :total_unique_displays
      api_attr :type
      api_attr :unique_conversion_percentage
      api_attr :html_source_link
      api_attr :javascript_source_link

    end
  end
end