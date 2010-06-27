module Alastrina
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def alastrina
      puts "class method alastrina"
    end
  end
  
  def after_save
    puts "after_save: name: #{self.name}"
  end
  
end

ActiveRecord::Base.class_eval { include Alastrina }
