require "discorb"

class AutoRole
  include Discorb::Extension
  event :member_add do |member|
    member.add_role(member.guild.roles[ENV["MEMBER_ROLE"]])
  end
end
