package strategy;

import domain.Book;
import domain.DomainObject;
import domain.Result;

public class IsbnValidation implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        Book book = (Book) object;
        boolean isValid;
        if (book.getIsbn().length() == 10)
            isValid = isValidISBN(book.getIsbn());
        else
            isValid = validateIsbn13(book.getIsbn());
        if (!isValid) {
            result.setMsg("error", "O ISBN informado n&atilde;o &eacute; v&aacute;lido!");
        }
    }

    private boolean isValidISBN(String isbn) {
        // length must be 10
        int n = isbn.length();
        if (n != 10)
            return false;

        // Computing weighted sum of first 9 digits
        int sum = 0;
        for (int i = 0; i < 9; i++) {
            int digit = isbn.charAt(i) - '0';
            if (0 > digit || 9 < digit)
                return false;
            sum += (digit * (10 - i));
        }

        // Checking last digit.
        char last = isbn.charAt(9);
        if (last != 'X' && (last < '0' ||
                last > '9'))
            return false;

        // If last digit is 'X', add 10 to sum, else add its value
        sum += ((last == 'X') ? 10 : (last - '0'));

        // Return true if weighted sum of digits is divisible by 11.
        return (sum % 11 == 0);
    }

    public boolean validateIsbn13(String isbn) {
        if (isbn == null) {
            return false;
        }

        //remove any hyphens
        isbn = isbn.replaceAll("-", "");

        //must be a 13 digit ISBN
        if (isbn.length() != 13) {
            return false;
        }

        try {
            int tot = 0;
            for (int i = 0; i < 12; i++) {
                int digit = Integer.parseInt(isbn.substring(i, i + 1));
                tot += (i % 2 == 0) ? digit * 1 : digit * 3;
            }

            //checksum must be 0-9. If calculated as 10 then = 0
            int checksum = 10 - (tot % 10);
            if (checksum == 10) {
                checksum = 0;
            }

            return checksum == Integer.parseInt(isbn.substring(12));
        } catch (NumberFormatException nfe) {
            //to catch invalid ISBNs that have non-numeric characters in them
            return false;
        }
    }
}
