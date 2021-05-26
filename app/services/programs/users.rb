# frozen_string_literal: true

module Programs
  class Users
    def initialize(program, user)
      @bans_service = Users::Bans.new(program, user)
      @subscriptions_service = Users::Subscriptions.new(program, user)
    end

    def subscribe
      if @bans_service.banned?
        raise BaseError.new('USER_IS_BANNED', I18n.t('Programs.Subscription.errors.USER_IS_BANNED.title'), I18n.t('Programs.Subscription.errors.USER_IS_BANNED.detail'))
      end

      @subscriptions_service.subscribe
    end

    def unsubscribe
      @subscriptions_service.unsubscribe
    end

    def in_ban
      @bans_service.in_ban
      @subscriptions_service.unsubscribe if @subscriptions_service.subscribed?
    end

    def out_ban
      @bans_service.out_ban
    end
  end
end
