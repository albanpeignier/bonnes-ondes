module Technoweenie # :nodoc:
  module AttachmentFu # :nodoc:
    def self.create_tempfile_path
      tmp_file = Tempfile.new('attachmentfu', '/tmp')
      tmp_directory = tmp_file.path
      tmp_file.delete
      Dir.mkdir(tmp_directory, 0750)

      tmp_directory
    end
  end
end

Technoweenie::AttachmentFu.tempfile_path = Technoweenie::AttachmentFu::create_tempfile_path
