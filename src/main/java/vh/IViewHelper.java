package vh;

import domain.DomainObject;
import domain.Result;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface IViewHelper {
    public DomainObject getObject(HttpServletRequest request);
    public void setView(HttpServletRequest request, HttpServletResponse response, Result result);
}
