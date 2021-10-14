# frozen_string_literal: true

require "discorb"

class Evaler
  include Discorb::Extension
  event :message do |message|
    next if message.author.bot?
    next unless message.content.start_with?("s:eval ")

    unless message.author.bot_owner?.wait
      message.reply("You don't have permission to use this command.")
      next
    end

    code = message.content.delete_prefix("s:eval ").delete_prefix("```rb").delete_suffix("```")
    begin
      message.add_reaction(Discorb::UnicodeEmoji["clock3"])
      res = eval("Async { |task| #{code} }.wait", binding, __FILE__, __LINE__) # rubocop:disable Security/Eval
      message.remove_reaction(Discorb::UnicodeEmoji["clock3"])
      message.add_reaction(Discorb::UnicodeEmoji["white_check_mark"])
      unless res.nil?
        res = res.wait if res.is_a? Async::Task
        message.channel.post("```rb\n#{res.inspect[...1990]}\n```")
      end
    rescue Exception => error
      message.reply embed: Discorb::Embed.new("Error!", "```rb\n#{error.full_message(highlight: false)[...1990]}\n```",
                                              color: Discorb::Color[:red])
    end
  end
end
