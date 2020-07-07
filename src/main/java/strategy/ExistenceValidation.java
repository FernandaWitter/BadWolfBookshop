package strategy;

import domain.Book;
import domain.DomainObject;
import domain.Result;
import repository.BookDAO;
import repository.IDAO;

import java.util.HashMap;
import java.util.List;

public class ExistenceValidation implements IStrategy {

    HashMap<String, IDAO> daoMap;

    public ExistenceValidation() {
        daoMap = new HashMap<>();
        daoMap.put(Book.class.getSimpleName(), new BookDAO());
    }

    @Override
    public void process(DomainObject object, Result result) {
        IDAO dao = daoMap.get(object.getClass().getSimpleName());
        dao.findActive(object, result);
        List<DomainObject> search = result.getObject(object.getClass().getSimpleName());
        if (null != search && search.size() != 0)
            result.setMsg("error", "O item cadastrado j&aacute; existe!");
    }
}
