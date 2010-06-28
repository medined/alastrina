
ALASTRINA_CONFIGURATION_FILE = 'config/alastrina.yml'

throw "Missing #{ALASTRINA_CONFIGURATION_FILE}" unless File.exists? ALASTRINA_CONFIGURATION_FILE 

module Alastrina
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def alastrina
      throw "Missing lock_version field." unless column_names.include? "lock_version"
    end
  end

  def before_save
  end
  
  def after_save
    @@config ||= YAML::load(File.read(ALASTRINA_CONFIGURATION_FILE))
    @@twitter_flag ||= !@@config['twitter'].nil?
    
    if @@twitter_flag
      require 'twitter' 
      throw "Missing Twitter userid" if @@config['twitter']['username'].blank? 
      throw "Missing Twitter password" if @@config['twitter']['password'].blank? 
    end
    send_via_twitter if @@twitter_flag
  end

private

  def send_via_twitter
    if changes.size > 0
      httpauth = Twitter::HTTPAuth.new(@@config['twitter']['username'], @@config['twitter']['password'])
      client = Twitter::Base.new(httpauth)
      begin
        client.update(changes.to_yaml)
      rescue
        RAILS_DEFAULT_LOGGER.error "alastrina.send_via_twitter; Unable to send change. Message[#{$!}] Change[#{changes.to_yaml}]"
      end
    end
  end
  
end

ActiveRecord::Base.class_eval { include Alastrina }
