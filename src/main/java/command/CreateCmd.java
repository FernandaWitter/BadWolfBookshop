package command;

import domain.DomainObject;
import domain.Result;

public class CreateCmd extends AbsCmd {

    public Result execute(DomainObject object) {
        return facade.create(object);
    }
}
