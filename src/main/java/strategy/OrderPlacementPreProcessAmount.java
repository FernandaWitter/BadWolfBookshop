package strategy;

import domain.DomainObject;
import domain.Result;
import domain.Voucher;
import dto.CardDTO;
import dto.OrderDTO;
import repository.IDAO;
import repository.VoucherDAO;

public class OrderPlacementPreProcessAmount implements IStrategy {

    VoucherDAO voucherDAO;

    public OrderPlacementPreProcessAmount() {
        voucherDAO = new VoucherDAO();
    }

    @Override
    public void process(DomainObject object, Result result) {
        OrderDTO order = (OrderDTO) object;
        if (order.getAmountDue() == null)
            result.setMsg("error", "Ocorreu um erro ao calcular o valor final do pedido. Por favor tente novamente.");
        else if (order.getAmountDue() > order.getAmountPaidByCC() + order.getAmountPaidByVoucher())
            result.setMsg("error", "O valor inserido &eacute; insuficiente para a compra!");
        else if (order.getAmountDue() < order.getAmountPaidByCC() + order.getAmountPaidByVoucher()) {
            double overpaid = order.getAmountPaidByCC() + order.getAmountPaidByVoucher() - order.getAmountDue();
            if (order.getCards().size() > 0) {
                CardDTO card = order.getCards().get(order.getCards().size() - 1);
                card.setAmountPaid(card.getAmountPaid() - overpaid);
                order.setAmountPaidByCC(order.getAmountPaidByCC() - overpaid);
            }
        }
    }
}
