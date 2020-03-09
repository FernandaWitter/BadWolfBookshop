package strategy;

import domain.DomainObject;
import domain.Result;

public interface IStrategy {
    public void process(DomainObject object, Result result);
}
