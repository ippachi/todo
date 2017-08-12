class Task < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :dead_limit, presence: true

  def dead_line
    dead_line = (dead_limit - Date.today).to_i
    if dead_line < 0 
      "already reach limit."
    else
      "#{dead_line} days left."
    end
  end

end
