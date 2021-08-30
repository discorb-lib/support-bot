require "discorb"

module AutoRole
  extend Discorb::Extension

  event :member_add do |member|
    member.add_role(member.guild.roles[ENV["MEMBER_ROLE"]])
  end
end
