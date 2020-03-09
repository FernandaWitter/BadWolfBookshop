package command;

import domain.DomainObject;
import domain.Result;

public class UpdateCmd extends AbsCmd{

    public Result execute(DomainObject object) {
        return facade.update(object);
    }
}
