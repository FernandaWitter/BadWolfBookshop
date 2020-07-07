package strategy;

import domain.DomainObject;
import domain.Result;

public interface IStrategy {
    void process(DomainObject object, Result result);
}
