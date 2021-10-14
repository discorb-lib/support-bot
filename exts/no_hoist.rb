require "discorb"

class NoHoist
  include Discorb::Extension
  event :member_add do |member|
    unhoist_member(member)
  end

  event :member_update do |_before, after|
    unhoist_member(after)
  end

  def self.unhoist_member(member)
    Async do
      if member.name.start_with?("!")
        member.edit(nick: member.name.sub(/^[\s!]+/, ""))
      end
    end
  end
end
