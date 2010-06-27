puts 'alastrina.rb'

module Alastrina
  puts 'module Alastrina'
  def self.say_hello
    puts 'hello world'
  end
end

module ActiveRecord::Base
  puts 'ActiveRecord::Base'
  def after_save
    puts "after_save"
  end
end
