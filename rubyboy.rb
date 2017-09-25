require 'discordrb'
require 'json'

file = File.read('info.json')
info_hash = JSON.parse(file)
songs = info_hash['songs']

bot = Discordrb::Commands::CommandBot.new token: info_hash['token'], client_id: 359082109119365140, prefix: '~'

bot.message(with_text: 'Ping') do |event|
  event.respond 'Hello'
end

bot.command(:play) do |event|
  song = event.message.content.split(' ')[1]
  if songs[song]
    bot.voice_connect(event.author.voice_channel)
    event.voice.play_file(songs[song])
  end 
  
  
end

bot.run