package strategy;

import domain.*;
import repository.AuthorDAO;
import repository.PublisherDAO;

public class BookCreationPreProcessPublisher implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        if (result.getMsg("error") == null) {
            Book book = (Book) object;
            PublisherDAO publisherDAO = new PublisherDAO();
            // Verify if author already exists and, if not, create it
            publisherDAO.findAll(book.getPublisher(), result);
            // Only one publisher should match, or none
            if (result.getObject(Publisher.class.getSimpleName()) == null) {
                publisherDAO.create(book.getPublisher(), result);
            }
            book.getPublisher().setId(result.getObject(Publisher.class.getSimpleName()).get(0).getId());
        }
    }
}