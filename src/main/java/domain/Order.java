package domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@NoArgsConstructor

@Getter
@Setter
public class Order extends DomainObject {
    private User user;
    private LocalDate creation;
    private LocalDate modified;
    private Status status;
    private Address shipping;
    private Address billing;
    private List<OrderItem> items;
    private List<Payment> payments;
    private List<Voucher> vouchers;
    private double orderTotal;

    public Order(int id) {
        this.setId(id);
    }
}
