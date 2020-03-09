package command;

import domain.DomainObject;
import domain.Result;

public interface ICommand {
    public Result execute(DomainObject object);
}
