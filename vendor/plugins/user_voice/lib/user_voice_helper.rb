module UserVoiceHelper

  def user_voice_feedback(user_voice_account = UserVoice.default, options = {})
    user_voice_account = user_voice_account.dup.update_attributes(options)

    javascript_tag do
      code = <<-JS
        var uservoiceJsHost = ("https:" == document.location.protocol) ? "https://uservoice.com" : "http://cdn.uservoice.com";
        document.write(unescape("%3Cscript src='" + uservoiceJsHost + "/javascripts/widgets/tab.js' type='text/javascript'%3E%3C/script%3E"))
      JS
    end +
    javascript_tag do
      "UserVoice.Tab.show(#{user_voice_account.to_json})"
    end
  end

end
