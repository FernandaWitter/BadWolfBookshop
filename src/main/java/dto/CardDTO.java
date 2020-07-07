package dto;

import domain.CardCompany;
import domain.CreditCard;
import domain.DomainObject;
import domain.Payment;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.smartcardio.Card;
import java.time.LocalDate;

@NoArgsConstructor

@Getter
@Setter
public class CardDTO extends DomainObject {
    private Integer company;
    private String holder;
    private String number;
    private String expiration;
    private boolean isExpired;
    private Double amountPaid;
    private String cvv;
    private Boolean saveCard;

    public CardDTO(Integer id) {
        this.setId(id);
    }

    public CardDTO(Integer company, String holder, String number, String expiration) {
        this.company = company;
        this.holder = holder;
        this.number = number;
        this.expiration = expiration;
    }

    public void setIsExpired() {
        String[] exp = expiration.split("/");
        isExpired = false;
        int year = LocalDate.now().getYear();
        int month = LocalDate.now().getMonthValue();
        if (Integer.valueOf(exp[1]) < year) {
            if (Integer.valueOf(exp[0]) < month)
                isExpired = true;
        }
    }

    public static CardDTO from(CreditCard card) {
        String cardNumber = card.getCardNumber();
        cardNumber = cardNumber.substring(cardNumber.length() - 4);
        CardDTO dto = new CardDTO(card.getCardCompany().getId(),
                card.getHolderName(), cardNumber, card.getExpiration());
        dto.setId(card.getId());
        dto.setIsExpired();
        return dto;
    }

    public static CreditCard toCard(CardDTO dto) {
        CreditCard card = new CreditCard();

        if (dto.getId() != null)
            card.setId(dto.getId());
        if (dto.getHolder() != null)
            card.setHolderName(dto.getHolder());
        if (dto.getCvv() != null)
            card.setCvv(dto.getCvv());
        if (dto.getNumber() != null)
            card.setCardNumber(dto.getNumber());
        if (dto.getCompany() != null)
            card.setCardCompany(new CardCompany(dto.getCompany()));
        if (dto.getExpiration() != null)
            card.setExpiration(dto.getExpiration());

        return card;
    }

    public Payment getPayment() {
        Payment payment = new Payment();
        if (this.getId() != null)
            payment.setCard(CardDTO.toCard(this));
        if (this.getAmountPaid() != null)
            payment.setAmount(this.getAmountPaid());
        return payment;
    }

}
