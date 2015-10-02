require 'rails_helper'

RSpec.describe OrderCreateService, type: :class do
  before(:each) do
    @barista = Barista.create_with_code('Sid')
  end

  describe '.create' do
    context 'when no other order is open for a barista' do
      it 'should create a new order' do
        order_create_response = OrderCreateService.new(@barista.code).create
        expect(order_create_response.success).to be_truthy
      end

      context 'and when a new order is created' do
        it 'should create the order in the `OPENED` state' do
          order_create_response = OrderCreateService.new(@barista.code).create
          expect(order_create_response.order.status).to eql(Order::OPEN)
        end
        it 'should be assigned to an barista' do
          order_create_response = OrderCreateService.new(@barista.code).create
          expect(order_create_response.order.barista).to eql(@barista)
        end
      end

    end

    context 'when another order is open for a given employee' do
      it 'should not create a new order' do
        open_order = Order.create_for(@barista)

        order_create_response = OrderCreateService.new(@barista.code).create
        expect(order_create_response.success).to be_falsey
        expect(order_create_response.errors.first).to eql(OrderCreateService::OPEN_ORDER_ERROR)
      end
    end

    context 'when a barista/user cannot provide a valid barista code' do
      it 'should return an indicating the incorrect barista code' do
        order_create_response = OrderCreateService.new('123123').create
        expect(order_create_response.success).to be_falsey
        expect(order_create_response.errors.first).to eql(OrderCreateService::INVALID_BARISTA_CODE)
      end


    end
  end
end
