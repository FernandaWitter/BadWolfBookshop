package strategy;

import config.Password;
import domain.AccessCredential;
import domain.DomainObject;
import domain.Result;
import dto.LoginDTO;
import repository.UserDAO;

public class LoginPreProcessData implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        LoginDTO loginDTO = (LoginDTO) object;
        AccessCredential ac = loginDTO.getAc();
        if (ac.getUsername() == null || ac.getPassword() == null) {
            result.setMsg("error", "O usu&aacute;rio n&atilde;o pode ficar em branco!");
        } else if (ac.getUsername().equals("") || ac.getPassword().equals("")) {
            result.setMsg("error", "A senha n&atilde;o pode ficar em branco!");
        } else {
            UserDAO dao = new UserDAO();
            dao.getPw(object, result);
            if (!result.hasObject(LoginDTO.class.getSimpleName()))
                result.setMsg("error", "O usu&aacute;rio informado n&atilde;o existe!");
            else {
                loginDTO = (LoginDTO) result.getObject(LoginDTO.class.getSimpleName()).get(0);
                ac = loginDTO.getAc();
                if (ac.getPwHash() == null)
                    result.setMsg("error", "O usu&aacute;rio informado n&atilde;o existe!");
                else {
                    try {
                        if (!Password.check(ac.getPassword(), ac.getPwHash()))
                            result.setMsg("error", "A senha informada n&atilde;o &eacute; v&aacute;lida!");
                    } catch (Exception e) {
                        result.setMsg("error", "Ocorreu um erro durante a valida&ccedil;&atilde;o da senha. Tente novamente ou entre em contato com o adminsitrador.");
                    }
                }
            }
        }
    }
}
