# frozen_string_literal: true

module Programs
  # Subscription
  class Subscription

    def subscribe(program, user)
      program_user = ProgramUser.find_by program: program, user: user
      if program_user
        raise BaseError.new('USER_IS_SUBSCRIBED_ALREADY',
                            I18n.t('Programs.Subscription.errors.USER_IS_SUBSCRIBED_ALREADY.title'),
                            I18n.t('Programs.Subscription.errors.USER_IS_SUBSCRIBED_ALREADY.detail'))
      end

      Program.transaction do
        ProgramUser.create! program: program, user: user
        program.update count_of_users: program.count_of_users + 1
      end

      true
    end

    def unsubscribe(program, user)
      program_user = ProgramUser.find_by program: program, user: user
      unless program_user
        raise BaseError.new('USER_IS_NOT_SUBSCRIBED',
                            I18n.t('Programs.Subscription.errors.USER_IS_NOT_SUBSCRIBED.title'),
                            I18n.t('Programs.Subscription.errors.USER_IS_NOT_SUBSCRIBED.detail'))
      end

      Program.transaction do
        ProgramUser.destroy!
        program.update count_of_users: program.count_of_users - 1
      end

      true
    end

  end
end