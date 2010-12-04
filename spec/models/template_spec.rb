# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Template do

  subject { Factory(:template) }

  it { should validate_presence_of :name, :message => "Le nom doit être renseigné" }

  it { should validate_presence_of :slug, :message => "Le lien doit être renseigné" }
  it { should allow_values_for(:slug, "abcd", "abcd-ef-2010", "ABCD-EF") }
  it { should_not allow_values_for(:slug, "../abcd", "abcd ef", "abcdé") }

  it { should validate_presence_of :scm_url, :message => "L'URL git doit être renseignée" }

end
