package strategy;

import domain.DomainObject;
import domain.Result;
import dto.CardDTO;
import dto.OrderDTO;

public class OrderPlacementPreProcessPaymentMethod implements IStrategy {

    IStrategy strategy;

    public OrderPlacementPreProcessPaymentMethod() {
        this.strategy = new VerifyCreditCardInformation();
    }

    @Override
    public void process(DomainObject object, Result result) {
        OrderDTO order = (OrderDTO) object;
        if (order.getVouchers().size() == 0 && order.getCards().size() == 0)
            result.setMsg("error", "Pelo menos um m&eacute;todo de pagamento deve ser selecionado!");
        for (CardDTO card : order.getCards()) {
            if (card.getAmountPaid() < 10) {
                result.setMsg("error", "O valor m&iacute;nimo por cart&atilde;o &eacute; R$10,00!");
                if (card.getId() == null)
                    strategy.process(card, result);
            }
        }
    }
}
