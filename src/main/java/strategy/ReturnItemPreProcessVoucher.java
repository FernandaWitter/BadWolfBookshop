package strategy;

import domain.DomainObject;
import domain.OrderItem;
import domain.Result;
import domain.Voucher;

import java.time.LocalDate;

public class ReturnItemPreProcessVoucher implements IStrategy {

    @Override
    public void process(DomainObject object, Result result) {
        OrderItem item = (OrderItem) object;
        Voucher voucher = new Voucher();
        voucher.setActive(true);
        voucher.setAmount(item.getQuantity() * item.getBook().getPrice());
        voucher.setUser(item.getUserId());
        voucher.setCreationDate(LocalDate.now());
        result.putObject(Voucher.class.getSimpleName(), voucher);
    }
}
