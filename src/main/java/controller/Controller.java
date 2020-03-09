package controller;

import command.*;
import domain.DomainObject;
import domain.Result;
import vh.AdminBookVH;
import vh.IViewHelper;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

@WebServlet(name = "book", urlPatterns = {"/productList.jsp", "/bookRegistration.jsp"})
public class Controller extends HttpServlet {
    HashMap<String, IViewHelper> viewHelpers;
    HashMap<String, ICommand> commands;

    public Controller(){
        viewHelpers = new HashMap<>();
//        viewHelpers.put("/badWolfBookshop/productList.jsp", new AdminBookVH());
//        viewHelpers.put("/badWolfBookshop/bookRegistration.jsp", new AdminBookVH());

        commands = new HashMap<>();
        commands.put("create", new CreateCmd());
        commands.put("update", new UpdateCmd());
        commands.put("delete", new DeleteCmd());
        commands.put("find", new FindCmd());
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response){
        try{
            String uri = request.getRequestURI();

            IViewHelper vh = viewHelpers.get(uri);
            DomainObject object = vh.getObject(request);

            String operation;

            if(null == request.getAttribute("operation"))
                operation = request.getParameter("operation");
            else
                operation = request.getAttribute("operation").toString();
            if(operation == null){
                if(uri.contains("/admin/"))
                    operation = "find";
                else
                    operation = "find";
            }

            ICommand cmd;
            Result result;

            cmd = commands.get(operation);
            result = cmd.execute(object);

            vh.setView(request, response, result);

        } catch (Exception e){
            e.printStackTrace();
        }


    }

}
