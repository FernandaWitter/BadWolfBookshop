package vh;

import domain.DomainObject;
import domain.Order;
import domain.Result;
import dto.BookChartDTO;
import dto.UpdatePurchaseDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PurchaseVH implements IViewHelper {
    @Override
    public DomainObject getObject(HttpServletRequest request) {
        String operation;
        if (request.getAttribute("operation") == null) {
            if (request.getParameter("operation") == null)
                return null;
            operation = request.getParameter("operation");
        } else {
            operation = request.getAttribute("operation").toString();
        }

        if (operation.equals("editPurchase")) {
            if (isValidParameter(request.getParameter("orderId")))
                return new Order(Integer.valueOf(request.getParameter("orderId")));
        } else if (operation.equals("getChart")) {
            BookChartDTO chart = new BookChartDTO();
            if (isValidParameter(request.getParameter("fromDate")))
                chart.setStartDate(Date.valueOf(request.getParameter("fromDate")).toLocalDate());
            if (isValidParameter(request.getParameter("toDate")))
                chart.setEndDate(Date.valueOf(request.getParameter("toDate")).toLocalDate());
            return chart;
        } else if (operation.equals("updateOrder")) {
            if (isValidParameter(request.getParameter("orderId"))) {
                UpdatePurchaseDTO purchaseDTO = new UpdatePurchaseDTO();
                purchaseDTO.setOrderId(Integer.valueOf(request.getParameter("orderId")));
                if (request.getParameterValues("updatedItems[]") != null) {
                    String[] update = request.getParameterValues("updatedItems[]");
                    List<Integer> updatedItems = new ArrayList<>();
                    for (String i : update)
                        updatedItems.add(Integer.valueOf(i));
                    purchaseDTO.setUpdateItems(updatedItems);
                }
                if (request.getParameterValues("rejectedItems[]") != null) {
                    String[] reject = request.getParameterValues("rejectedItems[]");
                    List<Integer> rejectedItems = new ArrayList<>();
                    for (String i : reject)
                        rejectedItems.add(Integer.valueOf(i));
                    purchaseDTO.setRejectItems(rejectedItems);
                }
                return purchaseDTO;
            }
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
                case "dash":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/index.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/dashboard.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "orderList":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/dashboard.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/orderList.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "editPurchase":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/dashboard.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/orderDetail.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "updateOrder":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/orderDetail.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/orderList");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "getChart":
                    dispatcher = request.getRequestDispatcher("/dashboard.jsp");
                    dispatcher.forward(request, response);
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

    private boolean isValidParameter(String value) {
        return value != null && !value.equals("") && !value.equals("null");
    }
}
