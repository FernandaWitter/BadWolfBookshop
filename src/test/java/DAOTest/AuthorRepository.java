package DAOTest;

import config.DBConnection;
import domain.Author;
import domain.Result;
import repository.AuthorDAO;

import java.sql.Connection;

public class AuthorRepository {
    public static void main(String[] args) {
        Author author = new Author("My first author");
        AuthorDAO dao = new AuthorDAO();
        try {
            Connection conn = new DBConnection().getConnection();
//            DBConnection db = new DBConnection();
//            Connection conn = DBConnection.getConnection();
//            System.out.println("Conn: " + conn);
//            Result result = dao.create(author, conn);
            Result res = new Result();
            dao.findActive(author, res);
            System.out.println("From author obj: " + author.getId());
//            System.out.println("Error: " + result.getMsg("error"));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
