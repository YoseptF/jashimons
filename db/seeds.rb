# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'joseph', email: 'yosept.flores@gmail.com')

Config.create(direction: true, show: true, blackList: '', bubble: '', user_id:1)

Command.create(name: 'sayHi', message: 'hi how are you?', animationName: 'salute', animationType: true, duration: 1.2, cooldown: 3.5, isEnabled: true, user_id:1)

MascotCollection.create(user_id: 1, default: 'dance')

Mascot.create(name: 'cookie', message: '')
Mascot.create(name: 'sunny', message: '')
Mascot.create(name: 'foxxy', message: '')

MascotRelationship.create(user_id:1, mascot_id:1, isMain: false)
MascotRelationship.create(user_id:1, mascot_id:2, isMain: false)
MascotRelationship.create(user_id:1, mascot_id:3, isMain: true)

