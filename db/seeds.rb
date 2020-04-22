# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

User.create(username: 'joseph', email: 'yosept.flores@gmail.com', main_string: SecureRandom.base64(10))

Config.create(direction: true, show: true, black_list: '', bubble: '', user_id:1)

Command.create(name: 'sayHi', message: 'hi how are you?', animationName: 'salute', animationType: true, duration: 1.2, cooldown: 3.5, isEnabled: true, user_id:1)

MascotCollection.create(user_id: 1, default: 'idle')

cookie = Mascot.create(name: 'cookie', message: '', price_money: 750, price_points: 3000)

cookie.animations.attach([
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/gingerbreadman_blue_sad.gif').open, filename: 'cookie_sad.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/gingerbreadman_blue_greet.gif').open, filename: 'cookie_greet.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/gingerbreadman_blue_attack.gif').open, filename: 'cookie_attack.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/gingerbreadman_blue_dance.gif').open, filename: 'cookie_dance.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/gingerbreadman_blue_idle.gif').open, filename: 'cookie_idle.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/gingerbreadman_blue_eat.gif').open, filename: 'cookie_eat.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/gingerbreadman_blue_thanks.gif').open, filename: 'cookie_thanks.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/gingerbreadman_blue_gift.gif').open, filename: 'cookie_gift.gif'}
  ])


sunny = Mascot.create(name: 'sunny', message: '', price_money: 750, price_points: 3000)
sunny.animations.attach([
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/dito_yellow_sad.gif').open, filename: 'sunny_sad.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/dito_yellow_greet.gif').open, filename: 'sunny_greet.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/dito_yellow_attack.gif').open, filename: 'sunny_attack.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/dito_yellow_dance.gif').open, filename: 'sunny_dance.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/dito_yellow_idle.gif').open, filename: 'sunny_idle.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/dito_yellow_eat.gif').open, filename: 'sunny_eat.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/dito_yellow_thanks.gif').open, filename: 'sunny_thanks.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/dito_yellow_gift.gif').open, filename: 'sunny_gift.gif'}
  ])

foxxy = Mascot.create(name: 'foxxy', message: '', price_money: 750, price_points: 3000)
foxxy.animations.attach([
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/fox_orange_greet.gif').open, filename: 'foxxy_greet.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/fox_orange_attack.gif').open, filename: 'foxxy_attack.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/fox_orange_dance.gif').open, filename: 'foxxy_dance.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/fox_orange_idle.gif').open, filename: 'foxxy_idle.gif'},
  {io: URI('https://s3.amazonaws.com/kappamonbot/v2/asset/fox_orange_eat.gif').open, filename: 'foxxy_eat.gif'}
  ])

MascotRelationship.create(user_id:1, mascot_id:1, isMain: false)
MascotRelationship.create(user_id:1, mascot_id:2, isMain: false)
MascotRelationship.create(user_id:1, mascot_id:3, isMain: true)

