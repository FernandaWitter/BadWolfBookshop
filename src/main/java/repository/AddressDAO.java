package repository;

import config.DBConnection;
import domain.*;
import dto.UserDTO;

import java.sql.*;
import java.util.ArrayList;

public class AddressDAO implements IDAO {
    private String addressTable = "user_address";
    private String stateTable = "states";
    private String countryTable = "countries";

    private String addressId = "add_id";
    private String userId = "add_usr_id";
    private String place = "add_place";
    private String number = "add_number";
    private String neighborhood = "add_neighborhood";
    private String zipcode = "add_zipcode";
    private String complement = "add_compl";
    private String city = "add_city";
    private String state = "add_stt_id";
    private String country = "add_cnt_id";
    private String isDelivery = "add_is_delivery";
    private String isBilling = "add_is_billing";
    private String isMain = "add_is_main";
    private String isActive = "add_is_active";
    private String nickname = "add_nickname";

    private String stateCode = "stt_code";
    private String stateName = "stt_name";

    private String countryCode = "cnt_code";
    private String countryName = "cnt_name";

    private String addressFields = userId + "," + place + "," + number + "," + neighborhood + ","
            + zipcode + "," + complement + "," + city + "," + state + "," + country + "," + isDelivery + ","
            + isBilling + "," + isMain + "," + nickname + "," + isActive;

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Address address = (Address) object;
                String sql = "INSERT INTO " + addressTable + " (" + addressFields
                        + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                setPstmVariables(pstm, address);

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    address.setId(rs.getInt(addressId));
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
                Address address = (Address) object;
                String sql = "UPDATE " + addressTable + " SET " + userId + " = ?, " + place + " = ?," + number + " =?,"
                        + neighborhood + " = ?, " + zipcode + " = ?, " + complement + " = ?, "
                        + city + " = ?, " + state + " = ?, " + country + " = ?, "
                        + isDelivery + " = ?, " + isBilling + " = ?, " + isMain + " = ?, "
                        + nickname + " = ?, " + isActive + " = ?"
                        + " WHERE " + addressId + " = ? ";
                PreparedStatement pstm = conn.prepareStatement(sql);
                setPstmVariables(pstm, address);
                pstm.setInt(15, address.getId());
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
                String sql = "UPDATE " + addressTable + " SET " + isActive + " = false"
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
                    find = new UserDTO();
                    User u = (User) object;
                    find.setId(u.getId());
                } else
                    find = (UserDTO) object;
                String sql = "SELECT " + addressId + ", " + addressFields + ", " + stateName + ", " + countryName
                        + " FROM " + addressTable
                        + " JOIN " + stateTable + " ON " + state + " = " + stateCode
                        + " JOIN " + countryTable + " ON " + country + " = " + countryCode
                        + " WHERE " + userId + " = ? AND " + isActive + " = true"
                        + " ORDER BY " + addressId;
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstm.setInt(1, find.getId());

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Address a = new Address();
                    a.setId(rs.getInt(addressId));
                    a.setPlace(rs.getString(place));
                    a.setNumber(rs.getString(number));
                    a.setNeighborhood(rs.getString(neighborhood));
                    a.setZipCode(rs.getString(zipcode));
                    a.setComplement(rs.getString(complement));
                    a.setCity(rs.getString(city));
                    a.setState(new State(rs.getInt(state), rs.getString(stateName)));
                    a.setCountry(new Country(rs.getInt(country), rs.getString(countryName)));
                    a.setIsBilling(rs.getBoolean(isBilling));
                    a.setIsDelivery(rs.getBoolean(isDelivery));
                    a.setIsMain(rs.getBoolean(isMain));
                    a.setNickname(rs.getString(nickname));
                    searchResult.add(a);
                }
                result.putObject(Address.class.getSimpleName(), searchResult);

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void getStatesAndCountries(Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                PreparedStatement pstm;
                ResultSet rs;
                String stateSql = "SELECT " + stateCode + ", " + stateName + " FROM " + stateTable + " ORDER BY " + stateName + ";";
                pstm = conn.prepareStatement(stateSql);
                rs = pstm.executeQuery();

                ArrayList<DomainObject> states = new ArrayList<>();
                while (rs.next()) {
                    State s = new State();
                    s.setCode(rs.getInt(stateCode));
                    s.setName(rs.getString(stateName));
                    states.add(s);
                }
                result.putObject(State.class.getSimpleName(), states);

                String countrySql = "SELECT " + countryCode + ", " + countryName + " FROM " + countryTable + " ORDER BY " + countryName + ";";
                pstm = conn.prepareStatement(countrySql);
                rs = pstm.executeQuery();

                ArrayList<DomainObject> countries = new ArrayList<>();
                while (rs.next()) {
                    Country c = new Country();
                    c.setCode(rs.getInt(countryCode));
                    c.setName(rs.getString(countryName));
                    countries.add(c);
                }
                result.putObject(Country.class.getSimpleName(), countries);

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    private void setPstmVariables(PreparedStatement pstm, Address address) throws SQLException {
        pstm.setInt(1, address.getUser());
        pstm.setString(2, address.getPlace());
        pstm.setString(3, address.getNumber());
        pstm.setString(4, address.getNeighborhood());
        pstm.setString(5, address.getZipCode());
        pstm.setString(6, address.getComplement());
        pstm.setString(7, address.getCity());
        pstm.setInt(8, address.getState().getCode());
        pstm.setInt(9, address.getCountry().getCode());
        if (address.getIsDelivery() == null)
            pstm.setBoolean(10, false);
        else
            pstm.setBoolean(10, address.getIsDelivery());
        if (address.getIsBilling() == null)
            pstm.setBoolean(11, false);
        else
            pstm.setBoolean(11, address.getIsBilling());
        if (address.getIsMain() == null)
            pstm.setBoolean(12, false);
        else
            pstm.setBoolean(12, address.getIsMain());
        pstm.setString(13, address.getNickname());
        if (address.getSaveAddress() != null && address.getSaveAddress().equals(Boolean.TRUE))
            pstm.setBoolean(14, true);
        else
            pstm.setBoolean(14, false);
    }
}
