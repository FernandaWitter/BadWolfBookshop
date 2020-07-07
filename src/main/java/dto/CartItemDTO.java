package dto;

import domain.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@NoArgsConstructor

@Getter
@Setter
public class CartItemDTO extends DomainObject {
    private int bookId;
    private int quantity;
    private Double price;
    private Double total;
    private String cover;
    private int available;
    private String title;

    public CartItemDTO(int bookId, Double price, String cover, int available, String title) {
        this.bookId = bookId;
        this.price = price;
        this.cover = cover;
        this.available = available;
        this.title = title;
    }

    public CartItemDTO(int bookId, int quantity, Double price, String title, String cover) {
        this.bookId = bookId;
        this.quantity = quantity;
        this.price = price;
        this.total = quantity * price;
        this.title = title;
        this.cover = cover;
    }

    public static CartItemDTO from(Book book) {
        String image = "";
        if (book.getImages() != null && book.getImages().size() > 0)
            image = book.getImages().get(0).getPath();
        return new CartItemDTO(book.getId(), book.getPrice(), image, book.getInStock(), book.getTitle());
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        if (this.price != null)
            this.total = quantity * this.price;
    }

    public OrderItem toOrderItem(int orderId) {
        OrderItem orderItem = new OrderItem();
        orderItem.setStatus(Status.getStatusFromCode(1));
        orderItem.setQuantity(this.quantity);
        orderItem.setModified(LocalDate.now());
        orderItem.setCreated(LocalDate.now());
        orderItem.setBook(new Book(this.bookId));
        orderItem.setOrderId(orderId);
        return orderItem;
    }

}
