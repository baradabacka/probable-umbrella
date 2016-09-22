class CombineItemsInCart < ActiveRecord::Migration
  def up
    #замена нескольких товаров с общим названием на один с количеством(суммой)
    Cart.all.each do |cart|
      #подсчет кол-ва каждого товара в корзине
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          #удаление отдельных записей
          cart.line_items.where(product_id: product_id).delete_all

          #замена одной записью
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    #разбиение записей с квантити >1
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id,
        product_id: line_item.product_id, quantity: 1
      end

      line_item.destroy
    end
  end
end
