# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, foreign_key: :author_id
  has_many :answers, foreign_key: :author_id

  def is_author?(resource)
    return false if resource.nil?

    resource.author == self
  end
end
