package repository;

import config.DBConnection;
import domain.Category;
import domain.DomainObject;
import domain.Result;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class CategoryDAO implements IDAO {
    private final String categoriesTable = "categories";
    private final String categoryIdColumn = "cat_id";
    private final String categoryNameColumn = "cat_name";
    private final String categoryFields = " (" + categoryNameColumn + ")";

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Category category = (Category) object;
                String categorySql = "INSERT INTO " + categoriesTable + categoryFields + " VALUES (?)";
                PreparedStatement pstm = conn.prepareStatement(categorySql, Statement.RETURN_GENERATED_KEYS);

                pstm.setString(1, category.getName().toUpperCase());

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    int idCategory = rs.getInt(categoryIdColumn);
                    category.setId(idCategory);
                } else {
                    result.setMsg("error", "An error occurred. The Category entry could not be created.");
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
                Category category = (Category) object;

                String categorySql = "SELECT " + categoryIdColumn + ", " + categoryNameColumn + " FROM " + categoriesTable + " WHERE " +
                        categoryNameColumn + " ILIKE \'%" + category.getName() + "%\';";
                PreparedStatement pstm = conn.prepareStatement(categorySql, Statement.RETURN_GENERATED_KEYS);

                ResultSet rs = pstm.executeQuery();
                ArrayList<DomainObject> searchResult = new ArrayList<>();
                while (rs.next()) {
                    Category c = new Category(rs.getString(categoryNameColumn));
                    int idCategory = rs.getInt(categoryIdColumn);
                    c.setId(idCategory);
                    searchResult.add(c);
                }
                if (result.hasObject(Category.class.getSimpleName()))
                    result.removeObject(Category.class.getSimpleName());
                result.putObject(Category.class.getSimpleName(), searchResult);
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
                Category category = (Category) object;

                String categorySql = "SELECT " + categoryIdColumn + ", " + categoryNameColumn + " FROM " + categoriesTable + " WHERE " +
                        categoryIdColumn + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(categorySql);

                pstm.setInt(1, category.getId());

                ResultSet rs = pstm.executeQuery();
                ArrayList<DomainObject> searchResult = new ArrayList<>();
                while (rs.next()) {
                    Category c = new Category();
                    c.setId(rs.getInt(categoryIdColumn));
                    c.setName(rs.getString(categoryNameColumn));
                    searchResult.add(c);
                }
                result.putObject(Category.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }
}
