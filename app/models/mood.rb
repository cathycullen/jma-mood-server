class Mood < ActiveRecord::Base
  belongs_to :user

  :order => "created_at DESC"
end
