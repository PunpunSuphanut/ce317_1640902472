class User
  attr_accessor :name, :email, :password
  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
    @rooms = []
  end

  def enter_room(room)
    @rooms << room
    room.add_user(self)
  end

  def send_message(room, content)
    message = Message.new(self, room, content)
    room.broadcast(message)
  end

  def acknowledge_message(room, message)
    puts "#{@name} acknowledged the message in #{room.name}: #{message.content}"
  end
end

class Room
  attr_accessor :name, :description, :users

  def initialize(name, description)
    @name = name
    @description = description
    @users = []
  end

  def add_user(user)
    @users << user unless @users.include?(user)
  end

  def broadcast(message)
    @users.each do |user|
      puts "#{user.name} received message in #{self.name}: #{message.content}"
    end
  end
end

class Message
  attr_accessor :user, :room, :content

  def initialize(user, room, content)
    @user = user
    @room = room
    @content = content
  end
end

Suphanut = User.new("Suphanut", "Suphanut@email.com", "password123")
chat_room = Room.new("General Chat", "A room for general")

Suphanut.enter_room(chat_room)
Suphanut.send_message(chat_room, "Hello, everyone!")
