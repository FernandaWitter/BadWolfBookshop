package strategy;

import domain.CreditCard;
import domain.DomainObject;
import domain.Result;
import dto.ClientDTO;
import repository.CreditCardDAO;
import repository.IDAO;

public class ClientPostProcessCards implements IStrategy {

    IDAO cardDao;

    public ClientPostProcessCards() {
        cardDao = new CreditCardDAO();
    }

    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO client = (ClientDTO) object;
        if (client.getUser().getCreditCards().size() > 0)
            cardDao.delete(client.getUser(), result);
        for (CreditCard card : client.getUser().getCreditCards()) {
            card.setUser(client.getUser().getId());
            if (client.isCreate())
                cardDao.create(card, result);
            else {
                if (card.getId() != null)
                    cardDao.update(card, result);
                else
                    cardDao.create(card, result);
            }
        }
    }
}
