package vh;

import domain.DomainObject;
import domain.Result;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface IViewHelper {
    DomainObject getObject(HttpServletRequest request);

    void setView(HttpServletRequest request, HttpServletResponse response, Result result);
}
