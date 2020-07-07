package strategy;

import domain.*;
import dto.ClientDTO;

public class ClientPreProcessCards implements IStrategy {
    IStrategy verifyCard;

    public ClientPreProcessCards() {
        this.verifyCard = new VerifyCreditCardInformation();
    }

    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO client = (ClientDTO) object;
        User user = client.getUser();
        for (CreditCard c : user.getCreditCards()) {
            verifyCard.process(c, result);
            if (result.hasMsg("error"))
                break;
        }
    }
}
