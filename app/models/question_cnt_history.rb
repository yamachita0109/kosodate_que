class QuestionCntHistory < ApplicationRecord
  enum status: {
    good: 'GOOD',
    bad: 'BAD'
  }
end
