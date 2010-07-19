class Admin::TemplatesController < InheritedResources::Base
  defaults :collection_name => 'user_templates', :instance_name => 'user_template'

  def create
    create!
    @user_template.users << current_user
  end

  protected

  def begin_of_association_chain
    current_user
  end

  def method_for_association_chain
    :templates
  end
end
