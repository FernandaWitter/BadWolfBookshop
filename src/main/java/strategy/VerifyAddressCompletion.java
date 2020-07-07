package strategy;

import domain.Address;
import domain.DomainObject;
import domain.Result;
import domain.State;

public class VerifyAddressCompletion implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        Address address = (Address) object;
        boolean error = false;
        if (address.getNickname() == null || address.getNickname() == "")
            error = true;
        if (address.getPlace() == null || address.getPlace().equals(""))
            error = true;
        if (address.getNumber() == null || address.getNumber().equals(""))
            error = true;
        if (address.getNeighborhood() == null || address.getNeighborhood().equals(""))
            error = true;
        if (address.getZipCode() == null || address.getZipCode().equals(""))
            error = true;
        if (address.getCity() == null || address.getCity().equals(""))
            error = true;
        if (address.getState() == null || address.getState().getCode() == null) {
            error = true;
        }
        if (address.getCountry() == null || address.getCountry().getCode() == null)
            error = true;
        if (error)
            result.setMsg("error", "Todos os campos obrigat&oacute;rios do endere&ccedil;o devem estar preenchidos!");
    }
}
