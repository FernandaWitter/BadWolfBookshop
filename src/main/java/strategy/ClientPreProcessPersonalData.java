package strategy;

import domain.DomainObject;
import domain.Result;
import domain.User;
import dto.ClientDTO;

public class ClientPreProcessPersonalData implements IStrategy {

    IStrategy validateFederalId;
    IStrategy validateAge;

    public ClientPreProcessPersonalData() {
        this.validateFederalId = new FederalIdValidation();
        this.validateAge = new AgeValidation();
    }

    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO client = (ClientDTO) object;
        User user = client.getUser();
        if (client.isCreate()) {
            if (user.getName() == null || user.getName().equals(""))
                result.setMsg("error", "O campo Nome &eacute; obrigat&ocaute;rio!");
            if (user.getFederalId() == null || user.getFederalId().equals(""))
                result.setMsg("error", "O campo CPF &eacute; obrigat&ocaute;rio!");
            else
                this.validateFederalId.process(user, result);
            if (user.getBirthday() == null)
                result.setMsg("error", "A data de nascimento &eacute; obrigat&ocaute;ria!");
            else
                this.validateAge.process(user, result);
            if (user.getAreaCode() == null || user.getAreaCode().equals(""))
                result.setMsg("error", "O campo DDD &eacute; obrigat&ocaute;rio!");
            else if (!isNumeric(user.getAreaCode()))
                result.setMsg("error", "O DDD n&atilde;o &eacute; v&aacute;lido!");
            if (user.getAreaCode() == null || user.getAreaCode().equals(""))
                result.setMsg("error", "O campo DDD &eacute; obrigat&ocaute;rio!");
            else if ((user.getPhone().length() != 8 && user.getPhone().length() != 9) || !isNumeric(user.getPhone()))
                result.setMsg("error", "O telefone n&atilde;o &eacute; v&aacute;lido!");
        }
    }

    private boolean isNumeric(String value) {
        try {
            value = value.trim().replace(" ", "").replace("-", "");
            Integer.valueOf(value);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
