class Faq < ActiveRecord::Base
  attr_accessible :question, :answer, :sort

  validates_presence_of :question, :answer, :sort
end
