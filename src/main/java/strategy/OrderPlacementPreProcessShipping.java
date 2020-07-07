package strategy;

import domain.DomainObject;
import domain.Result;
import dto.OrderDTO;

public class OrderPlacementPreProcessShipping implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        OrderDTO order = (OrderDTO) object;
        if (order.getShippingCost() == null)
            result.setMsg("error", "O tipo de frete deve ser selecionado!");
    }
}
