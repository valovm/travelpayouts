# frozen_string_literal: true

module Programs
  # Subscription
  class Subscription

    class SubscriptionError < StandardError

    end

    def subscribe(program, user)
      program_user = ProgramUser.find_by program: program, user: user
      raise SubscriptionError, 'USER_IS_SUBSCRIBED_ALREADY' if program_user

      ProgramUser.create! program: program, user: user
      true
    end

    def unsubscribe(program, user)
      program_user = ProgramUser.find_by program: program, user: user
      raise SubscriptionError, 'USER_IS_NOT_SUBSCRIBED' unless program_user

      program_user.destroy!
      true
    end

  end
end