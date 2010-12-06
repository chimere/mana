#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default) #, :development)

require_all 'app'
# Debugger.start

# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :game, :user
end



EventMachine.run do

  @mongo = Mongo::Connection.new.db('mana')
  MagicCardsInfo.instance = MagicCardsInfo.new(@mongo)
  
  
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    include Mana::Commander

    ws.onerror do |error|
      puts error.backtrace
    end
    
    ws.onopen do
      ws.send(encode(message('Connected to server')))
    end
    
    ws.onmessage do |msg|
      command = decode(msg)
      action = command['action'].downcase.to_sym

      case action
      when :connect
        ws.game = Mana::Game.find_or_create(command['game_id'])
        ws.user = Mana::User.new(command['username'], ws)
        ws.user.update_library(command['cards'])
        ws.game.connect(ws.user)

      when :server
        operation = command['operation'].downcase.to_sym

        case operation
        when :draw_a_card
          ws.user.draw_a_card
        end          
      else
        # adds author to the command
        ws.game.send_to_opponents(command.merge(:sid => ws.user.sid))
      end

      ws.onclose { ws.game.disconnect(ws.user) }
    end
  end

  puts "Mana server started"
end
