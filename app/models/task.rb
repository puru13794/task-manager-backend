class Task < ApplicationRecord
	belongs_to :user
	enum :status, { todo: 0, in_progress: 1, done: 2 }
	validates :title, presence: { message: "Title can't be blank" }
	validates :description, presence: { message: "Description can't be blank" }
	validates :status, inclusion: { in: statuses.keys, message: "Invalid status value" }
end