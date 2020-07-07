package repository;

import domain.DomainObject;
import domain.Result;

public interface IDAO {
    void create(DomainObject object, Result result);

    void update(DomainObject object, Result result);

    void delete(DomainObject object, Result result);

    void findAll(DomainObject object, Result result);

    void findActive(DomainObject object, Result result);
}
