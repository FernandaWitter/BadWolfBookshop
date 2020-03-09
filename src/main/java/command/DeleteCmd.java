package command;

import domain.DomainObject;
import domain.Result;

public class DeleteCmd extends AbsCmd {

    public Result execute(DomainObject object) {
        return facade.delete(object);
    }
}

