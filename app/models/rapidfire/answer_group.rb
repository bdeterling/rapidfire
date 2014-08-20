module Rapidfire
  class AnswerGroup < ActiveRecord::Base
    belongs_to :question_group
    belongs_to :user, polymorphic: true
    has_many   :answers, inverse_of: :answer_group, autosave: true
    
    validates :user, presence: true#, uniqueness: { scope: :question_group }, :message => "Sorry there was an error. You have already submitted this survey."
    
    if Rails::VERSION::MAJOR == 3
      attr_accessible :question_group, :user
    end
  end
end
