require 'rails_helper'

RSpec.describe OrderAcceptService, type: :class do
  before(:each) do
    @barista = Barista.create_with_code('Sid')
    @latte = MenuItem.create({name: 'Latte', price_in_cents: 6_00})
    @americano = MenuItem.create({name: 'Americano', price_in_cents: 4_00})
    @order = Order.create_for(@barista)

    OrderAddItemService.new(@order.id).add(@latte)
    OrderAddItemService.new(@order.id).add(@americano)
  end

  describe '.accept' do
    context 'when the order is in the open state' do
      it 'should update the state to accepted' do
        order_accept_response = OrderAcceptService.new(@order.id, 'Sid').accept!
        expect(order_accept_response.success).to be_truthy
        expect(order_accept_response.order.status).to eql(Order::ACCEPTED)
      end
      it 'should associate the customer information with the order' do
        order_accept_response = OrderAcceptService.new(@order.id, 'Sid').accept!
        expect(order_accept_response.order.customer.nil?).to be_falsey
      end
    end

    context 'when an order cannot be found' do
      it 'should return an invalid order error' do
        order_accept_response = OrderAcceptService.new('123123', 'Sid').accept!
        expect(order_accept_response.success).to be_falsey
        expect(order_accept_response.errors.first).to eql(OrderAcceptService::INVALID_ORDER_ERROR)
      end
    end

    context 'when the order is not in the open state' do
      it 'should return an invalid state error' do
        order_2 = Order.create_for(@barista)
        order_2.cancel!
        order_accept_response = OrderAcceptService.new(order_2.id, 'Sid').accept!
        expect(order_accept_response.success).to be_falsey
        expect(order_accept_response.errors.first).to eql(OrderAcceptService::INVALID_ORDER_STATUS)
      end
    end

  end

end