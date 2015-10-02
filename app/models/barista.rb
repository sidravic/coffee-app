class Barista < ActiveRecord::Base
  include TokenGeneratorService

  validates :name, presence: true
  validates :code, presence: true

  has_many :orders

  def self.create_with_code(name)
    create(name: name, code: generate_unique_token_for('code'))
  end
end
