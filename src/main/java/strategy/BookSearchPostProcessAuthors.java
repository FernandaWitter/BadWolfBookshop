package strategy;

import domain.Author;
import domain.Book;
import domain.DomainObject;
import domain.Result;
import repository.AuthorDAO;

import java.util.ArrayList;

public class BookSearchPostProcessAuthors implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        AuthorDAO authorDAO = new AuthorDAO();
        Book book = (Book) object;
        authorDAO.findById(book, result);
        ArrayList<Author> authors = new ArrayList<>();
        for(DomainObject d : result.getObject(Author.class.getSimpleName())){
            Author a = (Author)d;
            authors.add(a);
        }
    }
}
