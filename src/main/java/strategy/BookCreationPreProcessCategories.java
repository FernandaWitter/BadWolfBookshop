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
            for (int i =0; i <book.getCategories().size(); i++) {
                Category c = book.getCategories().get(i);
                categoryDAO.findAll(c, result);
                // Only one category should match, or none
                if(result.getObject(Category.class.getSimpleName()) == null)
                    categoryDAO.create(c, result);
                if (result.getObject(Category.class.getSimpleName()) != null && result.getObject(Category.class.getSimpleName()).size() > 0) {
                    c.setId(result.getObject(Category.class.getSimpleName()).get(0).getId());
                }
            }
        }
    }
}
