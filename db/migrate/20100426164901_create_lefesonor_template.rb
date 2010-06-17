# -*- coding: utf-8 -*-
class CreateLefesonorTemplate < ActiveRecord::Migration
  def self.up
    Template.create :name => "Léfésonor", :slug => "lefesonor"
  end

  def self.down
    Template.find_by_slug('lefesonor').destroy
  end
end
