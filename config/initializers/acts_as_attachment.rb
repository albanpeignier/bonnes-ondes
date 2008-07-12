module ActsAsAttachment # :nodoc:

  module ClassMethods

    def has_attachment(options = {})
      options[:file_system_path] ||= File.join("public", "attachments", table_name)
      super options
    end

  end

end

ActiveRecord::Base.extend ActsAsAttachment::ClassMethods
