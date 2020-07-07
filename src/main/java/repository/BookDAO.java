package repository;

import config.DBConnection;
import domain.*;
import dto.BookChartDTO;
import dto.BookDTO;
import dto.ReturnChartDTO;

import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

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
            widthColumn + ", " + depthColumn + ", " + weightColumn + ", " + priceColumn + ", " + inStockColumn + ", " +
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
                for (Image i : book.getImages()) {
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
                for (Category c : book.getCategories()) {
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
                if (result.getObject(Image.class.getSimpleName()) != null) {
                    ArrayList<DomainObject> oldImages = result.getObject(Image.class.getSimpleName());
                    for (DomainObject d : oldImages) {
                        imageDAO.delete(d, result);
                    }
                }
                for (Image i : book.getImages()) {
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

                for (Category c : book.getCategories()) {
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
        if (conn == null)
            result.setMsg("error", "Connection Error");
        else {
            try {
                Book book = (Book) object;
                String sql = "UPDATE " + bookTable + " SET " + isActiveColumn + " = false WHERE " + bookIdColumn + "= ?";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, book.getId());

                pstm.execute();
            } catch (Exception e) {
                result.setMsg("error", "N&atilde;o foi poss&iacute;vel salvar o livro. Verifique os campos e tente novamente, ou entre em contato com o administrador do sistema.");
            }
        }

    }

    @Override
    public void findAll(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book) object;

                // find matching authors
                String findAuthorsSql = "SELECT " + booksAuthorsBookColumn + " FROM " + booksAuthorsTable + " WHERE " +
                        getAuthorsFilter(book);
                PreparedStatement pstm = conn.prepareStatement(findAuthorsSql);
                ResultSet rs = pstm.executeQuery();
                ArrayList<Integer> authors = new ArrayList<>();
                while (rs.next()) {
                    authors.add(new Integer(rs.getInt(booksAuthorsBookColumn)));
                }

                String bookSql = "SELECT (" + bookFields + ", " + publisherName + ")  FROM " + bookTable +
                        " INNER JOIN " + publisherTable + " ON " + publisherId + "=" + publisherIdColumn +
                        " WHERE " + getBookFilters(book, authors);
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
                for (DomainObject d : searchResult) {
                    Book b = (Book) d;
                    String findAuthors = "SELECT " + booksAuthorsAuthorColumn + " FROM " + booksAuthorsTable +
                            " WHERE " + booksAuthorsBookColumn + "=" + b.getId() + ";";
                    pstm = conn.prepareStatement(findAuthors);
                    rs = pstm.executeQuery();
                    ArrayList<Author> bookAuthors = new ArrayList<>();
                    while (rs.next()) {
                        Author a = new Author();
                        a.setId(rs.getInt(booksAuthorsAuthorColumn));
                        bookAuthors.add(a);
                    }
                    b.setAuthors(bookAuthors);
                }

                // Return Category codes
                for (DomainObject d : searchResult) {
                    Book b = (Book) d;
                    String findCategory = "SELECT " + booksCategoriesCategoryId + " FROM " + booksCategoriesTable +
                            " WHERE " + bookCategoriesBookId + "=" + b.getId() + ";";
                    pstm = conn.prepareStatement(findCategory);
                    rs = pstm.executeQuery();
                    ArrayList<Category> bookCategories = new ArrayList<>();
                    while (rs.next()) {
                        Category c = new Category();
                        c.setId(rs.getInt(booksAuthorsAuthorColumn));
                        bookCategories.add(c);
                    }
                    b.setCategories(bookCategories);
                }

                result.putObject(Author.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", "N&atilde;o foi poss&iacute;vel salvar o livro. Verifique os campos e tente novamente, ou entre em contato com o administrador do sistema.");
            }
        }
    }

    @Override
    public void findActive(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book) object;
                PreparedStatement pstm;
                ResultSet rs;
                // find matching authors
                String authorFilters = getAuthorsFilter(book);
                ArrayList<Integer> authors = new ArrayList<>();
                if (authorFilters != null && !authorFilters.equals("")) {
                    String findAuthorsSql = "SELECT " + booksAuthorsBookColumn + " FROM " + booksAuthorsTable + authorFilters;
                    pstm = conn.prepareStatement(findAuthorsSql);
                    rs = pstm.executeQuery();
                    while (rs.next()) {
                        authors.add(new Integer(rs.getInt(booksAuthorsBookColumn)));
                    }
                }

                String bookSql = "SELECT " + bookFields + ", " + publisherName + "," + bookIdColumn + " FROM " + bookTable +
                        " INNER JOIN " + publisherTable + " ON " + publisherId + "=" + publisherIdColumn +
                        " WHERE " + isActiveColumn + " = true";
                String filters = getBookFilters(book, authors);
                if (filters != null && !filters.equals(""))
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
                for (DomainObject d : searchResult) {
                    Book b = (Book) d;
                    imageDAO.findActive(b, result);
                    ArrayList<Image> images = new ArrayList<>();
                    if (result.getObject(Image.class.getSimpleName()) != null) {
                        for (DomainObject o : result.getObject(Image.class.getSimpleName())) {
                            Image i = (Image) o;
                            images.add(i);
                        }
                    }
                    b.setImages(images);
                }
                result.putObject(Book.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", "N&atilde;o foi poss&iacute;vel realizar a busca. Verifique os campos e tente novamente, ou entre em contato com o administrador do sistema.");
            }
        }
    }

    public void findAuthors(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book) object;
                String sql = "SELECT " + booksAuthorsAuthorColumn + " FROM " + booksAuthorsTable +
                        " WHERE " + booksAuthorsBookColumn + " = ?";
                PreparedStatement pstm = conn.prepareStatement(sql);
                pstm.setInt(1, book.getId());
                ResultSet rs = pstm.executeQuery();

                ArrayList<DomainObject> authors = new ArrayList<>();
                while (rs.next()) {
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

    public void findCategories(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Book book = (Book) object;
                String sql = "SELECT " + booksCategoriesCategoryId + " FROM " + booksCategoriesTable +
                        " WHERE " + bookCategoriesBookId + " = ?";
                PreparedStatement pstm = conn.prepareStatement(sql);
                pstm.setInt(1, book.getId());
                ResultSet rs = pstm.executeQuery();

                ArrayList<DomainObject> categories = new ArrayList<>();
                while (rs.next()) {
                    Category c = new Category();
                    c.setId(rs.getInt(booksCategoriesCategoryId));
                    categories.add(c);
                }
                result.putObject(Category.class.getSimpleName(), categories);
            } catch (Exception e) {
                result.setMsg("error", "N&atilde;o foi poss&iacute;vel realizar a busca. Verifique os campos e tente novamente, ou entre em contato com o administrador do sistema.");
            }
        }
    }

    private String getBookFilters(Book book, ArrayList<Integer> authors) {
        String filters = "";
        // Search matching Publishers
        if (book.getPublisher() != null && book.getPublisher().getId() != null) {
            filters += publisherIdColumn + "=" + book.getPublisher().getId();
        }
        // Search matching Authors
        if (authors.size() > 0) {
            for (Integer a : authors) {
                if (filters.length() > 0) {
                    filters += " OR ";
                }
                filters += bookIdColumn + " = " + a.toString();
            }
        }

        if (filters.length() > 0) {
            filters += " OR ";
        }
        if (book.getTitle() != null) {
            // Search book title
            filters += titleColumn + " ILIKE \'%" + book.getTitle() + "%\'";
            // Search book ISBN
            filters += " OR " + isbnColumn + " ILIKE \'%" + book.getTitle() + "%\'";
        }
        if (book.getId() != null) {
            if (filters.length() > 0) {
                filters += " OR ";
            }
            filters += bookIdColumn + " = " + book.getId();
        }
        return filters;
    }

    private String getAuthorsFilter(Book book) {
        String filters = "";
        if (book.getAuthors() != null) {
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

    public void generalSearch(BookDTO book, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                String findSql = "SELECT DISTINCT ON(" + bookIdColumn + ") "
                        + bookIdColumn + ", " + titleColumn + ", " + priceColumn + ", img_path "
                        + " FROM " + bookTable
                        + " JOIN " + booksAuthorsTable + " ON " + bookIdColumn + " = " + booksAuthorsBookColumn
                        + " JOIN authors ON " + booksAuthorsAuthorColumn + " = aut_id"
                        + " JOIN " + booksCategoriesTable + " ON " + bookIdColumn + " = " + bookCategoriesBookId
                        + " JOIN categories ON " + booksCategoriesCategoryId + " = cat_id"
                        + " JOIN (SELECT DISTINCT ON(img_bks_id) img_path, img_bks_id"
                        + " FROM book_images "
                        + " WHERE img_is_active = true"
                        + ") AS image ON " + bookIdColumn + " = img_bks_id"
                        + " WHERE " + titleColumn + " ILIKE ? OR " + isbnColumn + " ILIKE ? "
                        + " OR aut_name ILIKE ? OR cat_name ILIKE ?";
                PreparedStatement pstm = conn.prepareStatement(findSql);

                pstm.setString(1, "%" + book.getTitle() + "%");
                pstm.setString(2, "%" + book.getTitle() + "%");
                pstm.setString(3, "%" + book.getTitle() + "%");
                pstm.setString(4, "%" + book.getTitle() + "%");

                ResultSet rs = pstm.executeQuery();

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                while (rs.next()) {
                    BookDTO b = new BookDTO();
                    b.setId(rs.getInt(bookIdColumn));
                    b.setPrice(rs.getDouble(priceColumn));
                    b.setTitle(rs.getString(titleColumn));
                    b.setImagePath(rs.getString("img_path"));
                    searchResult.add(b);
                }
                result.putObject(BookDTO.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", "N&atilde;o foi poss&iacute;vel realizar a busca. Verifique os campos e tente novamente, ou entre em contato com o administrador do sistema.");
            }
        }
    }

    public void getChartData(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                BookChartDTO dto = (BookChartDTO) object;
                String catsql = "SELECT cat_name FROM categories";
                PreparedStatement pstm = conn.prepareStatement(catsql);
                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    dto.addCategory(rs.getString("cat_name"));
                }

                String sql = "WITH a as" +
                        " (SELECT DISTINCT ON (week)" +
                        " extract(week FROM ord_date) AS week," +
                        " ord_date" +
                        " FROM user_order)," +
                        " b AS " +
                        " (SELECT sum(oit_quantity) AS qty," +
                        " cat_name," +
                        " extract(week FROM ord_date) AS weekly" +
                        " FROM user_order" +
                        " JOIN order_item ON ord_id = oit_ord_id" +
                        " JOIN book_categories ON oit_bks_id = bkc_bks_id" +
                        " JOIN categories ON bkc_cat_id = cat_id" +
                        " GROUP BY weekly, cat_name)" +
                        " SELECT" +
                        " a.week AS week," +
                        " a.ord_date AS ord_date," +
                        " b.qty AS amount," +
                        " b.cat_name AS cat_name" +
                        " FROM a JOIN b ON a.week = b.weekly" +
                        " WHERE ord_date BETWEEN ? AND ?" +
                        " ORDER BY ord_date";
                pstm = conn.prepareStatement(sql);

                LocalDate start, end;
                end = LocalDate.now();
                start = end.minusMonths(3);
                if (dto.getStartDate() != null) {
                    start = dto.getStartDate();
                }
                if (dto.getEndDate() != null) {
                    end = dto.getEndDate();
                }

                pstm.setDate(1, Date.valueOf(start));
                pstm.setDate(2, Date.valueOf(end));

                rs = pstm.executeQuery();

                HashMap<String, Integer> data = new HashMap<>();
                String date = null;
                int week = 0;
                while (rs.next()) {
                    String curDate = rs.getString("ord_date");
                    int curWeek = rs.getInt("week");
                    if (date == null) {
                        date = curDate;
                        week = curWeek;
                        for (String s : dto.getFoundCategories()) {
                            data.put(s, 0);
                        }
                    } else if (week != curWeek) {
                        dto.addResult(date, data);
                        data = new HashMap<>();
                        for (String s : dto.getFoundCategories()) {
                            data.put(s, 0);
                        }
                        date = curDate;
                        week = curWeek;
                    }
                    String category = rs.getString("cat_name");
                    int amount = rs.getInt("amount");
                    data.replace(category, amount);
                }

                String orderSql = "WITH order_count AS" +
                        " (SELECT" +
                        " count(ord_id) AS amount," +
                        " CASE WHEN ord_sts_id IN (1,2,3) THEN 'Aberto'" +
                        " WHEN ord_sts_id = 4 THEN 'Concluído'" +
                        " WHEN ord_sts_id IN (5,6,7) THEN 'Troca'" +
                        " WHEN ord_sts_id IN (8, 9, 14) THEN 'Devolução'" +
                        " ELSE 'Cancelado' END AS status" +
                        " FROM user_order" +
                        " GROUP BY ord_sts_id)" +
                        " SELECT sum(amount) AS amount, status FROM order_count GROUP BY status";
                pstm = conn.prepareStatement(orderSql);
                rs = pstm.executeQuery();

                ReturnChartDTO returnChartDTO = new ReturnChartDTO();
                while (rs.next()) {
                    returnChartDTO.addStatus(rs.getString("status"), rs.getInt("amount"));
                }

                result.putObject(BookChartDTO.class.getSimpleName(), dto);
                result.putObject(ReturnChartDTO.class.getSimpleName(), returnChartDTO);
            } catch (Exception e) {
                result.setMsg("error", "N&atilde;o foi poss&iacute;vel realizar a busca. Verifique os campos e tente novamente, ou entre em contato com o administrador do sistema.");
            }
        }
    }
}