# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, foreign_key: :author_id, inverse_of: 'author'
  has_many :answers, foreign_key: :author_id, inverse_of: 'author'

  def author?(resource)
    return false if resource.nil?

    resource.author == self
  end
end
