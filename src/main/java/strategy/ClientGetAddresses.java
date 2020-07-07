package strategy;

import domain.DomainObject;
import domain.Result;
import dto.ClientDTO;
import repository.AddressDAO;

public class ClientGetAddresses implements IStrategy {
    AddressDAO dao;

    public ClientGetAddresses() {
        dao = new AddressDAO();
    }

    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO dto = (ClientDTO) object;
        dao.findActive(dto.getUser(), result);
    }
}
