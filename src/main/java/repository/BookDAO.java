package repository;

import config.DBConnection;
import domain.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class BookDAO implements IDAO {
    private final String bookTable = "books";
    private final String bookIdColumn = "bks_id";
    private final String titleColumn = "bks_title";
    private final String publisherIdColumn = "bks_pub_id";
    private final String publishingYearColumn = "bks_pub_year";
    private final String editionColumn = "bks_pub_edition";
    private final String languageColumn = "bks_language";
    private final String isbnColumn = "bks_isbn";
    private final String summaryColumn = "bks_summary";
    private final String heightColumn = "bks_height";
    private final String widthColumn = "bks_width";
    private final String depthColumn = "bks_depth";
    private final String weightColumn = "bks_weight";
    private final String priceColumn = "bks_price";
    private final String inStockColumn = "bks_inStock";
    private final String pagesColumn = "bks_pages";
    private final String isActiveColumn = "bks_is_active";
    private final String bookFields = titleColumn + ", " + publisherIdColumn + ", " + publishingYearColumn + ", " +
            editionColumn + ", " + languageColumn + "," + isbnColumn + ", " + summaryColumn + ", " + heightColumn + ", " +
            widthColumn + ", " + depthColumn + ", " + weightColumn + ", " + priceColumn + ", " + inStockColumn + ", "+
            pagesColumn + ", " + isActiveColumn;

    // Book-Author Relational Table
    private final String booksAuthorsTable = "book_authors";
    private final String booksAuthorsBookColumn = "bka_bks_id";
    private final String booksAuthorsAuthorColumn = "bka_aut_id";

    // Book-Category Relational Table
    private final String booksCategoriesTable = "book_categories";
    private final String bookCategoriesBookId = "bkc_bks_id";
    private final String booksCategoriesCategoryId = "bkc_cat_id";

    // Publisher table to avoid having to make another query just to find the name later
    // For use only in find method
    private final String publisherTable = "publishers";
    private final String publisherName = "pub_name";
    private final String publisherId = "pub_id";

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book) object;
                String bookSql = "INSERT INTO " + bookTable + "(" + bookFields + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, true)";
                PreparedStatement pstm = conn.prepareStatement(bookSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setString(1, book.getTitle());
                pstm.setInt(2, book.getPublisher().getId());
                pstm.setInt(3, book.getPubYear());
                pstm.setInt(4, book.getPubEdition());
                pstm.setString(5, book.getLanguage());
                pstm.setString(6, book.getIsbn());
                pstm.setString(7, book.getSummary());
                pstm.setDouble(8, book.getHeight());
                pstm.setDouble(9, book.getWidth());
                pstm.setDouble(10, book.getDepth());
                pstm.setDouble(11, book.getWeight());
                pstm.setDouble(12, book.getPrice());
                pstm.setInt(13, book.getInStock());
                pstm.setInt(14, book.getPages());

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                int bookId = 0;
                if (rs.next()) {
                    bookId = rs.getInt(bookIdColumn);
                    book.setId(bookId);
                } else {
                    result.setMsg("error", "The Book entry could not be created");
                }

                // Store images
                BookImageDAO imageDAO = new BookImageDAO();
                for(Image i : book.getImages()){
                    i.setBook(bookId);
                    imageDAO.create(i, result);
                }

                // Associate Authors
                for (Author a : book.getAuthors()) {
                    String authorsSql = "INSERT INTO " + booksAuthorsTable + "(" + booksAuthorsBookColumn + ", " +
                            booksAuthorsAuthorColumn + ") VALUES (?, ?)";
                    pstm = conn.prepareStatement(authorsSql);

                    pstm.setInt(1, bookId);
                    pstm.setInt(2, a.getId());
                    pstm.executeUpdate();
                }

                // Associate Categories
                for (Category c : book.getCategories()){
                    String authorsSql = "INSERT INTO " + booksCategoriesTable + "(" + bookCategoriesBookId + ", " +
                            booksCategoriesCategoryId + ") VALUES (?, ?)";
                    pstm = conn.prepareStatement(authorsSql);

                    pstm.setInt(1, bookId);
                    pstm.setInt(2, c.getId());
                    pstm.executeUpdate();
                }

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void update(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book) object;
                String bookSql = "UPDATE " + bookTable + " SET " + titleColumn + "=?, " + publisherIdColumn + "=?, " +
                        publishingYearColumn + "=?, " + editionColumn + "=?, " + languageColumn + "=?," + isbnColumn + "=?, " +
                        summaryColumn + "=?, " + heightColumn + "=?, " + widthColumn + "=?, " + depthColumn + "=?, " +
                        weightColumn + "=?, " + priceColumn + "=?, " + inStockColumn + "=?, " + pagesColumn +
                        "=? WHERE " + bookIdColumn + "=?;";
                PreparedStatement pstm = conn.prepareStatement(bookSql);

                pstm.setString(1, book.getTitle());
                pstm.setInt(2, book.getPublisher().getId());
                pstm.setInt(3, book.getPubYear());
                pstm.setInt(4, book.getPubEdition());
                pstm.setString(5, book.getLanguage());
                pstm.setString(6, book.getIsbn());
                pstm.setString(7, book.getSummary());
                pstm.setDouble(8, book.getHeight());
                pstm.setDouble(9, book.getWidth());
                pstm.setDouble(10, book.getDepth());
                pstm.setDouble(11, book.getWeight());
                pstm.setDouble(12, book.getPrice());
                pstm.setInt(13, book.getInStock());
                pstm.setInt(14, book.getPages());
                pstm.setInt(15, book.getId());

                pstm.executeUpdate();

                BookImageDAO imageDAO = new BookImageDAO();
                imageDAO.findActive(book, result);

                // To diminish processing expenditure, delete all old images and save current ones as new
                if(result.getObject(Image.class.getSimpleName()) != null) {
                    ArrayList<DomainObject> oldImages = result.getObject(Image.class.getSimpleName());
                    for (DomainObject d : oldImages) {
                        imageDAO.delete(d, result);
                    }
                }
                for(Image i : book.getImages()){
                    i.setBook(book.getId());
                    imageDAO.create(i, result);
                }

                // Similarly, book-author associations are deleted and re-created
                String deleteAuthorSql = "DELETE FROM " + booksAuthorsTable + " WHERE " + booksAuthorsBookColumn + " = ?;";
                pstm = conn.prepareStatement(deleteAuthorSql);
                pstm.setInt(1, book.getId());
                pstm.execute();

                for (Author a : book.getAuthors()) {
                    String authorsSql = "INSERT INTO " + booksAuthorsTable + "(" + booksAuthorsBookColumn + ", " +
                            booksAuthorsAuthorColumn + ") VALUES (?, ?)";
                    pstm = conn.prepareStatement(authorsSql);

                    pstm.setInt(1, book.getId());
                    pstm.setInt(2, a.getId());
                    pstm.executeUpdate();
                }

                // Similarly, book-category associations are deleted and re-created
                String deleteCategorySql = "DELETE FROM " + booksCategoriesTable + " WHERE " + bookCategoriesBookId + " = ?;";
                pstm = conn.prepareStatement(deleteCategorySql);
                pstm.setInt(1, book.getId());
                pstm.execute();

                for (Category c : book.getCategories()){
                    String authorsSql = "INSERT INTO " + booksCategoriesTable + "(" + bookCategoriesBookId + ", " +
                            booksCategoriesCategoryId + ") VALUES (?, ?)";
                    pstm = conn.prepareStatement(authorsSql);

                    pstm.setInt(1, book.getId());
                    pstm.setInt(2, c.getId());
                    pstm.executeUpdate();
                }

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void delete(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if(conn == null)
            result.setMsg("error", "Connection Error");
        else {
            try{
                Book book = (Book)object;
                String sql = "UPDATE "+ bookTable + " SET " + isActiveColumn +" = false WHERE " + bookIdColumn +"= ?";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, book.getId());

                pstm.execute();
            } catch (Exception e){
                result.setMsg("error", e.getMessage());
            }
        }

    }

    @Override
    public void findAll(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if(conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book)object;

                // find matching authors
                String findAuthorsSql = "SELECT " + booksAuthorsBookColumn + " FROM " + booksAuthorsTable + " WHERE " +
                        getAuthorsFilter(book);
                PreparedStatement pstm = conn.prepareStatement(findAuthorsSql);
                ResultSet rs = pstm.executeQuery();
                ArrayList<Integer> authors = new ArrayList<>();
                while(rs.next()){
                    authors.add(new Integer(rs.getInt(booksAuthorsBookColumn)));
                }

                // find matching categories
//                String findCategoreisSql = "SELECT " + bookCategoriesBookId + " FROM " + booksCategoriesTable + " WHERE " + getCategoryFilter();
//                pstm = conn.prepareStatement(findCategoreisSql);
//                rs = pstm.executeQuery();
                ArrayList<Integer> categories = new ArrayList<>();
//                while(rs.next()){
//                    categories.add(new Integer(rs.getInt(bookCategoriesBookId)));
//                }

                String bookSql = "SELECT ("+ bookFields + ", "+ publisherName +")  FROM " + bookTable +
                        " INNER JOIN "+ publisherTable + " ON " + publisherId + "=" + publisherIdColumn +
                        " WHERE " + getBookFilters(book, authors, categories);
                pstm = conn.prepareStatement(bookSql);

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                rs = pstm.executeQuery();
                while (rs.next()) {
                    Book b = new Book();
                    b.setId(rs.getInt(bookIdColumn));
                    b.setTitle(rs.getString(titleColumn));
                    b.setPubYear(rs.getInt(publishingYearColumn));
                    b.setPubEdition(rs.getInt(editionColumn));
                    b.setLanguage(rs.getString(languageColumn));
                    b.setIsbn(rs.getString(isbnColumn));
                    b.setSummary(rs.getString(summaryColumn));
                    b.setHeight(rs.getDouble(heightColumn));
                    b.setWidth(rs.getDouble(widthColumn));
                    b.setDepth(rs.getDouble(depthColumn));
                    b.setWeight(rs.getDouble(weightColumn));
                    b.setPrice(rs.getDouble(priceColumn));
                    b.setInStock(rs.getInt(inStockColumn));
                    b.setPages((rs.getInt(pagesColumn)));

                    Publisher p = new Publisher();
                    p.setName(rs.getString(publisherName));
                    p.setId(rs.getInt(publisherIdColumn));
                    b.setPublisher(p);

                    searchResult.add(b);
                }

                // Return Author codes
                for(DomainObject d : searchResult) {
                    Book b = (Book)d;
                    String findAuthors = "SELECT " + booksAuthorsAuthorColumn + " FROM " + booksAuthorsTable +
                            " WHERE " + booksAuthorsBookColumn + "=" +b.getId() + ";";
                    pstm = conn.prepareStatement(findAuthors);
                    rs = pstm.executeQuery();
                    ArrayList<Author> bookAuthors = new ArrayList<>();
                    while(rs.next()){
                        Author a = new Author();
                        a.setId(rs.getInt(booksAuthorsAuthorColumn));
                        bookAuthors.add(a);
                    }
                    b.setAuthors(bookAuthors);
                }

                // Return Category codes
                for(DomainObject d : searchResult) {
                    Book b = (Book)d;
                    String findCategory = "SELECT " + booksCategoriesCategoryId + " FROM " + booksCategoriesTable +
                            " WHERE " + bookCategoriesBookId + "=" + b.getId() + ";";
                    pstm = conn.prepareStatement(findCategory);
                    rs = pstm.executeQuery();
                    ArrayList<Category> bookCategories = new ArrayList<>();
                    while(rs.next()){
                        Category c = new Category();
                        c.setId(rs.getInt(booksAuthorsAuthorColumn));
                        bookCategories.add(c);
                    }
                    b.setCategories(bookCategories);
                }

                result.putObject(Author.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void findActive(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if(conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book)object;
                PreparedStatement pstm;
                ResultSet rs;
                // find matching authors
                String authorFilters =  getAuthorsFilter(book);
                ArrayList<Integer> authors = new ArrayList<>();
                if(authorFilters != null && !authorFilters.equals("")) {
                    String findAuthorsSql = "SELECT " + booksAuthorsBookColumn + " FROM " + booksAuthorsTable + authorFilters;
                    pstm = conn.prepareStatement(findAuthorsSql);
                    rs = pstm.executeQuery();
                    while (rs.next()) {
                        authors.add(new Integer(rs.getInt(booksAuthorsBookColumn)));
                    }
                }
                // find matching categories
//                String findCategoreisSql = "SELECT " + bookCategoriesBookId + " FROM " + booksCategoriesTable + " WHERE " + getCategoryFilter();
//                pstm = conn.prepareStatement(findCategoreisSql);
//                rs = pstm.executeQuery();
                ArrayList<Integer> categories = new ArrayList<>();
//                while(rs.next()){
//                    categories.add(new Integer(rs.getInt(bookCategoriesBookId)));
//                }

                String bookSql =  "SELECT "+ bookFields + ", "+ publisherName + "," + bookIdColumn + " FROM " + bookTable +
                        " INNER JOIN "+ publisherTable + " ON " + publisherId + "=" + publisherIdColumn +
                        " WHERE " + isActiveColumn + " = true";
                String filters = getBookFilters(book, authors, categories);
                if(filters != null && !filters.equals(""))
                    bookSql += " AND " + filters;
                bookSql += ";";
                pstm = conn.prepareStatement(bookSql);

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                rs = pstm.executeQuery();
                while (rs.next()) {
                    Book b = new Book();
                    b.setId(rs.getInt(bookIdColumn));
                    b.setTitle(rs.getString(titleColumn));
                    b.setPubYear(rs.getInt(publishingYearColumn));
                    b.setPubEdition(rs.getInt(editionColumn));
                    b.setLanguage(rs.getString(languageColumn));
                    b.setIsbn(rs.getString(isbnColumn));
                    b.setSummary(rs.getString(summaryColumn));
                    b.setHeight(rs.getDouble(heightColumn));
                    b.setWidth(rs.getDouble(widthColumn));
                    b.setDepth(rs.getDouble(depthColumn));
                    b.setWeight(rs.getDouble(weightColumn));
                    b.setPrice(rs.getDouble(priceColumn));
                    b.setInStock(rs.getInt(inStockColumn));
                    b.setPages((rs.getInt(pagesColumn)));

                    Publisher p = new Publisher();
                    p.setName(rs.getString(publisherName));
                    p.setId(rs.getInt(publisherIdColumn));
                    b.setPublisher(p);

                    searchResult.add(b);
                }

                // Recover Images
                BookImageDAO imageDAO = new BookImageDAO();
                for(DomainObject d : searchResult){
                    Book b = (Book)d;
                    imageDAO.findActive(b, result);
                    ArrayList<Image> images = new ArrayList<>();
                    if(result.getObject(Image.class.getSimpleName()) != null) {
                        for (DomainObject o : result.getObject(Image.class.getSimpleName())) {
                            Image i = (Image) o;
                            images.add(i);
                        }
                    }
                    b.setImages(images);
                }
                result.putObject(Book.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void findAuthors(DomainObject object, Result result){
        Connection conn = new DBConnection().getConnection();
        if(conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book)object;
                String sql = "SELECT " + booksAuthorsAuthorColumn + " FROM " + booksAuthorsTable +
                        " WHERE " + booksAuthorsBookColumn + " = ?";
                PreparedStatement pstm = conn.prepareStatement(sql);
                pstm.setInt(1, book.getId());
                ResultSet rs = pstm.executeQuery();

                ArrayList<DomainObject> authors = new ArrayList<>();
                while(rs.next()){
                    Author a = new Author();
                    a.setId(rs.getInt(booksAuthorsAuthorColumn));
                    authors.add(a);
                }
                result.putObject(Author.class.getSimpleName(), authors);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void findCategories(DomainObject object, Result result){
        Connection conn = new DBConnection().getConnection();
        if(conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book)object;
                String sql = "SELECT " + booksCategoriesCategoryId + " FROM " + booksCategoriesTable +
                        " WHERE " + bookCategoriesBookId + " = ?";
                PreparedStatement pstm = conn.prepareStatement(sql);
                pstm.setInt(1, book.getId());
                ResultSet rs = pstm.executeQuery();

                ArrayList<DomainObject> categories = new ArrayList<>();
                while(rs.next()){
                    Category c = new Category();
                    c.setId(rs.getInt(booksCategoriesCategoryId));
                    categories.add(c);
                }
                result.putObject(Category.class.getSimpleName(), categories);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    private String getBookFilters(Book book, ArrayList<Integer> authors, ArrayList<Integer> categories){
        String filters = "";
        // Search matching Publishers
        if(book.getPublisher() != null && book.getPublisher().getId() != null){
            filters += publisherIdColumn + "=" + book.getPublisher().getId();
        }
        // Search matching Authors
        if(authors.size()>0){
            for(Integer a : authors) {
                if (filters.length() > 0) {
                    filters += " OR ";
                }
                filters += bookIdColumn + " = " + a.toString();
            }
        }
        // Search Matching categories
//        if(categories.size() > 0){
//            for(Integer c : categories) {
//                if (filters.length() > 0) {
//                    filters += " OR ";
//                }
//                filters += bookIdColumn + " = " + c.toString();
//            }
//        }
        if (filters.length() > 0) {
            filters += " OR ";
        }
        if(book.getTitle() != null) {
            // Search book title
            filters += titleColumn + " ILIKE \'%" + book.getTitle() + "%\'";
            // Search book ISBN
            filters += " OR " + isbnColumn + " ILIKE \'%" + book.getTitle() + "%\'";
        }
        return filters;
    }
    private String getAuthorsFilter(Book book){
        String filters = "";
        if(book.getAuthors() != null) {
            for (Author a : book.getAuthors()) {
                if (a.getId() != null) {
                    if (filters.length() == 0)
                        filters += " WHERE ";
                    if (filters.length() > 0) {
                        filters += " OR ";
                    }
                    filters += booksAuthorsAuthorColumn + "=" + a.getId();
                }
            }
        }
        return filters;
    }

//    private String CategoreisFilter(Book book){
//        String filters = "";
//        for(Category c : book.getCategories()){
//            if(filters.length() > 0){
//                filters += " OR ";
//            }
//            filters += booksCategoriesCategoryId + "=" + c.getId();
//        }
//        return filters;
//    }
}