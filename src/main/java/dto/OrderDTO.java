package dto;

import com.sun.org.apache.xpath.internal.operations.Or;
import domain.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class OrderDTO extends DomainObject {
    private Double amountDue;
    private Double amountPaidByCC;
    private Double amountPaidByVoucher;
    private Double shippingCost;
    private Integer user;
    private List<AddressDTO> addresses;
    private List<Address> newAddresses;
    private List<CardDTO> cards;
    private List<Voucher> vouchers;
    private LocalDate creation;
    private Status status;
    private CartDTO items;

    public OrderDTO() {
        this.addresses = new ArrayList<>();
        this.cards = new ArrayList<>();
        this.vouchers = new ArrayList<>();
        this.newAddresses = new ArrayList<>();
        this.amountPaidByCC = this.amountPaidByVoucher = 0.0;
    }

    public static Order toOrder(OrderDTO dto) {
        Order order = new Order();
        order.setUser(new User(dto.getUser()));
        order.setModified(LocalDate.now());

        if (dto.getCreation() == null)
            order.setCreation(LocalDate.now());
        else
            order.setCreation(dto.getCreation());

        if (dto.getStatus() == null)
            order.setStatus(Status.getStatusFromCode(1));
        else
            order.setStatus(dto.status);

        for (AddressDTO address : dto.getAddresses()) {
            if (address.getIsShipping() != null && address.getIsShipping())
                order.setShipping(AddressDTO.toAddress(address));
            if (address.getIsBilling() != null && address.getIsBilling())
                order.setBilling(AddressDTO.toAddress(address));
        }

        for (Address address : dto.getNewAddresses()) {
            if (address.getIsDelivery() != null && address.getIsDelivery())
                order.setShipping(address);
            if (address.getIsBilling() != null && address.getIsBilling())
                order.setBilling(address);
        }

        List<Payment> payments = new ArrayList<>();
        for (CardDTO card : dto.getCards()) {
            payments.add(card.getPayment());
        }
        order.setPayments(payments);

        return order;
    }

    public OrderDTO(Integer user) {
        this.addresses = new ArrayList<>();
        this.cards = new ArrayList<>();
        this.vouchers = new ArrayList<>();
        this.newAddresses = new ArrayList<>();
        this.amountDue = amountPaidByCC = amountPaidByVoucher = shippingCost = 0.0;
        this.user = user;
    }

    public void addAddress(AddressDTO address) {
        this.addresses.add(address);
    }

    public void addNewAddress(Address address) {
        address.setUser(this.user);
        newAddresses.add(address);
    }

    public void addCard(CardDTO card) {
        amountPaidByCC += card.getAmountPaid();
        cards.add(card);
    }

    public void addVoucher(Voucher voucher) {
        if (voucher.getAmount() > amountDue) {
            voucher.setAmount(voucher.getAmount() - amountDue);
            amountPaidByVoucher = amountDue;
        } else {
            amountPaidByVoucher = voucher.getAmount();
            voucher.setAmount(0.0);
            voucher.setActive(false);
        }
        vouchers.add(voucher);
    }

    public void removeVoucher(Voucher voucher) {
        if (this.vouchers.size() > 0)
            vouchers.remove(voucher);
    }
}
