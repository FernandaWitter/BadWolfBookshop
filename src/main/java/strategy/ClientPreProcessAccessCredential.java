package strategy;

import config.Password;
import domain.DomainObject;
import domain.Result;
import dto.ClientDTO;

public class ClientPreProcessAccessCredential implements IStrategy {

    IStrategy validateAccessCredentials;

    public ClientPreProcessAccessCredential() {
        this.validateAccessCredentials = new AccessCredentialValidation();
    }

    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO client = (ClientDTO) object;
        if (client.isCreate() || client.getUser().getAccessCredential() != null) {
            this.validateAccessCredentials.process(client, result);
            if (!result.hasMsg("error")) {
                try {
                    client.getUser().getAccessCredential().setPwHash(Password.getSaltedHash(client.getUser().getAccessCredential().getPassword()));
                } catch (Exception e) {
                    result.setMsg("error", "Ocorreu um erro durante o processamento. N&atilde;o foi poss&iacute;vel realizar a opera&cceidl;&atilde;o.");
                }
            }
        }
    }
}
