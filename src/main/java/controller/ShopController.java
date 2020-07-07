package controller;

import command.*;
import domain.*;
import dto.CartDTO;
import dto.CartItemDTO;
import dto.OrderDTO;
import dto.UserDTO;
import vh.IViewHelper;
import vh.ShopVH;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "shop", urlPatterns = {"/index.jsp", "/book/*", "/order", "/history",
        "/requestReturn", "/vouchers", "/search"})
public class ShopController extends HttpServlet {
    HashMap<String, ICommand> commands;
    ShopVH vh;

    public ShopController() {
        vh = new ShopVH();

        commands = new HashMap<>();
        commands.put("create", new CreateCmd());
        commands.put("order", new CreateCmd());
        commands.put("update", new UpdateCmd());
        commands.put("delete", new DeleteCmd());
        commands.put("find", new FindCmd());
        commands.put("new", new FindCmd());
        commands.put("edit", new FindCmd());
        commands.put("detail", new FindCmd());
        commands.put("search", new FindCmd());
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) {
        try {
            String fullUri = request.getRequestURI();
            String uri = fullUri.substring(fullUri.lastIndexOf('/') + 1);
            String operation = null;
            if (uri.equals("")) {
                operation = "find";
            } else if (fullUri.contains("search")) {
                operation = "search";
            } else if (_isNumber(uri)) {
                request.setAttribute("bookId", uri);
                operation = "detail";
            } else if (uri.equals("addToCart") || uri.equals("updateQty") || uri.equals("remove")) {
                operation = uri;
            } else {
                operation = uri;
            }

            if (uri.contains("index") || uri.contains("cart")) {
                operation = "find";
            }

            request.setAttribute("operation", operation);
            DomainObject object = vh.getObject(request);
            ICommand cmd;
            CartDTO newCart = new CartDTO();
            Result result = new Result();
            if (operation.equals("conclude")) {
                if (request.getAttribute("result") != null)
                    result = (Result) request.getAttribute("result");
                UserDTO user = (UserDTO) object;
                if (user == null) {
                    result.setMsg("error", "not logged");
                } else {
                    cmd = commands.get("find");
                    result = cmd.execute(user);
                }
            } else if (uri.equals("cart")) {
                cmd = commands.get(operation);
                CartDTO cart = (CartDTO) object;
                for (CartItemDTO item : cart.getCartItems()) {
                    Result res = cmd.execute(new Book(item.getBookId()));
                    if (res.getObject(Book.class.getSimpleName()) != null && res.getObject(Book.class.getSimpleName()).size() > 0) {
                        CartItemDTO cartItem = CartItemDTO.from((Book) res.getObject(Book.class.getSimpleName()).get(0));
                        cartItem.setQuantity(item.getQuantity());
                        newCart.addItem(cartItem);
                    }
                }
            } else if (operation.equals("history")) {
                cmd = commands.get("find");
                Order order = new Order();
                User user = new User(object.getId());
                order.setUser(user);
                result = cmd.execute(order);
            } else if (operation.equals("return")) {
                cmd = commands.get("find");
                result = cmd.execute(object);
            } else if (operation.equals("requestReturn")) {
                cmd = commands.get("update");
                result = cmd.execute(object);
            } else if (operation.equals("vouchers")) {
                UserDTO user = (UserDTO) object;
                Voucher voucher = new Voucher();
                voucher.setUser(user.getId());
                cmd = commands.get("find");
                result = cmd.execute(voucher);
            } else {
                if (!operation.equals("new") && !operation.equals("addToCart") && !operation.equals("updateQty") && !operation.equals("remove")) {
                    cmd = commands.get(operation);
                    result = cmd.execute(object);
                }
            }

            if (result.hasMsg("error")) {
                if (operation.equals("create") || operation.equals("update")) {
                    ArrayList<DomainObject> list = new ArrayList<>();
                    list.add(object);
                    result.putObject(Book.class.getSimpleName(), list);
                } else if (operation.equals("order")) {
                    request.getSession().setAttribute(OrderDTO.class.getSimpleName(), object);
                }
            }
            if (uri.equals("addToCart")) {
                request.setAttribute("cartItem", object);
            } else if (uri.equals("cart")) {
                request.setAttribute("cart", newCart);
            } else if (operation.equals("updateQty") || operation.equals("remove")) {
                if (object != null)
                    request.setAttribute("cart", object);
            }
            vh.setView(request, response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean _isNumber(String test) {
        if (test == null)
            return false;
        if (test.equals(""))
            return false;
        try {
            int i = Integer.valueOf(test);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
