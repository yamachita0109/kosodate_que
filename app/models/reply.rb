class Reply < ApplicationRecord
  include Hashid::Rails
  # belogns_to :answer, class_name: 'Answer', foreign_key: :answer_id
end
