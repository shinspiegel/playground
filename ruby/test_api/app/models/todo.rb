class Todo < ApplicationRecord
    validates_presence_of :title, :created_by

    has_many :items, dependent: :destroy
end