package strategy;

import domain.DomainObject;
import domain.Result;
import repository.AddressDAO;

public class RetrieveStatesAndCountries implements IStrategy {

    AddressDAO dao;

    public RetrieveStatesAndCountries() {
        this.dao = new AddressDAO();
    }

    @Override
    public void process(DomainObject object, Result result) {
        dao.getStatesAndCountries(result);
    }
}
