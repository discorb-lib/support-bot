require "discorb"

module AutoRole
  extend Discorb::Extension

  event :member_join do |member|
    member.add_role(member.guild.roles["863590395282587668"])
  end
end
