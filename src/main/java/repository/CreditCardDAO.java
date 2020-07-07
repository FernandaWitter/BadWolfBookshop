package repository;

import config.DBConnection;
import domain.*;
import dto.ClientDTO;
import dto.UserDTO;

import java.sql.*;
import java.util.ArrayList;

public class CreditCardDAO implements IDAO {
    private String cardTable = "user_cards";
    private String cardCompanyTable = "card_companies";

    private String cardId = "crd_id";
    private String userId = "crd_usr_id";
    private String companyId = "crd_ccp_id";
    private String expiration = "crd_expiration";
    private String number = "crd_number";
    private String cvv = "crd_cvv";
    private String holder = "crd_holder";
    private String isActive = "crd_is_active";

    private String cardCompanyId = "ccp_id";
    private String cardCompanyCode = "ccp_code";
    private String cardCompanyName = "ccp_name";

    private String cardFields = userId + ", " + companyId + ", " + expiration + ", "
            + number + ", " + cvv + ", " + holder + ", " + isActive;

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                CreditCard card = (CreditCard) object;
                String sql = "INSERT INTO " + cardTable + " (" + cardFields + ") VALUES (?, ?, ?, ?, ?, ?, true);";
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                setPstmVariables(pstm, card);

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    card.setId(rs.getInt(cardId));
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
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {

                CreditCard card = (CreditCard) object;
                String sql = "UPDATE " + cardTable + " SET " + userId + " = ?, " + companyId + " = ?, "
                        + expiration + " = ?, " + number + " = ?, " + cvv + " = ?, " + holder + " = ?, "
                        + cardId + " =?, " + isActive + " = true"
                        + " WHERE " + cardId + " = ? ";
                PreparedStatement pstm = conn.prepareStatement(sql);
                setPstmVariables(pstm, card);
                pstm.setInt(7, card.getId());
                pstm.setInt(8, card.getId());
                pstm.execute();

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void delete(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                User user = (User) object;
                String sql = "UPDATE " + cardTable + " SET " + isActive + " = false"
                        + " WHERE " + userId + " = ? ";
                PreparedStatement pstm = conn.prepareStatement(sql);
                pstm.setInt(1, user.getId());
                pstm.execute();

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void findAll(DomainObject object, Result result) {
        findActive(object, result);
    }

    @Override
    public void findActive(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                UserDTO find;
                if (object.getClass().getSimpleName().equals(User.class.getSimpleName())) {
                    User u = (User) object;
                    find = new UserDTO();
                    find.setId(u.getId());
                } else
                    find = (UserDTO) object;
                String sql = "SELECT " + cardId + ", " + cardFields + ", " + cardCompanyId + ", " + cardCompanyName + ", "
                        + cardCompanyCode
                        + " FROM " + cardTable
                        + " JOIN " + cardCompanyTable + " ON " + companyId + " = " + cardCompanyId
                        + " WHERE " + userId + " = ? AND " + isActive + " = true";
                PreparedStatement pstm = conn.prepareStatement(sql);
                pstm.setInt(1, find.getId());

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    CreditCard c = new CreditCard();
                    c.setId(rs.getInt(cardId));
                    c.setCardCompany(new CardCompany(rs.getString(cardCompanyName), Integer.valueOf(rs.getString(cardCompanyCode))));
                    c.setCardNumber(rs.getString(number));
                    c.setExpiration(rs.getString(expiration));
                    c.setCvv(rs.getString(cvv));
                    c.setHolderName(rs.getString(holder));
                    searchResult.add(c);
                }
                result.putObject(CreditCard.class.getSimpleName(), searchResult);

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    private void setPstmVariables(PreparedStatement pstm, CreditCard card) throws SQLException {
        pstm.setInt(1, card.getUser());
        pstm.setInt(2, card.getCardCompany().getCode());
        pstm.setString(3, card.getExpiration());
        pstm.setString(4, card.getCardNumber());
        pstm.setString(5, card.getCvv());
        pstm.setString(6, card.getHolderName());
    }

}
