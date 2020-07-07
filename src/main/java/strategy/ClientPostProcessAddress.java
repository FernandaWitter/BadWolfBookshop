package strategy;

import domain.Address;
import domain.DomainObject;
import domain.Result;
import dto.ClientDTO;
import repository.AddressDAO;
import repository.IDAO;

public class ClientPostProcessAddress implements IStrategy {

    IDAO addressDAO;

    public ClientPostProcessAddress() {
        this.addressDAO = new AddressDAO();
    }

    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO client = (ClientDTO) object;
        if (client.getUser().getAddresses().size() > 0)
            addressDAO.delete(client.getUser(), result);
        for (Address a : client.getUser().getAddresses()) {
            a.setUser(client.getUser().getId());
            if (client.isCreate())
                addressDAO.create(a, result);
            else {
                if (a.getId() != null)
                    addressDAO.update(a, result);
                else
                    addressDAO.create(a, result);
            }
        }
    }
}
