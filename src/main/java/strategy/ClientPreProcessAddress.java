package strategy;

import domain.Address;
import domain.DomainObject;
import domain.Result;
import domain.User;
import dto.ClientDTO;

public class ClientPreProcessAddress implements IStrategy {
    IStrategy verifyAddress;

    public ClientPreProcessAddress() {
        this.verifyAddress = new VerifyAddressCompletion();
    }

    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO client = (ClientDTO) object;
        User user = client.getUser();
        for (Address a : user.getAddresses()) {
            verifyAddress.process(a, result);
            if (result.hasMsg("error"))
                break;
        }
    }
}
