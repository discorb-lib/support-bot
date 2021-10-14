require "discorb"
require "dotenv"
require "dispander"

Dotenv.load

client = Discorb::Client.new(log: File.open("./out.log", "w"), log_level: :debug, intents: Discorb::Intents.all)

client.once :standby do
  puts "Logged in as #{client.user}"
end

load "./exts/auto_role.rb"
load "./exts/eval.rb"
load "./exts/no_hoist.rb"
client.load_extension(AutoRole)
client.load_extension(Evaler)
client.load_extension(NoHoist)

client.run(ENV["TOKEN"])
