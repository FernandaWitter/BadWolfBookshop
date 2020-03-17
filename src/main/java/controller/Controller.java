package controller;

import command.*;
import domain.Book;
import domain.DomainObject;
import domain.Result;
import vh.AdminBookVH;
import vh.IViewHelper;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
//productList.jsp", "/bookRegistration.jsp
@WebServlet(name = "book", urlPatterns = {"/books/list", "/books/edit", "/books/save", "/books/new", "/books/create", "/books/update", "/books/find", "/books/delete"})
public class Controller extends HttpServlet {
    HashMap<String, IViewHelper> viewHelpers;
    HashMap<String, ICommand> commands;

    public Controller(){
        viewHelpers = new HashMap<>();
        viewHelpers.put("/badWolfBookshop/books/list", new AdminBookVH());
        viewHelpers.put("/badWolfBookshop/books/edit", new AdminBookVH());
        viewHelpers.put("/badWolfBookshop/books/new", new AdminBookVH());
        viewHelpers.put("/badWolfBookshop/books/create", new AdminBookVH());
        viewHelpers.put("/badWolfBookshop/books/update", new AdminBookVH());
        viewHelpers.put("/badWolfBookshop/books/find", new AdminBookVH());
        viewHelpers.put("/badWolfBookshop/books/delete", new AdminBookVH());

        commands = new HashMap<>();
        commands.put("create", new CreateCmd());
        commands.put("update", new UpdateCmd());
        commands.put("delete", new DeleteCmd());
        commands.put("find", new FindCmd());
        commands.put("new", new FindCmd());
        commands.put("edit", new FindCmd());
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response){
        try{
            String uri = request.getRequestURI();

            IViewHelper vh = viewHelpers.get(uri);
            String operation = null;
            if(uri.contains("update")){
                operation = "update";
            } else if(uri.contains("create")){
                operation = "create";
            } else if(uri.contains("list")){
                operation = "find";
            } else if(uri.contains("new")){
                operation = "new";
            } else if(uri.contains("edit")){
                operation = "edit";
            } else if(uri.contains("find")){
                operation = "find";
            } else if(uri.contains("delete")){
                operation = "delete";
            }
            request.setAttribute("operation", operation);
            DomainObject object = vh.getObject(request);


//            if(null == request.getAttribute("operation"))
//                operation = request.getParameter("operation");
//            else
//                operation = request.getAttribute("operation").toString();
//            if(operation == null){
//                if(uri.contains("/admin/"))
//                    operation = "find";
//                else
//                    operation = "find";
//            }

            ICommand cmd;
            Result result = new Result();
            if(!operation.equals("new")) {
                cmd = commands.get(operation);
                result = cmd.execute(object);
            }
            if(result.hasMsg("error")){
                if(operation.equals("create") || operation.equals("update")){
                    ArrayList<DomainObject> list = new ArrayList<>();
                    list.add(object);
                    result.putObject(Book.class.getSimpleName(), list);
                }
            }
            vh.setView(request, response, result);

        } catch (Exception e){
            e.printStackTrace();
        }


    }

}
