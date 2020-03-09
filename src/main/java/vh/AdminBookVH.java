package vh;

import domain.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class AdminBookVH implements IViewHelper{
    @Override
    public DomainObject getObject(HttpServletRequest request) {
        Book book = new Book();
        String[] authors = null;
        String[] categories = null;
            if(request.getAttribute("operation").equals("create") || request.getAttribute("operation").equals("alter")){
                if(request.getParameter("bookTitle") != null)
                    book.setTitle(request.getParameter("bookTitle"));
                if(request.getParameter("bookAuthor") != null) {
                    authors = request.getParameter("bookAuthor").split(";");
                    ArrayList<Author> authorList = new ArrayList<>();
                    for (String s : authors) {
                        authorList.add(new Author(s));
                    }
                    book.setAuthors(authorList);
                }
                if(request.getParameter("bookPublisher") != null)
                    book.setPublisher(new Publisher(request.getParameter("bookPublisher")));
                if(request.getParameter("bookYear") != null)
                    book.setPubYear(Integer.valueOf(request.getParameter("bookYear")));
                if(request.getParameter("bookAuthor") != null)
                    book.setPubEdition(Integer.valueOf(request.getParameter("bookEdition")));
                if(request.getParameter("bookLanguage") != null)
                    book.setLanguage(request.getParameter("bookLanguage"));
                if(request.getParameter("bookISBN") != null)
                    book.setIsbn(request.getParameter("bookISBN"));
                if(request.getParameter("bookGenres") != null) {
                    categories = request.getParameter("bookGenres").split(";");
                    ArrayList<Category> categoryList = new ArrayList<>();
                    for (String s : categories) {
                        categoryList.add(new Category(s));
                    }
                    book.setCategories(categoryList);
                }
                if(request.getParameter("bookSummary") != null)
                    book.setSummary(request.getParameter("bookSummary"));
                if(request.getParameter("bookISBN") != null)
                    book.setIsbn(request.getParameter("bookISBN"));
                if(request.getParameter("bookHeight") != null)
                    book.setHeight(Double.valueOf(request.getParameter("bookHeight")));
                if(request.getParameter("bookWidth") != null)
                    book.setWidth(Double.valueOf(request.getParameter("bookWidth")));
                if(request.getParameter("bookDepth") != null)
                    book.setDepth(Double.valueOf(request.getParameter("bookDepth")));
                if(request.getParameter("bookWeight") != null)
                    book.setWeight(Double.valueOf(request.getParameter("bookWeight")));
                if(request.getParameter("bookPages") != null)
                    book.setPages(Integer.valueOf(request.getParameter("bookPages")));
                if(request.getParameter("bookPrice") != null){
                    if(request.getParameter("bookNewPrice") != null)
                        book.setPrice(Double.valueOf(request.getParameter("bookNewPrice")));
                    else
                        book.setPrice(Double.valueOf(request.getParameter("bookPrice")));
                }
                if(request.getParameter("booksInStock") != null){
                    if(request.getParameter("bookNewUnits") != null)
                        book.setPrice(Double.valueOf(request.getParameter("bookNewUnits")));
                    else
                        book.setPrice(Double.valueOf(request.getParameter("booksInStock")));
                }
                if(request.getParameterValues("bookImage[]") != null){
                    String[] imagePaths = request.getParameterValues("bookImage[]");
                    ArrayList<Image> images = new ArrayList<>();
                    for(String s : imagePaths){
                        images.add(new Image(s));
                    }
                    book.setImages(images);
                }
            } else if (request.getAttribute("operation").equals("search")) {
                if(request.getParameter("searchbox") != null)
                    book.setTitle(request.getParameter("searchbox"));
            } else {
                if(request.getParameter("bookId") != null)
                    book.setId(Integer.valueOf(request.getParameter("bookId")));
            }
        return book;
    }

    @Override
    public void setView(HttpServletRequest request, HttpServletResponse response, Result result) {
        RequestDispatcher dispatcher;
        request.setAttribute("resultado", result);
        String operation;
        if(null == request.getAttribute("operation"))
            operation = request.getParameter("operation");
        else
            operation = request.getAttribute("operation").toString();
        try {
            switch(operation){
                case "create":
                    if(result.hasMsg("error")){
                        request.setAttribute("operation", "create");
                        dispatcher = request.getRequestDispatcher("/bookRegistration.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        request.setAttribute("operation", "list");
                        request.setAttribute("noFilter", "noFilter");
                        dispatcher = request.getRequestDispatcher("/book");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "update":
                    if(result.hasMsg("error")){
                        request.setAttribute("operation", "update");
                        dispatcher = request.getRequestDispatcher("/bookRegistration.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        request.setAttribute("operation", "list");
                        request.setAttribute("noFilter", "noFilter");
                        dispatcher = request.getRequestDispatcher("/book");
                        dispatcher.forward(request, response);
                    }
                    break;
//                case "register":
//                    dispatcher = request.getRequestDispatcher("/ms03/edit-boardgame.jsp");
//                    dispatcher.forward(request, response);
//                    break;
                case "delete":
                    request.setAttribute("operation", "list");
                    request.setAttribute("noFilter", "noFilter");
                    dispatcher = request.getRequestDispatcher("/book");
                    dispatcher.forward(request, response);
                    break;
                default:
                    dispatcher = request.getRequestDispatcher("/productLqist.jsp");
                    dispatcher.forward(request, response);
                    break;

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
