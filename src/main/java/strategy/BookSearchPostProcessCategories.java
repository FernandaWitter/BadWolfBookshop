package strategy;

import domain.*;
import repository.AuthorDAO;
import repository.BookDAO;
import repository.CategoryDAO;

import java.util.ArrayList;

public class BookSearchPostProcessCategories implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        CategoryDAO categoryDAO = new CategoryDAO();
        BookDAO bookDAO = new BookDAO();
        Book book = (Book) object;
        bookDAO.findCategories(book, result);
        ArrayList<Category> categories = new ArrayList<>();
        for(DomainObject d : result.getObject(Category.class.getSimpleName())) {
            categoryDAO.findById(d, result);
            Category c = (Category) result.getObject(Category.class.getSimpleName()).get(0);
            result.removeObject(Category.class.getSimpleName());
            categories.add(c);
        }
        book.setCategories(categories);
    }
}
