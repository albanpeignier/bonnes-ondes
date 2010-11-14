# defaults to exception.notifier@default.com
ExceptionNotification::Notifier.sender_address = %("Bonnes-Ondes Error" <root@tryphon.eu>)

# defaults to "[ERROR] "
ExceptionNotification::Notifier.email_prefix = "[BonnesOndes] "

# Workaround for https://rails.lighthouseapp.com/projects/8995/tickets/85-exception_notification-2330-fails-with-rails-235
ExceptionNotification::Notifier.view_paths = ActionView::Base.process_view_paths(ExceptionNotification::Notifier.view_paths)
