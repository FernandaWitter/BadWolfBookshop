package strategy;

import domain.*;
import repository.AuthorDAO;

public class BookCreationPreProcessAuthors implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        if(result.getMsg("error") == null) {
            Book book = (Book) object;
            AuthorDAO authorDAO = new AuthorDAO();
            // Verify if author already exists and, if not, create it
            for (Author a : book.getAuthors()) {
                authorDAO.findAll(a, result);
                // Only one author should match, or none
                if (result.getObject(Author.class.getSimpleName()).get(0) == null) {
                    authorDAO.create(a, result);
                }
                a.setId(result.getObject(Author.class.getSimpleName()).get(0).getId());
            }
        }
    }
}
