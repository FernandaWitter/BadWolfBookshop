package strategy;

import domain.*;
import repository.AuthorDAO;
import repository.CategoryDAO;

public class BookCreationPreProcessCategories implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        if (result.getMsg("error") == null) {
            Book book = (Book) object;
            CategoryDAO categoryDAO = new CategoryDAO();
            // Verify if category already exists and, if not, create it
            for (Category c : book.getCategories()) {
                categoryDAO.findAll(c, result);
                // Only one category should match, or none
                if (result.getObject(Author.class.getSimpleName()).get(0) == null) {
                    categoryDAO.create(c, result);
                }
                c.setId(result.getObject(Author.class.getSimpleName()).get(0).getId());
            }
        }
    }
}
