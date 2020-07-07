package domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter

public enum Status {
    PROCESSING(1, "Em Processamento"),
    APPROVED(2, "Aprovado"),
    SHIPPING(3, "Em Trânsito"),
    DELIVERED(4, "Entregue"),
    EXCHANGING(5, "Em Troca"),
    EXCHANGE_AUTHORIZED(6, "Troca Autorizada"),
    EXCHANGED(7, "Trocado"),
    RETURNING(8, "Devolução Solicitada"),
    RETURNED(9, "Devolvido"),
    FAILED(10, "Reprovado"),
    OUT_OF_STOCK(11, "Em falta"),
    CANCELLING_REQUESTED(12, "Cancelamento Solicitado"),
    CANCELLED(13, "Cancelado"),
    RETURN_AUTHORIZED(14, "Devolução Autorizada");

    private String title;
    private int code;

    Status(int code, String title) {
        this.code = code;
        this.title = title;
    }

    public static Status getStatusFromCode(int code) {
        for (Status s : Status.values()) {
            if (s.code == code)
                return s;
        }
        return null;
    }

    public static Status getNext(Status status) {
        switch (status.getCode()) {
            case 1:
                return Status.APPROVED;
            case 2:
                return Status.SHIPPING;
            case 3:
                return Status.DELIVERED;
            case 5:
                return Status.EXCHANGE_AUTHORIZED;
            case 6:
                return Status.EXCHANGED;
            case 8:
                return Status.RETURN_AUTHORIZED;
            case 12:
                return Status.CANCELLED;
            case 14:
                return Status.RETURNED;
            default:
                return status;
        }
    }
}
