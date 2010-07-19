require 'dispatcher'

Dispatcher.to_prepare do
  module ActionController
    class Dispatcher
      def set_session_domain
        server_name = @env['SERVER_NAME']

        session_domain = 
          case server_name
          when "localhost"
            server_name
          else
            "#{server_name.gsub(/^[^.]*/, '')}"
          end
        
        ApplicationController.session_options.update(:session_domain => session_domain)
      end

      before_dispatch :set_session_domain
    end
  end
end
