module ActsAsAttachment # :nodoc:

  module ClassMethods

    def acts_as_attachment(options = {})
      options[:file_system_path] ||= File.join("public", "attachments", table_name)
      super options
    end

  end

end

ActiveRecord::Base.extend ActsAsAttachment::ClassMethods
