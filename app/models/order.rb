class Order < ActiveRecord::Base
  OPEN = 'OPEN'
  CLOSED = 'CLOSED'
  ACCEPTED = 'ACCEPTED'
  CANCELLED = 'CANCELLED'

  VALID_STATES = [OPEN, CLOSED, ACCEPTED, CANCELLED]


  validates :customer_id, presence: true, if: Proc.new {|order| order.closed? }
  validates :amount_in_cents, numericality: true
  validates :status, presence: true, inclusion: {in: VALID_STATES}
  validates :barista_id, presence: true

  scope :open, Proc.new { where(status: OPEN) }
  scope :accepted, Proc.new { where(status: ACCEPTED) }


  belongs_to :barista
  has_many :order_items
  has_many :menu_items, through: :order_items
  belongs_to :customer

  def self.create_for(barista)
    Order.create(barista_id: barista.id)
  end

  def close!
    close
    save!
  end

  def accepted?
    self.status == ACCEPTED
  end

  def cancel!
    self.status = CANCELLED
    save!
  end

  def close
    self.status = CLOSED
  end

  def closed?
    self.status == CLOSED
  end

  def accept!
    self.status = ACCEPTED
    self.save!
  end

  def open?
    self.status == OPEN
  end
end
