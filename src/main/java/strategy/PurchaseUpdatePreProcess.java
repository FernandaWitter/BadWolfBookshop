package strategy;

import domain.*;
import dto.UpdatePurchaseDTO;
import repository.OrderItemDAO;

import java.time.LocalDate;
import java.util.List;

public class PurchaseUpdatePreProcess implements IStrategy {

    private OrderItemDAO itemDAO;
    private ReturnItemPreProcessVoucher processVoucher;

    public PurchaseUpdatePreProcess() {
        itemDAO = new OrderItemDAO();
        processVoucher = new ReturnItemPreProcessVoucher();
    }

    @Override
    public void process(DomainObject object, Result result) {
        UpdatePurchaseDTO dto = (UpdatePurchaseDTO) object;
        Order order = new Order(dto.getOrderId());
        itemDAO.getPurchaseItems(order, result);
        Status lowestStatus = null;
        LocalDate modified = LocalDate.now();
        for (OrderItem item : order.getItems()) {
            if (dto.getRejectItems().contains(item.getId())) {
                lowestStatus = Status.FAILED;
                item.setStatus(Status.FAILED);
                item.setModified(modified);
            } else if (dto.getUpdateItems().contains(item.getId())) {
                Status newStatus = Status.getNext(item.getStatus());
                item.setStatus(newStatus);
                item.setModified(modified);
                if (newStatus.equals(Status.CANCELLED) || newStatus.equals(Status.EXCHANGED) || newStatus.equals(Status.RETURNED)) {
                    processVoucher.process(item, result);
                }
            }
            if (lowestStatus == null)
                lowestStatus = item.getStatus();
            else if (lowestStatus.getCode() < 4 && lowestStatus.getCode() > item.getStatus().getCode())
                lowestStatus = item.getStatus();
            else if (4 < item.getStatus().getCode())
                lowestStatus = item.getStatus();
        }
        order.setStatus(lowestStatus);
        order.setModified(modified);
        result.putObject(Order.class.getSimpleName(), order);
    }
}
