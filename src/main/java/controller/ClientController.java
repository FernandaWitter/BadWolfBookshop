package controller;

import command.*;
import domain.Result;
import dto.ClientDTO;
import vh.ClientVH;
import vh.IViewHelper;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

@WebServlet(name = "client", urlPatterns = {"/profile", "/credentials", "/address", "/cards",
        "/alterCards", "/alterAddress", "/alterProfile", "/deleteAccount", "/alterPW", "/register", "/signup"})
public class ClientController extends HttpServlet {
    IViewHelper vh;
    HashMap<String, ICommand> commands;

    public ClientController() {
        vh = new ClientVH();

        commands = new HashMap<>();
        commands.put("create", new CreateCmd());
        commands.put("update", new UpdateCmd());
        commands.put("delete", new DeleteCmd());
        commands.put("find", new FindCmd());
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) {
        try {
            String fullUri = request.getRequestURI();
            String uri = fullUri.substring(fullUri.lastIndexOf('/') + 1);
            request.setAttribute("operation", uri);
            ClientDTO user = (ClientDTO) vh.getObject(request);
            String operation = "find";
            if (uri.equals("register"))
                operation = "create";
            else if (uri.contains("alter"))
                operation = "update";
            else if (uri.equals("deleteAccount"))
                operation = "delete";

            if (uri.equals("alterProfile"))
                user.setUpdateBasicData(true);

            ICommand cmd = commands.get(operation);
            Result result = cmd.execute(user);
            if (result.hasMsg("error"))
                result.putObject(ClientDTO.class.getSimpleName(), user);
            vh.setView(request, response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
