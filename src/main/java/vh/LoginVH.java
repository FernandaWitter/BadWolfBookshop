package vh;

import domain.AccessCredential;
import domain.DomainObject;
import domain.Result;
import dto.LoginDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginVH implements IViewHelper {
    @Override
    public DomainObject getObject(HttpServletRequest request) {
        LoginDTO dto = new LoginDTO();
        String operation;
        if (request.getAttribute("operation") == null) {
            if (request.getParameter("operation") == null)
                return dto;
            operation = request.getParameter("operation");
        } else {
            operation = request.getAttribute("operation").toString();
        }

        if(operation.equals("login")){
            AccessCredential accessCredential = new AccessCredential();
            String username = "", password = "";
            if(request.getParameter("email") != null) {
                username = request.getParameter("email");
            }
            if(request.getParameter("password") != null){
                password = request.getParameter("password");
            }
            accessCredential.setUsername(username);
            accessCredential.setPassword(password);
            dto.setAc(accessCredential);
            return dto;
        }
        return null;
    }

    @Override
    public void setView(HttpServletRequest request, HttpServletResponse response, Result result) {
        RequestDispatcher dispatcher;
        request.setAttribute("result", result);
        String operation = "";
        if (request.getAttribute("operation") == null)
            operation = request.getParameter("operation");
        else
            operation = request.getAttribute("operation").toString();
        try {
            switch (operation) {
                case "login":
                    if (result.hasMsg("error")) {
                        dispatcher = request.getRequestDispatcher("login.jsp");
                        dispatcher.forward(request, response);
                    } else if(request.getSession().getAttribute("last") != null){
                        String last = request.getSession().getAttribute("last").toString();
                        request.getSession().removeAttribute("last");
                        if(last.equals("cart")){
                            response.sendRedirect("/badWolfBookshop/cart.jsp");
                        }
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    break;
                case "admin":
                    response.sendRedirect("/badWolfBookshop/dash");
                    break;
                case "logout":
                    response.sendRedirect("index.jsp");
                    break;
                default:
                    dispatcher = request.getRequestDispatcher("/home.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
