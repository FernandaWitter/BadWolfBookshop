package strategy;

import domain.CreditCard;
import domain.DomainObject;
import domain.Result;
import dto.CardDTO;

public class VerifyCreditCardInformation implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        CreditCard card;
        if (object.getClass().getSimpleName().equals(CardDTO.class.getSimpleName()))
            card = CardDTO.toCard((CardDTO) object);
        else
            card = (CreditCard) object;
        boolean error = false;
        if (card.getExpiration() == null || card.getExpiration().equals(""))
            error = true;
        if (card.getCardCompany().getCode() == null)
            error = true;
        if (card.getCardNumber() == null || card.getCardNumber().equals(""))
            error = true;
        if (card.getCvv() == null || card.getCvv().equals(""))
            error = true;
        if (card.getHolderName() == null || card.getHolderName().equals(""))
            error = true;
        if (error)
            result.setMsg("error", "Todos os campos obrigat&oacute;rios do cart&atilde;o de cr&eacute;dito devem estar preenchidos!");
    }
}
