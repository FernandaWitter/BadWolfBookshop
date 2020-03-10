package strategy;

import domain.Author;
import domain.Book;
import domain.DomainObject;
import domain.Result;
import repository.AuthorDAO;
import repository.BookDAO;

import java.util.ArrayList;

public class BookSearchPostProcessAuthors implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        AuthorDAO authorDAO = new AuthorDAO();
        BookDAO bookDAO = new BookDAO();
        Book book = (Book) object;
        bookDAO.findAuthors(book, result);
        ArrayList<Author> authors = new ArrayList<>();
        for(DomainObject d : result.getObject(Author.class.getSimpleName())) {
            authorDAO.findById(d, result);
            Author a = (Author) result.getObject(Author.class.getSimpleName()).get(0);
            result.removeObject(Author.class.getSimpleName());
            authors.add(a);
        }
        book.setAuthors(authors);
    }
}
