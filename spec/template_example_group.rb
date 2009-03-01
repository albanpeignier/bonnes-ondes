module Spec
  module Rails
    module Example
      class TemplateExampleGroup < Spec::Rails::Example::ViewExampleGroup
        Spec::Example::ExampleGroupFactory.register(:templates, self)
      end
    end
  end
end
