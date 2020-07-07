package controller;

import command.FindCmd;
import command.ICommand;
import command.UpdateCmd;
import domain.AccessCredential;
import domain.DomainObject;
import domain.Result;
import dto.CartDTO;
import dto.LoginDTO;
import vh.IViewHelper;
import vh.LoginVH;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "login", urlPatterns = {"/login", "/logout"})
public class LoginController extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) {
        try {
            String fullUri = request.getRequestURI();
            String uri = fullUri.substring(fullUri.lastIndexOf('/') + 1);
            IViewHelper vh = new LoginVH();

            request.setAttribute("operation", uri);
            DomainObject object = vh.getObject(request);
            Result result = new Result();
            ICommand command;
            if (uri.equals("login")) {
                LoginDTO dto = (LoginDTO) object;
                AccessCredential credential = dto.getAc();
                if (credential.getUsername().equals("admin@user.com") && credential.getPassword().equals("admin123"))
                    request.setAttribute("operation", "admin");
                else {
                    command = new FindCmd();
                    result = command.execute(object);
                    if (!result.hasMsg("error")) {
                        dto = (LoginDTO) result.getObject(LoginDTO.class.getSimpleName()).get(0);
                        request.getSession().setAttribute("user", dto.getUserId());
                        if (result.hasObject(CartDTO.class.getSimpleName())) {
                            if (request.getSession().getAttribute("cart") != null) {
                                CartDTO currentCart = (CartDTO) request.getSession().getAttribute("cart");
                                currentCart.mergeCarts((CartDTO) result.getObject(CartDTO.class.getSimpleName()).get(0));
                                request.getSession().setAttribute("cart", currentCart);
                            } else {
                                request.getSession().setAttribute("cart", result.getObject(CartDTO.class.getSimpleName()).get(0));
                            }
                        }
                    }
                }
            } else if (uri.equals("logout")) {
                command = new UpdateCmd();
                if (request.getSession().getAttribute("cart") != null) {
                    int userId = (int) request.getSession().getAttribute("user");
                    LoginDTO dto = new LoginDTO();
                    dto.setUserId(userId);
                    dto.setCart((CartDTO) request.getSession().getAttribute("cart"));
                    command.execute(dto);
                }
                request.getSession().removeAttribute("user");
                request.getSession().removeAttribute("cart");
            }
            vh.setView(request, response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
