package strategy;

import domain.DomainObject;
import domain.Result;
import domain.User;

import java.time.LocalDate;
import java.time.Period;

public class AgeValidation implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        User user = (User) object;
        LocalDate dob = user.getBirthday();
        int period = Period.between(dob, LocalDate.now()).getYears();
        if (period < 18)
            result.setMsg("error", "&Eacute; necess&aacute;rio ter pelo menos 18 anos completos para se cadastrar!");
    }
}
