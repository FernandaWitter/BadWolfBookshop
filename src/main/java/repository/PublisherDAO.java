package repository;

import config.DBConnection;
import domain.DomainObject;
import domain.Publisher;
import domain.Result;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class PublisherDAO implements IDAO {
    private final String publisherTable = "publishers";
    private final String publisherIdColumn = "pub_id";
    private final String publisherNameColumn = "pub_name";
    private final String publisherFields = " (" + publisherNameColumn + ")";

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Publisher publisher = (Publisher) object;
                String authorSql = "INSERT INTO " + publisherTable + publisherFields + " VALUES (?)";
                PreparedStatement pstm = conn.prepareStatement(authorSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setString(1, publisher.getName().toUpperCase());

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    publisher.setId(rs.getInt(publisherIdColumn));
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
                Publisher publisher = (Publisher) object;
                String authorSql = "SELECT " + publisherIdColumn + ", " + publisherNameColumn + " FROM " + publisherTable +
                        " WHERE " + publisherNameColumn + " ILIKE \'%" + publisher.getName() + "%\';";
                PreparedStatement pstm = conn.prepareStatement(authorSql, Statement.RETURN_GENERATED_KEYS);
                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Publisher p = new Publisher();
                    p.setName(rs.getString(publisherNameColumn));
                    p.setId(rs.getInt(publisherIdColumn));
                    searchResult.add(p);
                }
                result.putObject(Publisher.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void findActive(DomainObject object, Result result) {
        findAll(object, result);
    }
}
