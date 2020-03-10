package DAOTest;

import command.CreateCmd;
import command.DeleteCmd;
import command.FindCmd;
import command.UpdateCmd;
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
        CreateCmd createCmd = new CreateCmd();
        UpdateCmd updateCmd = new UpdateCmd();
        FindCmd findCmd = new FindCmd();
        DeleteCmd deleteCmd = new DeleteCmd();
        Result res = new Result();

        Author author = new Author("JK Rowling");
//        authorDAO.create(author, res);
        ArrayList<Author> authors = new ArrayList<>(Arrays.asList(author));
        Category category = new Category("Fantasia");
//        categoryDAO.create(category, res);
        ArrayList<Category> categories = new ArrayList<>(Arrays.asList(category));
        Image first = new Image();
        first.setPath("firstpath.png");
        Image second = new Image();
        second.setPath("secondPath");
        ArrayList<Image> images = new ArrayList<>(Arrays.asList(first, second));
        Publisher publisher = new Publisher();
        publisher.setName("Simon & Schuester");
//        publisherDAO.create(publisher, res);
        Book book = new Book();
        book.setId(7);
//        book.setTitle("Harry Potter and the Goblet of Fire");
//        book.setPublisher(publisher);
//        book.setInStock(5);
//        book.setPrice(19.90);
//        book.setWeight(0.8);
//        book.setDepth(0.6);
//        book.setWidth(14.0);
//        book.setHeight(21.0);
//        book.setSummary("Kid who grew up in an abusive home is tasked with saving the world that turned on him for 10 years");
//        book.setIsbn("0439139600");
//        book.setLanguage("English");
//        book.setPubEdition(25);
//        book.setPubYear(2018);
//        book.setAuthors(authors);
//        book.setCategories(categories);
//        book.setImages(images);
//        book.setPages(351);
//        bookDAO.create(book, res);
//        res = createCmd.execute(book);
//        res = updateCmd.execute(book);
//        res = findCmd.execute(book);
        res = deleteCmd.execute(book);
//        Book b = (Book)res.getObject(Book.class.getSimpleName()).get(0);
//        System.out.println("Book ID: " + b.getId());
//        System.out.println("Authors: " + b.getAuthors());
//        System.out.println("Categories: " + b.getCategories());
        System.out.println("ERROR: " + res.getMsg("error"));
    }

}
