module Form
  class ServiceWorkerPushNotificationSettingForm
    include ActionView::Helpers::FormTagHelper

    def initialize(subscriptions:)
      @subscriptions = subscriptions
    end

    def save!(params)
      @subscriptions.each do |subscription|
        if params.fetch(:push_subscriptions, Hash.new).has_key?(subscription.id.to_s)
          ServiceWorkerPushNotificationSettingService.new(subscription).enable!
        else
          ServiceWorkerPushNotificationSettingService.new(subscription).disable!
        end
      end
    end

    def check_box_tag_for(subscription)
      check_box_tag("push_subscriptions[#{subscription.id}]", 1, subscription.enabled?)
    end

    def label_tag_for(subscription, label)
      label_tag("push_subscriptions[#{subscription.id}]", label)
    end
  end
end
