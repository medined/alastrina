ALASTRINA_CONFIGURATION_FILE = 'config/alastrina.yml'

module Alastrina
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def alastrina hash
      p "1hash: #{hash.inspect}"
      module_eval do
        p "2hash: #{hash.inspect}"
        def configuration
          throw "Missing #{ALASTRINA_CONFIGURATION_FILE}" unless File.exists? ALASTRINA_CONFIGURATION_FILE 
          @config ||= YAML::load(File.read(ALASTRINA_CONFIGURATION_FILE))
        end
        if hash[:twitter]
          def send_to_twitter?
            true
          end
          eval"def twitter_username\n\"#{hash[:twitter][:username]}\"\nend\n"
          eval "def twitter_password\n\"#{hash[:twitter][:password]}\"\nend\n"
        else
          def send_to_twitter?
            @twitter_flag ||= !configuration['twitter'].blank?
          end
          def twitter_username
            @twitter_username ||= configuration['twitter']['username'] if send_to_twitter?
          end
          def twitter_password
            @twitter_password ||= configuration['twitter']['password'] if send_to_twitter?
          end
        end
      end
    end
  end

  def after_save
    if send_to_twitter?
      require 'twitter' 
      throw "Missing Twitter userid" if twitter_username.blank? 
      throw "Missing Twitter password" if twitter_password.blank?
      send_via_twitter
    end
  end

private

  def send_via_twitter
    if changes.size > 0
      httpauth = Twitter::HTTPAuth.new(twitter_username, twitter_password)
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
