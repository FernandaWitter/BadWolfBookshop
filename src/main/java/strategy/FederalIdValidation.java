package strategy;

import domain.DomainObject;
import domain.Result;
import domain.User;

import java.util.InputMismatchException;

public class FederalIdValidation implements IStrategy {

    @Override
    public void process(DomainObject object, Result result) {
        User user = (User) object;
        String id = user.getFederalId();
        boolean isValid = true;
        if (id.equals("00000000000") || id.equals("11111111111") ||
                id.equals("22222222222") || id.equals("33333333333") ||
                id.equals("44444444444") || id.equals("55555555555") ||
                id.equals("66666666666") || id.equals("77777777777") ||
                id.equals("88888888888") || id.equals("99999999999") ||
                id.length() != 11)
            isValid = false;
        else {
            char dig10, dig11;
            int sm, i, r, num, peso;
            try {
                // Calculo do 1o. Digito Verificador
                sm = 0;
                peso = 10;
                for (i = 0; i < 9; i++) {
                    // converte o i-esimo caractere do CPF em um numero:
                    // por exemplo, transforma o caractere '0' no inteiro 0
                    // (48 eh a posicao de '0' na tabela ASCII)
                    num = (int) (id.charAt(i) - 48);
                    sm = sm + (num * peso);
                    peso = peso - 1;
                }

                r = 11 - (sm % 11);
                if ((r == 10) || (r == 11))
                    dig10 = '0';
                else dig10 = (char) (r + 48); // converte no respectivo caractere numerico

                // Calculo do 2o. Digito Verificador
                sm = 0;
                peso = 11;
                for (i = 0; i < 10; i++) {
                    num = (int) (id.charAt(i) - 48);
                    sm = sm + (num * peso);
                    peso = peso - 1;
                }

                r = 11 - (sm % 11);
                if ((r == 10) || (r == 11))
                    dig11 = '0';
                else dig11 = (char) (r + 48);

                // Verifica se os digitos calculados conferem com os digitos informados.
                if ((dig10 != id.charAt(9)) || (dig11 != id.charAt(10)))
                    isValid = false;
                if (!isValid)
                    result.setMsg("error", "O CPF informado n&atilde;o &eacute v&acutelido!");
            } catch (Exception e) {
                result.setMsg("error", "Ocorreu um erro ao validar o CPF. Por favor tente novamente.");
            }
        }
    }
}
