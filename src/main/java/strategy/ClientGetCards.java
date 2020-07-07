package strategy;

import domain.DomainObject;
import domain.Result;
import dto.ClientDTO;
import repository.AddressDAO;
import repository.CreditCardDAO;

public class ClientGetCards implements IStrategy {
    CreditCardDAO dao;

    public ClientGetCards() {
        dao = new CreditCardDAO();
    }

    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO dto = (ClientDTO) object;
        dao.findActive(dto.getUser(), result);
    }
}
