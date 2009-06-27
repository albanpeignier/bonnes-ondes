module Technoweenie # :nodoc:
  module AttachmentFu # :nodoc:
    def self.create_tempfile_path
      tmp_file = Tempfile.new('attachmentfu', '/tmp')
      tmp_directory = tmp_file.path
      tmp_file.delete
      Dir.mkdir(tmp_directory, 0750)

      Signal.trap("EXIT") do
        FileUtils.rm_rf tmp_directory
      end

      tmp_directory
    end
  end
end

Technoweenie::AttachmentFu.tempfile_path = Technoweenie::AttachmentFu::create_tempfile_path
