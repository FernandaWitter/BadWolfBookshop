package vh;

import domain.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class AdminBookVH implements IViewHelper {
    @Override
    public DomainObject getObject(HttpServletRequest request) {
        Book book = new Book();
        String[] authors = null;
        String[] categories = null;
        String operation;
        if (request.getAttribute("operation") == null) {
            if (request.getParameter("operation") == null)
                return book;
            operation = request.getParameter("operation");
        } else {
            operation = request.getAttribute("operation").toString();
        }

        if (operation.equals("create") || operation.equals("update")) {
            if (operation.equals("update")) {
                if (request.getParameter("bookId") != null && !request.getParameter("bookId").equals(""))
                    book.setId(Integer.valueOf(request.getParameter("bookId")));
            }
            if (request.getParameter("bookTitle") != null && !request.getParameter("bookTitle").equals(""))
                book.setTitle(request.getParameter("bookTitle"));
            if (request.getParameter("bookAuthor") != null && !request.getParameter("bookAuthor").equals("")) {
                authors = request.getParameter("bookAuthor").split(";");
                ArrayList<Author> authorList = new ArrayList<>();
                for (String s : authors) {
                    authorList.add(new Author(s.trim()));
                }
                book.setAuthors(authorList);
            }
            if (request.getParameter("bookPublisher") != null && !request.getParameter("bookPublisher").equals(""))
                book.setPublisher(new Publisher(request.getParameter("bookPublisher")));
            if (request.getParameter("bookYear") != null && !request.getParameter("bookYear").equals(""))
                book.setPubYear(Integer.valueOf(request.getParameter("bookYear")));
            if (request.getParameter("bookEdition") != null && !request.getParameter("bookEdition").equals(""))
                book.setPubEdition(Integer.valueOf(request.getParameter("bookEdition")));
            if (request.getParameter("bookLanguage") != null && !request.getParameter("bookLanguage").equals(""))
                book.setLanguage(request.getParameter("bookLanguage"));
            if (request.getParameter("bookISBN") != null && !request.getParameter("bookISBN").equals(""))
                book.setIsbn(request.getParameter("bookISBN"));
            if (request.getParameter("bookGenres") != null && !request.getParameter("bookGenres").equals("")) {
                categories = request.getParameter("bookGenres").split(";");
                ArrayList<Category> categoryList = new ArrayList<>();
                for (String s : categories) {
                    categoryList.add(new Category(s.trim()));
                }
                book.setCategories(categoryList);
            }
            if (request.getParameter("bookSummary") != null && !request.getParameter("bookSummary").equals(""))
                book.setSummary(request.getParameter("bookSummary"));
            if (request.getParameter("bookISBN") != null && !request.getParameter("bookISBN").equals(""))
                book.setIsbn(request.getParameter("bookISBN"));
            if (request.getParameter("bookHeight") != null && !request.getParameter("bookHeight").equals(""))
                book.setHeight(Double.valueOf(request.getParameter("bookHeight")));
            if (request.getParameter("bookWidth") != null && !request.getParameter("bookWidth").equals(""))
                book.setWidth(Double.valueOf(request.getParameter("bookWidth")));
            if (request.getParameter("bookDepth") != null && !request.getParameter("bookDepth").equals(""))
                book.setDepth(Double.valueOf(request.getParameter("bookDepth")));
            if (request.getParameter("bookWeight") != null && !request.getParameter("bookWeight").equals(""))
                book.setWeight(Double.valueOf(request.getParameter("bookWeight")));
            if (request.getParameter("bookPages") != null && !request.getParameter("bookPages").equals(""))
                book.setPages(Integer.valueOf(request.getParameter("bookPages")));
            if (request.getParameter("bookPrice") != null && !request.getParameter("bookPrice").equals("")) {
                if (request.getParameter("bookNewPrice") != null && !request.getParameter("bookNewPrice").equals(""))
                    book.setPrice(Double.valueOf(request.getParameter("bookNewPrice")));
                else
                    book.setPrice(Double.valueOf(request.getParameter("bookPrice")));
            }
            if (request.getParameter("booksInStock") != null && !request.getParameter("booksInStock").equals("")) {
                int inStock = Integer.valueOf(request.getParameter("booksInStock"));
                if (request.getParameter("bookNewUnits") != null && !request.getParameter("bookNewUnits").equals("")) {
                    int newUnits = Integer.valueOf(request.getParameter("bookNewUnits"));
                    book.setInStock(inStock + newUnits);
                } else
                    book.setInStock(inStock);
            }
            if (request.getParameterValues("bookImage[]") != null) {
                String[] imagePaths = request.getParameterValues("bookImage[]");
                ArrayList<Image> images = new ArrayList<>();
                for (String s : imagePaths) {
                    if (!s.equals(""))
                        images.add(new Image(s.trim()));
                }
                book.setImages(images);
            }
        } else if (operation.equals("find")) {
            if (request.getParameter("searchbox") != null && !request.getParameter("searchbox").equals(""))
                book.setTitle(request.getParameter("searchbox"));
            else if (request.getParameter("bookId") != null && !request.getParameter("bookId").equals(""))
                book.setId(Integer.valueOf(request.getParameter("bookId")));
        } else {
            if (request.getParameter("bookId") != null && !request.getParameter("bookId").equals(""))
                book.setId(Integer.valueOf(request.getParameter("bookId")));
        }
        return book;
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
                case "create":
                    if (result.hasMsg("error")) {
                        request.setAttribute("operation", "create");
                        dispatcher = request.getRequestDispatcher("/bookRegistration.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        request.getSession().setAttribute("success", "<p stlye=\"color:#008000\">Livro salvo com sucesso!</p>");
                        response.sendRedirect("list");
                    }
                    break;
                case "update":
                    if (result.hasMsg("error")) {
                        request.setAttribute("operation", "update");
                        dispatcher = request.getRequestDispatcher("/bookRegistration.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        request.getSession().setAttribute("success", "<p stlye=\"color:#008000\">Livro editado com sucesso!</p>");
                        response.sendRedirect("list");
                    }
                    break;
                case "delete":
                    request.getSession().setAttribute("success", "<p style=\"color:#00FF00\"><strong>Livro exclu&iacute;do com sucesso!</strong></p>");
                    response.sendRedirect("list");
                    break;
                case "new":
                case "edit":
                    dispatcher = request.getRequestDispatcher("/bookRegistration.jsp");
                    dispatcher.forward(request, response);
                    break;
                default:
                    dispatcher = request.getRequestDispatcher("/productList.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
