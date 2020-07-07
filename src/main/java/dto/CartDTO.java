package dto;

import domain.DomainObject;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
public class CartDTO extends DomainObject {
    List<CartItemDTO> cartItems;
    Double total;

    public CartDTO() {
        cartItems = new ArrayList<>();
        total = 0.0;
    }

    public void addItem(CartItemDTO item) {
        cartItems.add(item);
        total += item.getPrice() * item.getQuantity();
    }

    public void removeItem(CartItemDTO item) {
        if (cartItems.contains(item))
            total -= item.getPrice() * item.getQuantity();
        cartItems.remove(item);
    }

    public int getNumberOfItems() {
        return cartItems.size();
    }

    public void updateCartItem(int id, int qty) {
        for (CartItemDTO item : cartItems) {
            if (item.getBookId() == id) {
                if (qty == 0) {
                    total -= item.getPrice() * item.getQuantity();
                    cartItems.remove(item);
                } else {
                    total += item.getPrice() * (qty - item.getQuantity());
                    item.setQuantity(qty);
                }
                break;
            }
        }
    }

    public List<CartItemDTO> getItemList() {
        return cartItems;
    }

    public void mergeCarts(CartDTO newCart) {
        for (CartItemDTO item : newCart.getCartItems()) {
            this.cartItems.add(item);
        }
    }
}
