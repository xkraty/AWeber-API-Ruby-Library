module AWeber
  module Resources
    class Account < Resource
      basepath "/accounts"
      
      api_attr :lists_collection_link
      api_attr :integrations_collection_link
    
      has_many :lists
      has_many :integrations
    
      alias_attribute :etag, :http_etag
      alias_attribute :uri, :self_link

      def find_subscribers(params={})
        params   = params.map { |k,v| "#{h(k)}=#{h(v)}" }.join("&")
        uri      = "#{path}?ws.op=findSubscribers&#{params}"
        response = client.get(uri).merge(:parent => self)
        response["total_size"] ||= response["entries"].size

        Collection.new(client, Subscriber, response)
      end

      def web_forms
        uri = "#{path}?ws.op=getWebForms"
        response = client.get(uri)
        
        response.map { |webform| WebForm.new(client, webform) }
      end

      def web_form_split_tests
        uri = "#{path}?ws.op=getWebFormSplitTests"
        response = client.get(uri)
        
        response.map { |split_test| WebFormSplitTest.new(client, split_test) }
      end
    end
  end
end
