package strategy;

import domain.Address;
import domain.DomainObject;
import domain.Result;
import dto.AddressDTO;
import dto.OrderDTO;
import repository.AddressDAO;
import repository.IDAO;

public class OrderPlacementPreProcessAddress implements IStrategy {


    private IStrategy strategy;

    public OrderPlacementPreProcessAddress() {
        strategy = new VerifyAddressCompletion();
    }

    @Override
    public void process(DomainObject object, Result result) {
        OrderDTO order = (OrderDTO) object;
        if (order.getAddresses().size() == 0 && order.getNewAddresses().size() == 0)
            result.setMsg("error", "Os endere&ccedil;os de entrega e cobran&ccedil;a não podem ficar em branco!");
        else {
            boolean shipping = false, billing = false;
            for (AddressDTO address : order.getAddresses()) {
                if (address.getIsShipping() != null && address.getIsShipping())
                    shipping = true;
                if (address.getIsBilling() != null && address.getIsBilling())
                    billing = true;
            }
            for (Address address : order.getNewAddresses()) {
                if (address.getIsDelivery() != null && address.getIsDelivery())
                    shipping = true;
                if (address.getIsBilling() != null && address.getIsBilling())
                    billing = true;
                strategy.process(address, result);
            }
            if (!billing)
                result.setMsg("error", "O endere&ccedil;o de cobran&ccedil;a deve ser especificado!");
            if (!shipping)
                result.setMsg("error", "O endere&ccedil;o de entrega deve ser especificado!");
        }
    }
}
