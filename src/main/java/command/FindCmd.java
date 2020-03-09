package command;

import domain.DomainObject;
import domain.Result;

public class FindCmd extends AbsCmd {

    public Result execute(DomainObject object) {
        return facade.find(object);
    }

}
