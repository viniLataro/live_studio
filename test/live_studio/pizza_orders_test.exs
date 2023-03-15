defmodule LiveStudio.PizzaOrdersTest do
  use LiveStudio.DataCase

  alias LiveStudio.PizzaOrders

  describe "pizza_orders" do
    alias LiveStudio.PizzaOrders.PizzaOrder

    import LiveStudio.PizzaOrdersFixtures

    @invalid_attrs %{price: nil, size: nil, style: nil, topping_1: nil, topping_2: nil}

    test "list_pizza_orders/0 returns all pizza_orders" do
      pizza_order = pizza_order_fixture()
      assert PizzaOrders.list_pizza_orders() == [pizza_order]
    end

    test "get_pizza_order!/1 returns the pizza_order with given id" do
      pizza_order = pizza_order_fixture()
      assert PizzaOrders.get_pizza_order!(pizza_order.id) == pizza_order
    end

    test "create_pizza_order/1 with valid data creates a pizza_order" do
      valid_attrs = %{price: "120.5", size: "some size", style: "some style", topping_1: "some topping_1", topping_2: "some topping_2"}

      assert {:ok, %PizzaOrder{} = pizza_order} = PizzaOrders.create_pizza_order(valid_attrs)
      assert pizza_order.price == Decimal.new("120.5")
      assert pizza_order.size == "some size"
      assert pizza_order.style == "some style"
      assert pizza_order.topping_1 == "some topping_1"
      assert pizza_order.topping_2 == "some topping_2"
    end

    test "create_pizza_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PizzaOrders.create_pizza_order(@invalid_attrs)
    end

    test "update_pizza_order/2 with valid data updates the pizza_order" do
      pizza_order = pizza_order_fixture()
      update_attrs = %{price: "456.7", size: "some updated size", style: "some updated style", topping_1: "some updated topping_1", topping_2: "some updated topping_2"}

      assert {:ok, %PizzaOrder{} = pizza_order} = PizzaOrders.update_pizza_order(pizza_order, update_attrs)
      assert pizza_order.price == Decimal.new("456.7")
      assert pizza_order.size == "some updated size"
      assert pizza_order.style == "some updated style"
      assert pizza_order.topping_1 == "some updated topping_1"
      assert pizza_order.topping_2 == "some updated topping_2"
    end

    test "update_pizza_order/2 with invalid data returns error changeset" do
      pizza_order = pizza_order_fixture()
      assert {:error, %Ecto.Changeset{}} = PizzaOrders.update_pizza_order(pizza_order, @invalid_attrs)
      assert pizza_order == PizzaOrders.get_pizza_order!(pizza_order.id)
    end

    test "delete_pizza_order/1 deletes the pizza_order" do
      pizza_order = pizza_order_fixture()
      assert {:ok, %PizzaOrder{}} = PizzaOrders.delete_pizza_order(pizza_order)
      assert_raise Ecto.NoResultsError, fn -> PizzaOrders.get_pizza_order!(pizza_order.id) end
    end

    test "change_pizza_order/1 returns a pizza_order changeset" do
      pizza_order = pizza_order_fixture()
      assert %Ecto.Changeset{} = PizzaOrders.change_pizza_order(pizza_order)
    end
  end
end
