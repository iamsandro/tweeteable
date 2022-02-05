class Tweet < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :retweets, class_name: "Tweet",
           foreign_key: "replied_to_id",
           dependent: :destroy,
           inverse_of: "replied_to"

  belongs_to :replied_to, class_name: "Tweet", counter_cache: :replies_count, optional: true

  has_many :likes,  dependent: :destroy

  # Validations
  validates :body, presence: true
  validates :body, length: { maximum: 140 }

end

# class Task < ActiveRecord::Base
#   belongs_to :sub_task, class_name: Task.name, touch: true, counter_cache: :sub_tasks_count
#   has_many :sub_tasks, class_name: Task.name, foreign_key: :sub_task_id, dependent: :destroy
# end