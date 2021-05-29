module Programs
  class Subscriptions::List

    def call(user, with_banned: false)
      programs = user.programs
      unless with_banned
        programs = programs.where.not(id: BanProgramUser.where(user: user).pluck(:program_id))
      end

      programs
    end

  end
end