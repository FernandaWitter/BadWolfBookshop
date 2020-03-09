package strategy;

import domain.*;
import repository.AuthorDAO;
import repository.CategoryDAO;

import java.util.ArrayList;

public class BookSearchPostProcessCategories implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        CategoryDAO categoryDAO = new CategoryDAO();
        Book book = (Book) object;
        categoryDAO.findById(book, result);
        ArrayList<Category> categories = new ArrayList<>();
        for(DomainObject d : result.getObject(Author.class.getSimpleName())){
            Category c = (Category)d;
            categories.add(c);
        }
    }
}
