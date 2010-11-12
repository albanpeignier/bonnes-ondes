# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Template do

  it { should validate_presence_of :name }

  it { should validate_presence_of :slug }
  it { should allow_values_for(:slug, "abcd", "abcd-ef-2010", "ABCD-EF") }
  it { should_not allow_values_for(:slug, "../abcd", "abcd ef", "abcdé") }

  it { should validate_presence_of :scm_url }

end
