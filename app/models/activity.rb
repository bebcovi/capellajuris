# encoding: utf-8
class Activity < ActiveRecord::Base
  validates_presence_of :year, :message => "Godina ne smije biti prazna."
  validates_numericality_of :year, :only_integer => true, :message => "Godina mora biti broj. (Primjerice, ne smije biti \"2009.\", nego mora biti \"2009\")"
  validates_uniqueness_of :year, :message => "Već postoji ta godina (%{value})."
  validates_presence_of :bullets, :message => "Sadržaj ne smije biti prazan."
end
