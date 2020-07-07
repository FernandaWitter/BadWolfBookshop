package repository;

import config.DBConnection;
import domain.Author;
import domain.Book;
import domain.DomainObject;
import domain.Result;
import dto.CartDTO;
import dto.CartItemDTO;
import dto.LoginDTO;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

public class CartDAO implements IDAO {
    private final String cartTable = "user_cart";
    private final String cartId = "crt_id";
    private final String cartUser = "crt_usr_id";
    private final String cartDate = "crt_date";
    private final String cartFields = cartUser + ", " + cartDate;

    private final String cartItemsTable = "cart_items";
    private final String cartItemBookId = "cit_bks_id";
    private final String cartItemCartId = "cit_crt_id";
    private final String cartItemQuantity = "cit_quantity";
    private final String cartItemFields = cartItemBookId + ", " + cartItemCartId + ", " + cartItemQuantity;

    // Book table and fields to return full cart data
    private final String bookTable = "books";
    private final String bookId = "bks_id";
    private final String bookPrice = "bks_price";
    private final String bookTitle = "bks_title";
    private final String bookImageTable = "book_images";
    private final String bookCover = "img_path";
    private final String bookImageBookId = "img_bks_id";
    private final String bookFields = bookPrice + ", " + bookTitle + ", " + bookCover;

    @Override
    public void create(DomainObject object, Result result) {
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                LoginDTO login = (LoginDTO) object;
                CartDTO cart = login.getCart();
                PreparedStatement pstm;
                ResultSet rs;
                String cartSql = "INSERT INTO " + cartTable + "(" + cartFields + ") VALUES (?, ?)";
                pstm = conn.prepareStatement(cartSql, Statement.RETURN_GENERATED_KEYS);

                pstm.setInt(1, login.getUserId());
                pstm.setDate(2, Date.valueOf(LocalDate.now()));

                pstm.executeUpdate();
                rs = pstm.getGeneratedKeys();
                int cartIdNum = -1;
                if (rs.next()) {
                    cartIdNum = rs.getInt(cartId);
                    cart.setId(cartIdNum);
                } else {
                    result.setMsg("error", "An error occurred. The Author entry could not be created.");
                }

                for (CartItemDTO item : cart.getCartItems()) {
                    String itemsSql = "INSERT INTO " + cartItemsTable + "(" + cartItemFields + ") VALUES (?, ?, ?)";
                    pstm = conn.prepareStatement(itemsSql);

                    pstm.setInt(1, item.getBookId());
                    pstm.setInt(2, cartIdNum);
                    pstm.setInt(3, item.getQuantity());

                    pstm.execute();
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
                LoginDTO login = (LoginDTO) object;
                CartDTO cart = login.getCart();
                PreparedStatement pstm;
                ResultSet rs;
                String cartSql = "UPDATE " + cartTable + " SET " + cartUser + "= ?, " + cartDate + " = ?"
                        + " WHERE " + cartId + " = ?";
                pstm = conn.prepareStatement(cartSql);

                pstm.setInt(1, login.getUserId());
                pstm.setDate(2, Date.valueOf(LocalDate.now()));
                pstm.setInt(3, cart.getId());

                pstm.execute();

                int cartIdNum = cart.getId();

                String deleteItems = "DELETE FROM " + cartItemsTable + " WHERE " + cartItemCartId + " = ?";
                pstm = conn.prepareStatement(deleteItems);
                pstm.setInt(1, cartIdNum);
                pstm.execute();

                for (CartItemDTO item : cart.getCartItems()) {
                    String itemsSql = "INSERT INTO " + cartItemsTable + "(" + cartItemFields + ") VALUES (?, ?, ?)";
                    pstm = conn.prepareStatement(itemsSql, Statement.RETURN_GENERATED_KEYS);

                    pstm.setInt(1, item.getBookId());
                    pstm.setInt(2, cartIdNum);
                    pstm.setInt(3, item.getQuantity());

                    pstm.executeUpdate();
                    rs = pstm.getGeneratedKeys();
                    if (rs.next()) {
                        cart.setId(rs.getInt(cartId));
                    } else {
                        result.setMsg("error", "An error occurred. The Author entry could not be created.");
                    }
                }
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
        Connection conn = new DBConnection().getConnection();
        if (conn == null) {
            result.setMsg("error", "Connection Error");
        } else {
            try {
                LoginDTO login = (LoginDTO) object;
                CartDTO cart = new CartDTO();
                PreparedStatement pstm;
                ResultSet rs;
                String cartSql = "SELECT " + cartId + " FROM " + cartTable + " WHERE " +
                        cartUser + " = ?";
                pstm = conn.prepareStatement(cartSql);

                pstm.setInt(1, login.getUserId());

                rs = pstm.executeQuery();
                int idCart = 0;
                if (rs.next()) {
                    idCart = rs.getInt(cartId);
                    cart.setId(idCart);
                }

                String itemSql = "SELECT DISTINCT ON (" + cartItemBookId + ") " + cartItemFields + ", " + bookFields + " FROM " + cartItemsTable
                        + " JOIN " + bookTable + " ON " + cartItemBookId + " = " + bookId
                        + " JOIN " + bookImageTable + " ON " + cartItemBookId + " = " + bookImageBookId
                        + " WHERE " + cartItemCartId + " = ?";
                pstm = conn.prepareStatement(itemSql);
                pstm.setInt(1, idCart);
                rs = pstm.executeQuery();
                while (rs.next()) {
                    int bookId = rs.getInt(cartItemBookId);
                    int qty = rs.getInt(cartItemQuantity);
                    Double price = rs.getDouble(bookPrice);
                    String title = rs.getString(bookTitle);
                    String cover = rs.getString(bookCover);
                    cart.addItem(new CartItemDTO(bookId, qty, price, title, cover));
                }

                result.putObject(CartDTO.class.getSimpleName(), cart);
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
