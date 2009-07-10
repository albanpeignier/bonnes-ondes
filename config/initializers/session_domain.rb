require 'dispatcher'

Dispatcher.to_prepare do
  class Dispatcher
    def set_session_domain
      session_domain = 
        case @request.host
        when "localhost"
          @request.host
        else
          "#{@request.host.gsub(/^[^.]*/, '')}"
        end
      
      RAILS_DEFAULT_LOGGER.debug("change session domain #{session_domain}")
      ApplicationController.session_options.update(:session_domain => session_domain)
    end

    before_dispatch :set_session_domain
  end
end
