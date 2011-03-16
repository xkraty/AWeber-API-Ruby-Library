module AWeber
  module Resources
    class Campaign < Resource
      basepath "/campaigns"
      
      api_attr :click_tracking_enabled
      api_attr :content_type
      api_attr :is_archived
      api_attr :message_interval
      api_attr :message_number
      api_attr :scheduled_at
      api_attr :sent_at
      api_attr :spam_assassin_score
      api_attr :subject
      api_attr :total_clicked
      api_attr :total_clicks
      api_attr :total_opened
      api_attr :total_opens
      api_attr :total_sent
      api_attr :total_spam_complaints
      api_attr :total_undelivered
      api_attr :total_unsubscribes
      api_attr :twitter_account_link
      api_attr :links_collection_link
      api_attr :messages_collection_link
      
      has_many :links
      has_many :messages
      
      alias_attribute :is_archived?, :is_archived
      alias_attribute :is_click_tracking_enabled?, :click_tracking_enabled
      
      def is_followup?
        resource_type_link.split("#").last =~ /^followup/
      end
      
      def is_broadcast?
        resource_type_link.split("#").last =~ /^broadcast/
      end
    end
  end
end