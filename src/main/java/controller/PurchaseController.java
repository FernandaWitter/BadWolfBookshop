package controller;

import command.FindCmd;
import command.ICommand;
import command.UpdateCmd;
import domain.*;
import dto.BookChartDTO;
import dto.ReturnChartDTO;
import repository.OrderItemDAO;
import vh.IViewHelper;
import vh.PurchaseVH;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

@WebServlet(name = "purchase", urlPatterns = {"/dash", "/orderList", "/editPurchase", "/updateOrder", "/getChart"})
public class PurchaseController extends HttpServlet {
    HashMap<String, IViewHelper> viewHelpers;
    HashMap<String, ICommand> commands;

    public PurchaseController() {
        viewHelpers = new HashMap<>();
        viewHelpers.put("dash", new PurchaseVH());
        viewHelpers.put("orderList", new PurchaseVH());
        viewHelpers.put("editPurchase", new PurchaseVH());
        viewHelpers.put("updateOrder", new PurchaseVH());
        viewHelpers.put("getChart", new PurchaseVH());

        commands = new HashMap<>();
        commands.put("dash", new FindCmd());
        commands.put("orderList", new FindCmd());
        commands.put("editPurchase", new FindCmd());
        commands.put("updateOrder", new UpdateCmd());
        commands.put("getChart", new FindCmd());
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) {

        try {
            String fullUri = request.getRequestURI();
            String uri = fullUri.substring(fullUri.lastIndexOf('/') + 1);
            IViewHelper vh;
            String operation = null;

            vh = viewHelpers.get(uri);
            operation = uri;

            request.setAttribute("operation", operation);
            DomainObject object = vh.getObject(request);
            ICommand cmd;
            Result result;
            cmd = commands.get(operation);
            if (object == null)
                result = cmd.execute(new Order());
            else if (operation.equals("editPurchase")) {
                result = cmd.execute(object);
                Order order = (Order) result.getObject(Order.class.getSimpleName()).get(0);
                OrderItemDAO itemDAO = new OrderItemDAO();
                itemDAO.getPurchaseItems(order, result);
                result.removeObject(Order.class.getSimpleName());
                result.putObject(Order.class.getSimpleName(), order);
            } else {
                result = cmd.execute(object);
            }
            if (uri.equals("dash")) {
                Result chart = cmd.execute(new BookChartDTO());
                result.putObject(BookChartDTO.class.getSimpleName(), chart.getObject(BookChartDTO.class.getSimpleName()));
                result.putObject(ReturnChartDTO.class.getSimpleName(), chart.getObject(ReturnChartDTO.class.getSimpleName()));
            } else if (uri.equals("getChart")) {
                Result orders = cmd.execute(new Order());
                result.putObject(Order.class.getSimpleName(), orders.getObject(Order.class.getSimpleName()));
            }

            vh.setView(request, response, result);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
