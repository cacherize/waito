class Faq < ActiveRecord::Base
  attr_accessible :question, :answer, :sort
end
