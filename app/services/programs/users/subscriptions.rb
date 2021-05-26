# frozen_string_literal: true

module Programs
  # Users::Subscriptions
  class Users::Subscriptions

    attr_reader :program, :user

    def initialize(program, user)
      @program = program
      @user = user
    end

    def subscribed?
      subscription.present?
    end

    def subscribe
      if subscribed?
        raise BaseError.new('USER_IS_SUBSCRIBED_ALREADY', I18n.t('Programs.Subscription.errors.USER_IS_SUBSCRIBED_ALREADY.title'), I18n.t('Programs.Subscription.errors.USER_IS_SUBSCRIBED_ALREADY.detail'))
      end

      Program.transaction do
        ProgramUser.create! program: program, user: user
        program.count_of_users += 1
        program.save
      end

      true
    end

    def unsubscribe
      unless subscribed?
        raise BaseError.new('USER_IS_NOT_SUBSCRIBED', I18n.t('Programs.Subscription.errors.USER_IS_NOT_SUBSCRIBED.title'), I18n.t('Programs.Subscription.errors.USER_IS_NOT_SUBSCRIBED.detail'))
      end

      Program.transaction do
        subscription.destroy!
        program.count_of_users -= 1
        program.count_of_users = 0 if program.count_of_users.negative?
        program.save
      end

      true
    end

    private

    def subscription
      ProgramUser.find_by program: program, user: user
    end

  end
end