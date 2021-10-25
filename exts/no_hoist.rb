require "discorb"

class NoHoist
  include Discorb::Extension
  event :member_add do |member|
    unhoist_member(member)
  end

  event :member_update do |_before, after|
    unhoist_member(after)
  end

  def unhoist_member(member)
    if member.name.start_with?("!")
      new_nick = member.name.sub(/^[\s!]+/, "")
      new_nick = "Deleted due to hoisting" if new_nick.empty?
      member.edit(nick: new_nick)
    end
  end
end
