package strategy;

import domain.DomainObject;
import domain.Result;
import domain.Voucher;
import dto.OrderDTO;
import repository.IDAO;
import repository.VoucherDAO;

public class OrderPlacementProcessVoucher implements IStrategy {
    IDAO idao;

    public OrderPlacementProcessVoucher() {
        idao = new VoucherDAO();
    }

    @Override
    public void process(DomainObject object, Result result) {
        OrderDTO order = (OrderDTO) object;
        if (order.getAmountDue() < order.getAmountPaidByCC() + order.getAmountPaidByVoucher()) {
            double overpaid = order.getAmountPaidByCC() + order.getAmountPaidByVoucher() - order.getAmountDue();
            for (int i = order.getVouchers().size() - 1; i > -1; i--) {
                Voucher voucher = order.getVouchers().get(i);
                if (voucher.getAmount() < overpaid) {
                    overpaid -= voucher.getAmount();
                    order.removeVoucher(voucher);
                } else {
                    if (overpaid > 0) {
                        voucher.setAmount(overpaid);
                        overpaid = 0;
                    } else {
                        voucher.setActive(false);
                    }
                }
            }
        }
        if (order.getVouchers().size() > 0) {
            for (Voucher v : order.getVouchers()) {
                idao.update(v, result);
            }
        }
    }
}
