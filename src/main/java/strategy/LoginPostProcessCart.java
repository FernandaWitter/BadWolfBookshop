package strategy;

import domain.DomainObject;
import domain.Result;
import repository.CartDAO;
import repository.IDAO;

public class LoginPostProcessCart implements IStrategy {

    IDAO idao;

    public LoginPostProcessCart() {
        this.idao = new CartDAO();
    }

    @Override
    public void process(DomainObject object, Result result) {
        idao.findAll(object, result);
    }
}
