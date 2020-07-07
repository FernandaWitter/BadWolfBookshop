package domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@AllArgsConstructor
@NoArgsConstructor

@Getter
@Setter
public class OrderItem extends DomainObject {
    private Book book;
    private Integer quantity;
    private Status status;
    private Integer orderId;
    private LocalDate created;
    private LocalDate modified;
    private String returnReason;
    private Integer userId;

    public OrderItem(int orderId) {
        this.orderId = orderId;
    }
}
