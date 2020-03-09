package DAOTest;

import domain.*;
import repository.AuthorDAO;
import repository.BookDAO;
import repository.CategoryDAO;
import repository.PublisherDAO;

import java.util.ArrayList;
import java.util.Arrays;

public class BookRepository {

    public static void main(String[] args) {
        AuthorDAO authorDAO = new AuthorDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        PublisherDAO publisherDAO = new PublisherDAO();
        BookDAO bookDAO = new BookDAO();
        Result res = new Result();

        Author author = new Author("JK Rowling");
        authorDAO.create(author, res);
        ArrayList<Author> authors = new ArrayList<>(Arrays.asList(author));
        Category category = new Category("Fantasia");
        categoryDAO.create(category, res);
        ArrayList<Category> categories = new ArrayList<>(Arrays.asList(category));
        Image first = new Image();
        first.setPath("firstpath.png");
        Image second = new Image();
        second.setPath("secondPath");
        ArrayList<Image> images = new ArrayList<>(Arrays.asList(first, second));
        Publisher publisher = new Publisher();
        publisher.setName("Simon & Schuester");
        publisherDAO.create(publisher, res);
        Book book = new Book();
        book.setTitle("Harry Potter e a Pedra Filosofal");
        book.setPublisher(publisher);
        book.setInStock(5);
        book.setPrice(19.90);
        book.setWeight(0.8);
        book.setDepth(0.6);
        book.setWidth(14.0);
        book.setHeight(21.0);
        book.setSummary("Garoto que cresceu num lar abusivo tem que salvar o mundo que virou as costas pra ele durante dez anos");
        book.setIsbn("1234-567-5-96");
        book.setLanguage("Português");
        book.setPubEdition(25);
        book.setPubYear(2018);
        book.setAuthors(authors);
        book.setCategories(categories);
        book.setImages(images);
        bookDAO.create(book, res);
        System.out.println("Book ID: " + book.getId());
        System.out.println("ERROR: " + res.getMsg("error"));
    }

}
