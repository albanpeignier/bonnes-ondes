LanguageManager = Class.create({

  initialize: function() {
    this.languages = $w("en fr nl");

    Event.observe(window, "load", this._on_load.bindAsEventListener(this));
  },

  navigator_language: function() {
    var user_language = navigator.language.split("-").first();
    if (this.languages.indexOf(user_language) == -1) {
      user_language = "fr";
    }
    return user_language;
  },

  display: function(selected_language) {
    this.languages.each(function(language) {
      $$("div[lang=" + language + "]").each(function(element) {
        if (language == selected_language) {
          element.show();
          element.setStyle("display: block;");
        } else {
          element.hide();
        }
      });
    });
  },

  _on_load: function() {
    this.display(this.navigator_language());
  }

});

language_manager = new LanguageManager();