# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.fire

require 'faker'

ActiveRecord::Base.transaction do 

      images = [
            "https://i.imgur.com/OMcZAaz.png",
            "https://i.imgur.com/s9aICCP.png",
            "https://i.imgur.com/3qP7eal.png",
            "https://i.imgur.com/zRjiaQ7.png",
            "https://i.imgur.com/eo6GQw9.png",
            "https://i.imgur.com/OrpaCiY.png",
            "https://i.imgur.com/DvE05cd.png",
            "https://i.imgur.com/qfFmUjl.png",
            "https://i.imgur.com/qtCtNYP.png",
            "https://i.imgur.com/KTpkDE5.png",
            "https://i.imgur.com/rbzu4Yo.png",
            "https://i.imgur.com/aou4mKJ.png"
      ]
      User.destroy_all 
      statuses = ['online', 'away', 'offline', 'do not disturb']
      users = []
      users << User.create!(email: 'demo@gmail.com', user_url: "https://i.imgur.com/XEmZeKe.png", username: 'John Souls', password: 'password', description: 'Just a demo account here to make friends', status: 'online')
      (0...rand(15...25)).each do |i|
            users << User.create!(email: 'demo' + i.to_s + '@gmail.com', user_url: images.sample(), username: Faker::Name.unique.name, password: 'password', description: '', status: statuses.sample())
      end
      # user1 = User.create!(email: 'demo@gmail.com', username: 'John Souls', password: 'password', description: '', status: 'online')
      # user2 = User.create!(email: 'demo1@gmail.com', username: 'Henry', password: 'password', description: '', status: 'offline')
      # user3 = User.create!(email: 'demo2@gmail.com', username: 'Lily', password: 'password', description: '', status: 'away')
      # user4 = User.create!(email: 'demo3@gmail.com', username: 'Gabriel', password: 'password', status: 'do not disturb')
      # user5 = User.create!(email: 'demo4@gmail.com', username: 'Jim', password: 'password', status: 'online')
      # user6 = User.create!(email: 'demo5@gmail.com', username: 'Leon', password: 'password', status: 'online')
      # user7 = User.create!(email: 'demo6@gmail.com', username: 'Kin Ka', password: 'password', status: 'away')
      # user8 = User.create!(email: 'demo7@gmail.com', username: 'Ayce', password: 'password', status: 'do not disturb')
      # user9 = User.create!(email: 'demo8@gmail.com', username: 'Alan', password: 'password', status: 'online')
      # user10 = User.create!(email: 'demo9@gmail.com', username: 'Vivian', password: 'password', status: 'online')
      # user11 = User.create!(email: 'demo10@gmail.com', username: 'Vera', password: 'password', status: 'offline')
      # user12 = User.create!(email: 'demo11@gmail.com', username: 'Alisher', password: 'password', status: 'away')
      # user13 = User.create!(email: 'demo12@gmail.com', username: 'Spencer', password: 'password', status: 'do not disturb')
      # user14 = User.create!(email: 'demo13@gmail.com', username: 'Jeremy', password: 'password', status: 'online')
      # users = [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10, user11, user12, user13, user14]

      Server.destroy_all
      server1 = Server.create!(owner_id: users[0].id, name: 'Anime', is_public: true)
      server2 = Server.create!(owner_id: users.sample().id, name: 'Video Games', is_public: true)
      server3 = Server.create!(owner_id: users.sample().id, name: 'Politics', is_public: true)
      server4 = Server.create!(owner_id: users.sample().id, name: 'Your Friend Group', is_public: true)
      server5 = Server.create!(owner_id: users.sample().id, name: 'Hobby', is_public: true)
      server6 = Server.create!(owner_id: users.sample().id, name: 'Pokemon', is_public: true)
      server7 = Server.create!(owner_id: users.sample().id, name: 'Hanging Out', is_public: true)
      server8 = Server.create!(owner_id: users.sample().id, name: 'Dancing', is_public: true)
      server9 = Server.create!(owner_id: users.sample().id, name: 'Rock Climbing', is_public: true)
      server10 = Server.create!(owner_id: users.sample().id, name: 'Memes', is_public: true)

      servers = [server1, server2, server3, server4, server5, server6, server7, server8, server9, server10]



      ServerMembership.destroy_all
      memberships = Hash.new { |h, k| h[k] = [] }
      servers.drop(1).sample(2).each { |server| memberships[server.id] << ServerMembership.create!(user_id: users[0].id, server_id: server.id)}
      servers.each do |server|
            memberships[server.id] = []
            members = users.drop(1).sample(rand(4...11))
            members.each do |member|
                  if (member.id != server.owner_id)
                        memberships[server.id] << ServerMembership.create!(user_id: member.id, server_id: server.id)
                  end
            end

            memberships[server.id] << ServerMembership.create!(user_id: server.owner_id, server_id: server.id)
      end



      Channel.destroy_all
      channels = []
      servers.each do |server|
            channels << Channel.create!(server_id: server.id, name: 'General')
            channels << Channel.create!(server_id: server.id, name: 'Off Topic')
            channels << Channel.create!(server_id: server.id, name: 'Memes')

            (0...rand(2..5)).each do |i|
                  channels << Channel.create!(server_id: server.id, name: Faker::Movie.unique.title)
            end
      end



      Message.destroy_all
      channels.each do |channel|
            (0...rand(9...15)).each do |i|
                  Message.create!(creator_id: memberships[channel.server_id].sample().user_id, channel_id: channel.id, content: Faker::Quote.matz)
            end
      end


      Friendship.destroy_all
      friendships = []
      users.each do |user|
            friends = users.sample(rand(4...7))
            friends.each do |friend|
                  if (friend != user) && !Friendship.exists?(user_id: user.id, friend_id: friend.id) 
                        friendships << Friendship.create!(user_id: user.id, friend_id: friend.id, status: 'resolved')
                        Friendship.create!(user_id: friend.id, friend_id: user.id, status: 'resolved')
                  end
            end
            
      end

      Conversation.destroy_all 
      ConversationParticipant.destroy_all
      DirectMessage.destroy_all
      #convos = {}
      friendships.each do |friendship|
            #if (convos[friendship.user_id])
            new_conversation = Conversation.create!(owner_id: friendship.user_id)
            ConversationParticipant.create(participant_id: friendship.user_id, conversation_id: new_conversation.id)
            ConversationParticipant.create(participant_id: friendship.friend_id, conversation_id: new_conversation.id)

      (0...rand(7...12)).each do |i|
                  DirectMessage.create!(creator_id: [friendship.user_id, friendship.friend_id].sample(), conversation_id: new_conversation.id, content: Faker::Movie.quote)
            end
      end
      
end