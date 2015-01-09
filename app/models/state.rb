class State < ActiveRecord::Base
  has_many :tickets

  def to_s
    name
  end

  def default!
    State.find_by(default: true).try(:update!, default: false)
    update!(default: true)
  end
end
