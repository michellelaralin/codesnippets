class Snippet < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  validates :code, presence: true

  def set_user(user)
    self.user_id = user.id
    self.save!
  end

  def can_be_edited_by(user)
    self.user_id = user.id
  end

end
