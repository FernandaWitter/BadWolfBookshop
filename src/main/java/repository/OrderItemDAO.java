package repository;

import config.DBConnection;
import domain.*;
import dto.ReturnDTO;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

public class OrderItemDAO implements IDAO {

    private String orderItemTable = "order_item";

    private String itemId = "oit_id";
    private String orderId = "oit_ord_id";
    private String bookId = "oit_bks_id";
    private String quantity = "oit_quantity";
    private String itemStatus = "oit_sts_id";
    private String creation = "oit_date";
    private String modified = "oit_last_modified";
    private String returnReason = "oit_return_motive";

    private String orderItemFields = orderId + ", " + bookId + ", " + quantity + ", "
            + creation + ", " + modified + ", " + itemStatus;

    // View with item and book data
    private String itemView = "order_item_data";
    private String viewBookId = "bks_id";
    private String viewBookTitle = "bks_title";
    private String viewBookPrice = "bks_price";
    private String viewBookImage = "img_path";
    private String viewUserId = "ord_cli_id";
    private String viewBooksInStock = "bks_inStock";

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                OrderItem item = (OrderItem) object;
                String sql = "INSERT INTO " + orderItemTable + " (" + orderItemFields + ") VALUES (?, ?, ?, ?, ?, 1)";
                PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, item.getOrderId());
                pstm.setInt(2, item.getBook().getId());
                pstm.setInt(3, item.getQuantity());
                pstm.setDate(4, Date.valueOf(item.getCreated()));
                pstm.setDate(5, Date.valueOf(item.getModified()));

                pstm.executeUpdate();
                ResultSet rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    item.setId(rs.getInt(itemId));
                } else {
                    result.setMsg("error", "The Item entry could not be created");
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
                OrderItem item = (OrderItem) object;
                String sql = "UPDATE " + orderItemTable + " SET "
                        + quantity + " = ?, "
                        + itemStatus + " = ?, "
                        + modified + " = ?"
                        + " WHERE " + itemId + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, item.getQuantity());
                pstm.setInt(2, item.getStatus().getCode());
                pstm.setDate(3, Date.valueOf(item.getModified()));
                pstm.setInt(4, item.getId());

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
                Order item = (Order) object;
                String sql = "SELECT " + itemId + ", " + orderItemFields
                        + " FROM " + orderItemTable
                        + " WHERE " + orderId + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, item.getId());

                ResultSet rs = pstm.executeQuery();
                ArrayList<DomainObject> items = new ArrayList<>();
                while (rs.next()) {
                    OrderItem i = new OrderItem();
                    i.setOrderId(item.getId());
                    i.setBook(new Book(rs.getInt(bookId)));
                    i.setCreated(rs.getDate(creation).toLocalDate());
                    i.setModified(rs.getDate(modified).toLocalDate());
                    i.setQuantity(rs.getInt(quantity));
                    i.setStatus(Status.getStatusFromCode(rs.getInt(itemStatus)));
                    items.add(i);
                }
                result.putObject(OrderItem.class.getSimpleName(), items);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void getPurchaseItems(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                Order order = (Order) object;
                String sql = "SELECT * FROM " + itemView
                        + " WHERE " + orderId + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, order.getId());

                ResultSet rs = pstm.executeQuery();
                ArrayList<OrderItem> items = new ArrayList<>();
                while (rs.next()) {
                    OrderItem i = new OrderItem();
                    i.setId(rs.getInt(itemId));
                    i.setOrderId(rs.getInt(orderId));
                    Book b = new Book(rs.getInt(viewBookId));
                    b.setTitle(rs.getString(viewBookTitle));
                    b.setPrice(rs.getDouble(viewBookPrice));
                    b.addImage(new Image(rs.getString(viewBookImage)));
                    b.setInStock(rs.getInt(viewBooksInStock));
                    i.setBook(b);
                    i.setQuantity(rs.getInt(quantity));
                    i.setStatus(Status.getStatusFromCode(rs.getInt(itemStatus)));
                    String returnReasonText = rs.getString(returnReason);
                    if (returnReasonText == null || returnReasonText.equals("null"))
                        returnReasonText = "";
                    i.setReturnReason(returnReasonText);
                    items.add(i);
                }
                order.setItems(items);
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void findItemById(OrderItem item, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                String sql = "SELECT * FROM " + itemView
                        + " WHERE " + itemId + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(sql);

                pstm.setInt(1, item.getId());

                ResultSet rs = pstm.executeQuery();

                if (rs.next()) {
                    item.setOrderId(rs.getInt(orderId));
                    Book b = new Book(rs.getInt(viewBookId));
                    b.setTitle(rs.getString(viewBookTitle));
                    b.setPrice(rs.getDouble(viewBookPrice));
                    b.addImage(new Image(rs.getString(viewBookImage)));
                    item.setBook(b);
                    item.setQuantity(rs.getInt(quantity));
                    item.setStatus(Status.getStatusFromCode(rs.getInt(itemStatus)));
                    String returnReasonText = rs.getString(returnReason);
                    if (returnReasonText == null || returnReasonText.equals("null"))
                        returnReasonText = "";
                    item.setReturnReason(returnReasonText);
                }
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

    public void updateStatus(ReturnDTO dto, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                String sql = "UPDATE " + orderItemTable + " SET "
                        + itemStatus + " = ?, "
                        + modified + " = ?"
                        + " WHERE " + itemId + " = ?;";
                PreparedStatement pstm = conn.prepareStatement(sql);

                if (dto.getStatus() != null) {
                    pstm.setInt(1, dto.getStatus().getCode());
                    pstm.setDate(2, Date.valueOf(LocalDate.now()));
                    pstm.setInt(3, dto.getItemId());

                    pstm.executeUpdate();
                }
            } catch (Exception e) {
                result.setMsg("error", e.getMessage());
            }
        }
    }

}
