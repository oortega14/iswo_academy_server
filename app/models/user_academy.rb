class UserAcademy < ApplicationRecord
  belongs_to :user
  belongs_to :academy

  enum role: { student: 0, professor: 1, admin: 2 }
end
