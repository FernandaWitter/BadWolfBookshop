package repository;

import config.DBConnection;
import domain.*;
import dto.*;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements IDAO {

    private String accessCredentialTable = "access_credentials";
    private String credentialId = "acc_id";
    private String username = "acc_username";
    private String password = "acc_pw";
    private String credentialCreation = "acc_creation_date";
    private String lastAccess = "acc_last_access";
    private String isCredentialActive = "acc_is_active";
    private String accessCredentialsColumns = username + ", " + password + ", " + credentialCreation + ", "
            + lastAccess + ", " + isCredentialActive;

    private String userTable = "users";
    private String userId = "usr_id";
    private String accessCredentialCol = "usr_access_credential";
    private String name = "usr_name";
    private String nickname = "usr_nickname";
    private String federalId = "usr_federal_id";
    private String bday = "usr_bday";
    private String areaCode = "usr_area_code";
    private String phone = "usr_phone";
    private String isUserActive = "usr_is_active";
    private String userColumns = accessCredentialCol + ", " + name + ", " + nickname + ", " + federalId
            + ", " + bday + ", " + areaCode + ", " + phone + ", " + isUserActive;

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                ClientDTO client = (ClientDTO) object;
                AccessCredential ac = client.getUser().getAccessCredential();

                // Create AccessCredential
                String credentialSql = "INSERT INTO " + accessCredentialTable
                        + "(" + accessCredentialsColumns + ") VALUES (?, ?, ?, ?, true)";
                PreparedStatement pstm = conn.prepareStatement(credentialSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setString(1, ac.getUsername());
                pstm.setString(2, ac.getPwHash());
                pstm.setDate(3, Date.valueOf(LocalDate.now()));
                pstm.setDate(4, Date.valueOf(LocalDate.now()));

                pstm.executeUpdate();

                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    ac.setId(rs.getInt(credentialId));
                } else {
                    result.setMsg("error", "The User Credentials could not be created");
                }

                // Create User
                User u = client.getUser();
                String userSql = "INSERT INTO " + userTable
                        + "(" + userColumns + ") VALUES (?, ?, ?, ?, ?, ?, ?, true)";
                pstm = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, ac.getId());
                pstm.setString(2, u.getName());
                if (u.getNickname() != null)
                    pstm.setString(3, u.getNickname());
                else
                    pstm.setString(3, "");
                pstm.setString(4, u.getFederalId());
                pstm.setDate(5, Date.valueOf(u.getBirthday()));
                pstm.setString(6, u.getAreaCode());
                pstm.setString(7, u.getPhone());

                pstm.executeUpdate();

                rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    u.setId(rs.getInt(userId));
                    result.putObject(User.class.getSimpleName(), u);
                } else {
                    result.setMsg("error", "The User could not be created");
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
                ClientDTO client = (ClientDTO) object;
                User user = client.getUser();
                PreparedStatement pstm;
                if (client.getUser().getAccessCredential() != null) {
                    AccessCredential ac = client.getUser().getAccessCredential();

                    // Create AccessCredential
                    String credentialSql = "UPDATE " + accessCredentialTable
                            + " SET " + password + " = ?, " + lastAccess + " = ? "
                            + " WHERE " + credentialId + " IN "
                            + " (SELECT " + accessCredentialCol + " FROM " + userTable
                            + " WHERE " + userId + " = ?)";

                    pstm = conn.prepareStatement(credentialSql);

                    pstm.setString(1, ac.getPwHash());
                    pstm.setDate(2, Date.valueOf(LocalDate.now()));
                    pstm.setInt(3, user.getId());

                    pstm.execute();
                }
                if (client.isUpdateBasicData()) {
                    User u = client.getUser();
                    String userSql = "UPDATE " + userTable
                            + " SET " + name + " = ?, " + nickname + " = ?, " + federalId
                            + " = ?, " + bday + " = ?, " + areaCode + " = ?, " + phone + " = ? WHERE " + userId + " = ?";
                    pstm = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);

                    pstm.setString(1, u.getName());
                    if (u.getNickname() != null)
                        pstm.setString(2, u.getNickname());
                    else
                        pstm.setString(2, "");
                    pstm.setString(3, u.getFederalId());
                    pstm.setDate(4, Date.valueOf(u.getBirthday()));
                    pstm.setString(5, u.getAreaCode());
                    pstm.setString(6, u.getPhone());
                    pstm.setInt(7, u.getId());

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
                ClientDTO client = (ClientDTO) object;
                String sql = "UPDATE " + accessCredentialTable + " SET " + isCredentialActive + " = false" +
                        " FROM " + userTable + " WHERE "
                        + accessCredentialCol + " = " + credentialId + " AND " + userId + "= ?";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, client.getUser().getId());

                pstm.execute();
            } catch (Exception e) {
                result.setMsg("error", "N&atilde;o foi poss&iacute;vel excluir o usu&aacute;rio. Por favor, entre em contato com o administrador do sistema.");
            }
        }
    }

    @Override
    public void findAll(DomainObject object, Result result) {

    }

    @Override
    public void findActive(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                UserDTO dto;
                if (object.getClass().getSimpleName().equals(ClientDTO.class.getSimpleName())) {
                    dto = new UserDTO();
                    ClientDTO client = (ClientDTO) object;
                    dto.setId(client.getUser().getId());
                } else {
                    dto = (UserDTO) object;
                }
                PreparedStatement pstm;
                ResultSet rs;

                // Get User Data
                User u = new User();
                String userSql = "SELECT " + userColumns
                        + " FROM " + userTable
                        + " WHERE " + userId + " = ?";
                pstm = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, dto.getId());

                rs = pstm.executeQuery();
                if (rs.next()) {
                    u.setName(rs.getString(name));
                    u.setNickname(rs.getString(nickname));
                    u.setFederalId(rs.getString(federalId));
                    u.setBirthday(rs.getDate(bday).toLocalDate());
                    u.setAreaCode(rs.getString(areaCode));
                    u.setPhone(rs.getString(phone));
                    u.setId(dto.getId());
                }

                result.putObject(User.class.getSimpleName(), u);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void getUserDTO(DomainObject object, Result result) {
        AddressDAO addressDAO = new AddressDAO();
        addressDAO.findAll(object, result);
        List<DomainObject> addresses = result.getObject(Address.class.getSimpleName());
        List<AddressDTO> addressDTOS = new ArrayList<>();
        if (addresses != null) {
            for (Object a : addresses) {
                AddressDTO addressDTO = AddressDTO.from((Address) a);
                addressDTOS.add(addressDTO);
            }
        }

        CreditCardDAO cardDAO = new CreditCardDAO();
        cardDAO.findAll(object, result);
        List<DomainObject> cards = result.getObject(CreditCard.class.getSimpleName());
        List<CardDTO> cardDTOS = new ArrayList<>();
        if (cards != null) {
            for (Object c : cards) {
                CardDTO cardDTO = CardDTO.from((CreditCard) c);
                cardDTOS.add(cardDTO);
            }
        }

        VoucherDAO voucherDAO = new VoucherDAO();
        voucherDAO.findAll(object, result);
        List<DomainObject> voucherList = result.getObject(Voucher.class.getSimpleName());
        List<Voucher> vouchers = new ArrayList<>();
        if (voucherList != null) {
            for (DomainObject obj : voucherList) {
                Voucher v = (Voucher) obj;
                vouchers.add(v);
            }
        }

        UserDTO userDTO = new UserDTO();
        userDTO.setAddresses(addressDTOS);
        userDTO.setCards(cardDTOS);
        userDTO.setVouchers(vouchers);
        userDTO.setId(object.getId());

        result.putObject(UserDTO.class.getSimpleName(), userDTO);
    }

    public void doLogin(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                LoginDTO login = (LoginDTO) object;

                String sql = "SELECT " + userId
                        + " FROM " + userTable
                        + " JOIN " + accessCredentialTable + " ON " + accessCredentialCol + " = " + credentialId
                        + " WHERE " + username + " = ? AND " + password + " = ? AND " + isCredentialActive + " = true";
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                pstm.setString(1, login.getAc().getUsername());
                pstm.setString(2, login.getAc().getPwHash());

                ResultSet rs = pstm.executeQuery();
                if (rs.next()) {
                    login.setUserId(rs.getInt(userId));
                }
                result.putObject(LoginDTO.class.getSimpleName(), login);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void getPw(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                LoginDTO login = (LoginDTO) object;
                String sql = "SELECT " + password
                        + " FROM " + accessCredentialTable
                        + " WHERE " + username + " = ? AND " + isCredentialActive + " = true";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setString(1, login.getAc().getUsername());

                ResultSet rs = pstm.executeQuery();
                if (rs.next()) {
                    login.getAc().setPwHash(rs.getString(password));
                }
                result.putObject(LoginDTO.class.getSimpleName(), login);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }
}
