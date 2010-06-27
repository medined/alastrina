module Alastrina
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def alastrina
      throw "Missing lock_version field." unless column_names.include? "lock_version"
    end
  end
  
  def after_save
    puts "after_save: name: #{self.name}"
  end
  
end

ActiveRecord::Base.class_eval { include Alastrina }
