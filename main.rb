# frozen_string_literal: true

require 'discordrb'
require 'dotenv'
require 'uri'
require_relative 'zone'
require_relative 'country'
require_relative 'world_map'
require_relative 'jp_wiki'

Dotenv.load
bot = Discordrb::Bot.new(token: ENV['TOKEN'],
                         client_id: ENV['ID'])

bot.message(content: 'あけおめ') do |event|
  rand_hour = [0, 1].sample
  rand_min = (0..59).to_a.sample
  rand_time = { hour: rand_hour, min: rand_min }
  wake_up_zone = Zone.new(rand_time)
  city = wake_up_zone.city
  time = wake_up_zone.now
  country = Country.has(city)
  tell_zone_msg = "#{event.user.name} は #{country} の #{city} までぶっとんで新年を迎えた！！\n"
  tell_time_msg = "まだ #{time[:hour]}時#{time[:min]}分！！ 去年は終わった！！今年も生きよう！！\n"
  jp_wiki = JpWiki.new(city)

  WorldMap.paint(country)
  event.respond(tell_zone_msg + tell_time_msg)
  event.send_file(File.open('world_map.png', 'r'))

  event.channel.send_embed do |embed|
    embed.title = jp_wiki.get_title
    embed.url = jp_wiki.get_link
    embed.description = jp_wiki.get_description
  end
end

bot.run
