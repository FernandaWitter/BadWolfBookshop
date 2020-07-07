package strategy;

import domain.AccessCredential;
import domain.DomainObject;
import domain.Result;
import domain.User;
import dto.ClientDTO;

import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Pattern;

public class AccessCredentialValidation implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        ClientDTO client = (ClientDTO) object;
        User user = client.getUser();
        if (user.getAccessCredential() != null) {
            AccessCredential ac = user.getAccessCredential();
            if (client.isCreate()) {
                if (ac.getUsername() == null || ac.getUsername().equals(""))
                    result.setMsg("error", "O e-mail n&atilde;o pode ficar em branco!");
                else if (!isEmailValid(ac.getUsername()))
                    result.setMsg("error", "O e-mail informado n&atilde;o &eacute; v&aacute;lido!");
            }
            if (ac.getPassword() == null || ac.getPassword().equals(""))
                result.setMsg("error", "A senha n&atilde;o pode ficar em branco!");
            else if (!isPasswordValid(ac.getPassword()))
                result.setMsg("error", "A senha informada n&atilde;o &eacute; v&aacute;lida! A senha deve conter pelo menos 8 caracteres, com pelo menos uma letra, um n&uacute;mero, e um caracter especial.");
            else if (!ac.getPassword().equals(ac.getConfirmPassword()))
                result.setMsg("error", "As senhas informadas n&atilde;o s&atilde;o iguais!");
        }
    }

    private boolean isEmailValid(String email) {
        String pattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
        return email.matches(pattern);
    }

    private boolean isPasswordValid(String password) {
        String pattern = "^(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,30}$";
        return password.matches(pattern);
    }
}
