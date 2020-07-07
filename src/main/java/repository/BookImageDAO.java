package repository;

import config.DBConnection;
import domain.Book;
import domain.DomainObject;
import domain.Image;
import domain.Result;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class BookImageDAO implements IDAO {
    private final String imageTable = "book_images";
    private final String pathColumn = "img_path";
    private final String idColumn = "img_id";
    private final String bookFKColumn = "img_bks_id";
    private final String isActiveColumn = "img_is_active";
    private final String imageFields = "(" + pathColumn + ", " + bookFKColumn + ", " + isActiveColumn + ")";

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Image image = (Image) object;
                String imageSql = "INSERT INTO " + imageTable + imageFields + " VALUES (?, ?, true)";
                PreparedStatement pstm = conn.prepareStatement(imageSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setString(1, image.getPath());
                pstm.setInt(2, image.getBook());

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    int idImage = rs.getInt(idColumn);
                    image.setId(idImage);
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
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Image image = (Image) object;
                String imageSql = "UPDATE " + imageTable + " SET " + isActiveColumn + " = false WHERE " + idColumn + "=?";
                PreparedStatement pstm = conn.prepareStatement(imageSql);

                pstm.setInt(1, image.getId());
                pstm.execute();
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
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
                String imageSql = "SELECT * FROM " + imageTable + " WHERE " + bookFKColumn + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(imageSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, book.getId());

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Image i = new Image();
                    i.setId(rs.getInt(idColumn));
                    i.setPath(rs.getString(pathColumn));
                    i.setBook(rs.getInt(bookFKColumn));
                    searchResult.add(i);
                }
                result.putObject(Image.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
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
                String imageSql = "SELECT * FROM " + imageTable + " WHERE " + isActiveColumn + "=true AND " + bookFKColumn + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(imageSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, book.getId());

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Image i = new Image();
                    i.setId(rs.getInt(idColumn));
                    i.setPath(rs.getString(pathColumn));
                    i.setBook(rs.getInt(bookFKColumn));
                    searchResult.add(i);
                }
                result.putObject(Image.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }
}
