class QuestionCntHistory < ApplicationRecord
  include Hashid::Rails
  enum status: {
    good: 'GOOD',
    bad: 'BAD'
  }
end
