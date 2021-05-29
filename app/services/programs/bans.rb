# frozen_string_literal: true

module Programs

  class Bans

    attr_reader :program, :user

    def initialize(program, user)
      @program = program
      @user = user
    end

    def banned?
      ban.present?
    end

    def in_ban
      if ban
        raise BaseError.new('USER_IS_BANNED_ALREADY',
                            I18n.t('programs.bans.errors.USER_IS_BANNED_ALREADY.title'),
                            I18n.t('programs.bans.errors.USER_IS_BANNED_ALREADY.detail'))
      end
      BanProgramUser.create! program: program, user: user

      true
    end

    def out_ban
      unless ban
        raise BaseError.new('USER_IS_NOT_BANNED',
                            I18n.t('programs.bans.errors.USER_IS_NOT_BANNED.title'),
                            I18n.t('programs.bans.errors.USER_IS_NOT_BANNED.detail'))
      end
      ban.destroy

      true
    end

    private

    def ban
      BanProgramUser.find_by program: program, user: user
    end
  end
end