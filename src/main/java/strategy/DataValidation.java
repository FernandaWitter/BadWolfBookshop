package strategy;

import domain.Book;
import domain.DomainObject;
import domain.Result;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

public class DataValidation implements IStrategy {

    public DataValidation() {}

    @Override
    public void process(DomainObject object, Result result) {
        Book book = (Book) object;
        boolean flag = true;

        if (book.getTitle() == null || book.getTitle().equals(""))
            flag = false;
        else if (book.getPubYear() == null)
            flag = false;
        else if (book.getPubEdition() == null)
            flag = false;
        else if (book.getLanguage() == null || book.getLanguage().equals(""))
            flag = false;
        else if (book.getIsbn() == null || book.getIsbn().equals(""))
            flag = false;
        else if (book.getSummary() == null || book.getSummary().equals(""))
            flag = false;
        else if (book.getHeight() == null)
            flag = false;
        else if (book.getWidth() == null)
            flag = false;
        else if (book.getDepth() == null)
            flag = false;
        else if (book.getWeight() == null)
            flag = false;
        else if (book.getPrice() == null)
            flag = false;
        else if (book.getInStock() == null)
            flag = false;
        else if (book.getPages() == null)
            flag = false;

        if (!flag)
            result.setMsg("error", "Erro de Valida&ccedil;&atilde;o de Dados.<br/> Existem campos obrigat&oacute;rios n&atildeo preenchidos.");
    }
}
