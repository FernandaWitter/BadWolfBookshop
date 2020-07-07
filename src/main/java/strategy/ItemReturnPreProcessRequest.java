package strategy;

import domain.DomainObject;
import domain.Result;
import domain.Status;
import dto.ReturnDTO;

public class ItemReturnPreProcessRequest implements IStrategy {
    @Override
    public void process(DomainObject object, Result result) {
        ReturnDTO dto = (ReturnDTO) object;
        if (dto.getOperation() == null || dto.getOperation().equals(""))
            result.setMsg("error", "Especifique a solicita&ccedil;&atilde;o desejada!");
        if (dto.getReturnReason() == null || dto.getReturnReason().equals(""))
            result.setMsg("error", "A justificativa da solicita&cceidl;&atilde;o n&atilde;o pode ficar em branco!");
        if (result.hasMsg("error"))
            return;
        Status status = null;
        if (dto.getOperation().equals("cancel"))
            status = Status.CANCELLING_REQUESTED;
        else if (dto.getOperation().equals("return"))
            status = Status.RETURNING;
        else if (dto.getOperation().equals("trade"))
            status = Status.EXCHANGING;
        if (status != null) {
            dto.setStatus(status);
        }
    }
}
