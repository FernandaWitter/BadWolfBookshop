package repository;

import config.DBConnection;
import domain.Author;
import domain.Book;
import domain.DomainObject;
import domain.Result;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class AuthorDAO implements IDAO {
    private final String authorsTable = "authors";
    private final String authorIdColumn = "aut_id";
    private final String authorNameColumn = "aut_name";
    private final String authorFields = " (" + authorNameColumn + ")";

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Author author = (Author) object;
                String authorSql = "INSERT INTO " + authorsTable + authorFields + " VALUES (?)";
                PreparedStatement pstm = conn.prepareStatement(authorSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setString(1, author.getName().toUpperCase());

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    int idAuthor = rs.getInt(authorIdColumn);
                    author.setId(idAuthor);
                } else {
                    result.setMsg("error", "An error occurred. The Author entry could not be created.");
                }
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void update(DomainObject object, Result result) {

    }

    @Override
    public void delete(DomainObject object, Result result) {

    }

    @Override
    public void findAll(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Author author = (Author) object;
                String authorSql = "SELECT " + authorIdColumn + "," + authorNameColumn + " FROM " + authorsTable + " WHERE " +
                        authorNameColumn + " ILIKE " + "\'%" + author.getName() + "%\';";
                PreparedStatement pstm = conn.prepareStatement(authorSql, Statement.RETURN_GENERATED_KEYS);

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Author a = new Author(rs.getString(authorNameColumn));
                    int idAuthor = rs.getInt(authorIdColumn);
                    a.setId(idAuthor);
                    searchResult.add(a);
                }
                result.putObject(Author.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void findActive(DomainObject object, Result result) {
        findAll(object, result);
    }

    public void findById(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Author author = (Author) object;
                String authorSql = "SELECT " + authorIdColumn + ", " + authorNameColumn + " FROM " + authorsTable + " WHERE " + authorIdColumn + "= ?;";
                PreparedStatement pstm = conn.prepareStatement(authorSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, author.getId());

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Author a = new Author(rs.getString(authorNameColumn));
                    int idAuthor = rs.getInt(authorIdColumn);
                    a.setId(idAuthor);
                    searchResult.add(a);
                }
                result.putObject(Author.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void findBookAuthors(Book book, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                String authorSql = "SELECT " + authorIdColumn + ", " + authorNameColumn
                        + " FROM book_authors JOIN " + authorsTable + " ON bka_aut_id = " + authorIdColumn
                        + " WHERE bka_bks_id = ?;";
                PreparedStatement pstm = conn.prepareStatement(authorSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, book.getId());

                ArrayList<Author> authors = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Author a = new Author(rs.getString(authorNameColumn));
                    int idAuthor = rs.getInt(authorIdColumn);
                    a.setId(idAuthor);
                    authors.add(a);
                }
                book.setAuthors(authors);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }
}
