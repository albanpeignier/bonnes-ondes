module Technoweenie # :nodoc:
  module AttachmentFu # :nodoc:
    def self.create_tempfile_path
      "/tmp/bonnesondes-#{Process.uid}".tap do |directory|
        Dir.mkdir(directory, 0750) unless File.directory?(directory)
      end
    end
  end
end

Technoweenie::AttachmentFu.tempfile_path = Technoweenie::AttachmentFu::create_tempfile_path
