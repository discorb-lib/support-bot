require "discorb"

module NoHoist
  extend Discorb::Extension

  event :member_join do |_task, member|
    unhoist_member(member)
  end

  event :member_update do |_task, _before, after|
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
