module Rapidfire
  class QuestionGroup < ActiveRecord::Base
    has_many  :questions, dependent: :destroy
    validates :name, :presence => true

    if Rails::VERSION::MAJOR == 3
      attr_accessible :name
    end
  end
end
