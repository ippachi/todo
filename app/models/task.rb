class Task < ApplicationRecord
  before_save {category.to_i}
  belongs_to :user
  validates :content, presence: true
  validates :dead_limit, presence: true

  enum category: {None: 0,
                  Work: 1,
                  Study: 2,
                  Life: 3}

  def dead_line
    dead_line = (dead_limit - Date.today).to_i
    if dead_line < 0 
      "already reach limit."
    else
      "#{dead_line} days left."
    end
  end

end
