package repository;

import config.DBConnection;
import domain.DomainObject;
import domain.Result;
import domain.User;
import domain.Voucher;
import dto.UserDTO;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

public class VoucherDAO implements IDAO {
    private String voucherTable = "vouchers";

    private String voucherId = "vou_id";
    private String userId = "vou_usr_id";
    private String expiration = "vou_expiration";
    private String creation = "vou_creation";
    private String code = "vou_code";
    private String amount = "vou_amount";
    private String isActive = "vou_is_active";

    private String voucherFields = userId + ", " + expiration + ", " + creation + ", " + code + ", "
            + amount + ", " + isActive;

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Voucher voucher = (Voucher) object;
                String sql = "INSERT INTO " + voucherTable + " (" + voucherFields + ") VALUES (?, ?, ?, ?, ?, true)";
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, voucher.getUser());
                if (voucher.getExpirationDate() == null)
                    pstm.setDate(2, null);
                else
                    pstm.setDate(2, Date.valueOf(voucher.getExpirationDate()));
                if (voucher.getCreationDate() == null)
                    pstm.setDate(3, null);
                else
                    pstm.setDate(3, Date.valueOf(voucher.getCreationDate()));
                if (voucher.getCode() == null)
                    pstm.setString(4, null);
                else
                    pstm.setString(4, voucher.getCode());
                pstm.setDouble(5, voucher.getAmount());

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    voucher.setId(rs.getInt(voucherId));
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
                Voucher voucher = (Voucher) object;
                String sql = "UPDATE " + voucherTable + " SET " + expiration + " = ?, " + amount + " = ?, "
                        + isActive + " = ? WHERE " + voucherId + " = ?";
                PreparedStatement pstm = conn.prepareStatement(sql);

                if (voucher.getExpirationDate() == null)
                    pstm.setDate(1, null);
                else
                    pstm.setDate(1, Date.valueOf(voucher.getExpirationDate()));
                pstm.setDouble(2, voucher.getAmount());
                pstm.setBoolean(3, voucher.isActive());
                pstm.setInt(4, voucher.getId());

                pstm.executeUpdate();
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    @Override
    public void delete(DomainObject object, Result result) {

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
                UserDTO find = (UserDTO) object;
                String sql = "SELECT " + voucherId + ", " + voucherFields + " FROM " + voucherTable
                        + " WHERE " + isActive + " = true AND " + userId + " = ?;";

                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstm.setInt(1, find.getId());

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Voucher v = new Voucher();
                    v.setAmount(rs.getDouble(amount));
                    if (rs.getString(code) != null)
                        v.setCode(rs.getString(code));
                    if (rs.getDate(creation) != null)
                        v.setCreationDate(rs.getDate(creation).toLocalDate());
                    if (rs.getDate(expiration) != null)
                        v.setExpirationDate(rs.getDate(expiration).toLocalDate());
                    v.setId(rs.getInt(voucherId));
                    searchResult.add(v);
                }
                result.putObject(Voucher.class.getSimpleName(), searchResult);

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public Voucher findVoucherById(int id, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                String sql = "SELECT " + voucherId + ", " + voucherFields + " FROM " + voucherTable
                        + " WHERE " + isActive + " = true AND " + voucherId + " = ?;";

                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstm.setInt(1, id);

                ResultSet rs = pstm.executeQuery();
                Voucher v = new Voucher();
                if (rs.next()) {
                    v.setAmount(rs.getDouble(amount));
                    v.setCode(rs.getString(code));
                    v.setCreationDate(rs.getDate(creation).toLocalDate());
                    v.setExpirationDate(rs.getDate(expiration).toLocalDate());
                    v.setId(rs.getInt(voucherId));
                }
                return v;

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
        return null;
    }
}
