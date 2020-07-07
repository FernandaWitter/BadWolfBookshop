package repository;

import config.DBConnection;
import domain.*;
import dto.ReturnDTO;

import java.sql.*;
import java.util.ArrayList;

public class OrderDAO implements IDAO {

    private String orderTable = "user_order";

    private String orderId = "ord_id";
    private String clientId = "ord_cli_id";
    private String orderDate = "ord_date";
    private String orderLastModified = "ord_last_modified";
    private String orderStatus = "ord_sts_id";
    private String shippingAddr = "ord_add_shipping";
    private String billingAddr = "ord_add_billing";

    private String orderFields = clientId + ", " + orderDate + ", " + orderLastModified + ", "
            + shippingAddr + ", " + billingAddr + ", " + orderStatus;

    // Payment table
    private String paymentTable = "order_payment";

    private String paymentId = "orp_id";
    private String paymentOrder = "orp_ord_id";
    private String cardId = "orp_crd_id";
    private String amount = "orp_amount";

    private String paymentFields = paymentOrder + ", " + cardId + ", " + amount;

    // Client table for find method
    private String userTable = "users";
    private String userName = "usr_name";
    private String userId = "usr_id";

    private IDAO idao;

    public OrderDAO() {
        idao = new OrderItemDAO();
    }

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Order order = (Order) object;
                String sql = "INSERT INTO " + orderTable + " (" + orderFields + ") VALUES (?, ?, ?, ?, ?, 1)";
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, order.getUser().getId());
                pstm.setDate(2, Date.valueOf(order.getCreation()));
                pstm.setDate(3, Date.valueOf(order.getModified()));
                pstm.setInt(4, order.getShipping().getId());
                pstm.setInt(5, order.getBilling().getId());

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    order.setId(rs.getInt(orderId));
                } else {
                    result.setMsg("error", "The Order entry could not be created");
                }

                if (order.getPayments() != null) {
                    for (Payment p : order.getPayments()) {
                        String paymentSql = "INSERT INTO " + paymentTable + " (" + paymentFields + ") VALUES (?, ?, ?);";
                        pstm = conn.prepareStatement(paymentSql);

                        pstm.setInt(1, order.getId());
                        pstm.setInt(2, p.getCard().getId());
                        pstm.setDouble(3, p.getAmount());

                        pstm.executeUpdate();
                    }
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
                Order order = (Order) object;
                String sql = "UPDATE " + orderTable + " SET "
                        + orderLastModified + " = ?, "
                        + orderStatus + " = ?"
                        + " WHERE " + orderId + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setDate(1, Date.valueOf(order.getModified()));
                pstm.setInt(2, order.getStatus().getCode());
                pstm.setInt(3, order.getId());

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
                Order order = (Order) object;
                String sql = "SELECT " + orderId + ", " + orderFields + ", " + userName
                        + " FROM " + orderTable
                        + " JOIN " + userTable + " ON " + clientId + " = " + userId;
                if (order.getId() != null && order.getId() > 0)
                    sql += " WHERE " + orderId + " = ?";
                sql += " ORDER BY " + orderId + " DESC";
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                if (order.getId() != null && order.getId() > 0)
                    pstm.setInt(1, order.getId());

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getInt(orderId));
                    o.setCreation(rs.getDate(orderDate).toLocalDate());
                    o.setModified(rs.getDate(orderLastModified).toLocalDate());
                    o.setStatus(Status.getStatusFromCode(rs.getInt(orderStatus)));
                    User user = new User();
                    user.setId(rs.getInt(clientId));
                    user.setName(rs.getString(userName));
                    o.setUser(user);
                    searchResult.add(o);
                }
                result.putObject(Order.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void findOrdersByClient(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Order order = (Order) object;
                String sql = "SELECT " + orderId + ", " + orderFields + " FROM " + orderTable
                        + " WHERE " + clientId + " = ?";
                if (order.getId() != null && order.getId() > 0)
                    sql += " AND " + orderId + " = ?";
                sql += " ORDER BY " + orderId + " DESC";
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, order.getUser().getId());
                if (order.getId() != null && order.getId() > 0)
                    pstm.setInt(2, order.getId());

                ArrayList<DomainObject> searchResult = new ArrayList<>();

                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getInt(orderId));
                    o.setCreation(rs.getDate(orderDate).toLocalDate());
                    o.setModified(rs.getDate(orderLastModified).toLocalDate());
                    o.setStatus(Status.getStatusFromCode(rs.getInt(orderStatus)));
                    o.setUser(order.getUser());
                    searchResult.add(o);
                }
                result.putObject(Order.class.getSimpleName(), searchResult);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void findOrderTotal(Order order, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                String sql = "SELECT sum(oit_quantity*bks_price) as total" +
                        " FROM order_item" +
                        " JOIN books on oit_bks_id = bks_id" +
                        " WHERE oit_ord_id = ?" +
                        " GROUP BY  oit_ord_id";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, order.getId());

                ResultSet rs = pstm.executeQuery();
                if (rs.next()) {
                    order.setOrderTotal(rs.getDouble("total"));
                }

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void updateOrderStatus(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                ReturnDTO dto = (ReturnDTO) object;
                String sql = "UPDATE user_order" +
                        " SET ord_sts_id = ?" +
                        " WHERE ord_id IN " +
                        "(SELECT oit_ord_id" +
                        " FROM order_item" +
                        " WHERE oit_id = ?)";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, dto.getStatus().getCode());
                pstm.setInt(2, dto.getItemId());

                pstm.execute();

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void getOrderUser(Order order, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                String sql = "SELECT " + clientId
                        + " FROM " + orderTable
                        + " WHERE " + orderId + " = ?";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, order.getId());

                ResultSet rs = pstm.executeQuery();
                if (rs.next()) {
                    order.setUser(new User(rs.getInt(clientId)));
                }

            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }
}
