package controller;

import domain.*;
import dto.*;
import repository.*;
import strategy.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Facade {
    HashMap<String, HashMap<String, ArrayList<IStrategy>>> preprocessing;
    HashMap<String, HashMap<String, ArrayList<IStrategy>>> postprocessing;
    HashMap<String, IDAO> persistence;

    public Facade() {
        // operations
        String create = "create";
        String update = "update";
        String delete = "delete";
        String find = "find";

        // domain classes
        String book = Book.class.getSimpleName();
        String user = UserDTO.class.getSimpleName();
        String order = OrderDTO.class.getSimpleName();
        String card = CardDTO.class.getSimpleName();
        String address = Address.class.getSimpleName();
        String purchaseDto = UpdatePurchaseDTO.class.getSimpleName();
        String returnDto = ReturnDTO.class.getSimpleName();
        String client = ClientDTO.class.getSimpleName();

        // strategies
        IStrategy preProcessAuthors = new BookCreationPreProcessAuthors();
        IStrategy preProcessCategories = new BookCreationPreProcessCategories();
        IStrategy preProcessPublisher = new BookCreationPreProcessPublisher();
        IStrategy postProcessAuthors = new BookSearchPostProcessAuthors();
        IStrategy postProcessCategories = new BookSearchPostProcessCategories();
        IStrategy bookDataValidation = new DataValidation();
        IStrategy bookExistenceValidation = new ExistenceValidation();
        IStrategy isbnValidation = new IsbnValidation();

        IStrategy preProcessOrderAddress = new OrderPlacementPreProcessAddress();
        IStrategy preProcessOrderShipping = new OrderPlacementPreProcessShipping();
        IStrategy preProcessOrderPayment = new OrderPlacementPreProcessPaymentMethod();
        IStrategy preProcessOrderAmount = new OrderPlacementPreProcessAmount();

        IStrategy preProcessPurchaseUpdate = new PurchaseUpdatePreProcess();
        IStrategy preProcessReturn = new ItemReturnPreProcessRequest();

        IStrategy preProcessClientAccessCredential = new ClientPreProcessAccessCredential();
        IStrategy preProcessClientPersonalData = new ClientPreProcessPersonalData();
        IStrategy preProcessClientAddress = new ClientPreProcessAddress();
        IStrategy preProcessClientCard = new ClientPreProcessCards();

        IStrategy postProcessClientAddress = new ClientPostProcessAddress();
        IStrategy postProcessClientCard = new ClientPostProcessCards();
        IStrategy getStatesAndCountries = new RetrieveStatesAndCountries();
        IStrategy getClientAddresses = new ClientGetAddresses();
        IStrategy getClientCards = new ClientGetCards();

        // class mapping by operation
        ArrayList<IStrategy> beforeBookSave = new ArrayList<>();
        beforeBookSave.add(bookDataValidation);
        beforeBookSave.add(bookExistenceValidation);
        beforeBookSave.add(isbnValidation);
        beforeBookSave.add(preProcessAuthors);
        beforeBookSave.add(preProcessCategories);
        beforeBookSave.add(preProcessPublisher);
        ArrayList<IStrategy> afterBookSave = new ArrayList<>();

        ArrayList<IStrategy> beforeBookUpdate = new ArrayList<>();
        beforeBookUpdate.add(bookDataValidation);
        beforeBookUpdate.add(isbnValidation);
        beforeBookUpdate.add(preProcessAuthors);
        beforeBookUpdate.add(preProcessCategories);
        beforeBookUpdate.add(preProcessPublisher);
        ArrayList<IStrategy> afterBookUpdate = new ArrayList<>();

        ArrayList<IStrategy> beforeBookFind = new ArrayList<>();
        ArrayList<IStrategy> afterBookFind = new ArrayList<>();
        afterBookFind.add(postProcessAuthors);
        afterBookFind.add(postProcessCategories);

        ArrayList<IStrategy> beforeBookDelete = new ArrayList<>();
        ArrayList<IStrategy> afterBookDelete = new ArrayList<>();

        ArrayList<IStrategy> beforeOrderPlacement = new ArrayList<>();
        beforeOrderPlacement.add(preProcessOrderAddress);
        beforeOrderPlacement.add(preProcessOrderShipping);
        beforeOrderPlacement.add(preProcessOrderPayment);
        beforeOrderPlacement.add(preProcessOrderAmount);
        ArrayList<IStrategy> afterOrderPlacement = new ArrayList<>();

        ArrayList<IStrategy> beforeOrderUpdate = new ArrayList<>();
        beforeOrderUpdate.add(preProcessOrderAddress);
        beforeOrderUpdate.add(preProcessOrderShipping);
        beforeOrderUpdate.add(preProcessOrderPayment);
        beforeOrderUpdate.add(preProcessOrderAmount);
        ArrayList<IStrategy> afterOrderUpdate = new ArrayList<>();

        ArrayList<IStrategy> beforeOrderFind = new ArrayList<>();
        ArrayList<IStrategy> afterOrderFind = new ArrayList<>();

        ArrayList<IStrategy> beforeOrderDelete = new ArrayList<>();
        ArrayList<IStrategy> afterOrderDelete = new ArrayList<>();

        ArrayList<IStrategy> beforePurchaseSave = new ArrayList<>();
        ArrayList<IStrategy> beforePurchaseUpdate = new ArrayList<>();
        beforePurchaseUpdate.add(preProcessPurchaseUpdate);
        ArrayList<IStrategy> beforePurchaseFind = new ArrayList<>();
        ArrayList<IStrategy> beforePurchaseDelete = new ArrayList<>();

        ArrayList<IStrategy> beforeReturnUpdate = new ArrayList<>();
        beforeReturnUpdate.add(preProcessReturn);

        ArrayList<IStrategy> beforeClientSave = new ArrayList<>();
        beforeClientSave.add(preProcessClientAccessCredential);
        beforeClientSave.add(preProcessClientPersonalData);
        beforeClientSave.add(preProcessClientAddress);
        beforeClientSave.add(preProcessClientCard);
        ArrayList<IStrategy> beforeClientUpdate = new ArrayList<>();
        beforeClientUpdate.add(preProcessClientAccessCredential);
        beforeClientUpdate.add(preProcessClientPersonalData);
        beforeClientUpdate.add(preProcessClientAddress);
        beforeClientUpdate.add(preProcessClientCard);
        ArrayList<IStrategy> beforeClientFind = new ArrayList<>();
        beforeClientFind.add(getStatesAndCountries);
        ArrayList<IStrategy> beforeClientDelete = new ArrayList<>();

        ArrayList<IStrategy> afterClientSave = new ArrayList<>();
        afterClientSave.add(postProcessClientAddress);
        afterClientSave.add(postProcessClientCard);
        ArrayList<IStrategy> afterClientUpdate = new ArrayList<>();
        afterClientUpdate.add(postProcessClientAddress);
        afterClientUpdate.add(postProcessClientCard);
        ArrayList<IStrategy> afterClientFind = new ArrayList<>();
        afterClientFind.add(getClientAddresses);
        afterClientFind.add(getClientCards);
        ArrayList<IStrategy> afterClientDelete = new ArrayList<>();

        // strategy mapping by class
        HashMap<String, ArrayList<IStrategy>> beforeBookMap = new HashMap<>();
        beforeBookMap.put(create, beforeBookSave);
        beforeBookMap.put(update, beforeBookUpdate);
        beforeBookMap.put(delete, beforeBookDelete);
        beforeBookMap.put(find, beforeBookFind);

        HashMap<String, ArrayList<IStrategy>> afterBookMap = new HashMap<>();
        afterBookMap.put(create, afterBookSave);
        afterBookMap.put(update, afterBookUpdate);
        afterBookMap.put(delete, afterBookDelete);
        afterBookMap.put(find, afterBookFind);

        HashMap<String, ArrayList<IStrategy>> beforeOrderMap = new HashMap<>();
        beforeOrderMap.put(create, beforeOrderPlacement);
        beforeOrderMap.put(update, beforeOrderUpdate);
        beforeOrderMap.put(find, beforeOrderFind);
        beforeOrderMap.put(delete, beforeOrderDelete);

        HashMap<String, ArrayList<IStrategy>> afterOrderMap = new HashMap<>();
        afterOrderMap.put(create, afterOrderPlacement);
        afterOrderMap.put(update, afterOrderUpdate);
        afterOrderMap.put(find, afterOrderFind);
        afterOrderMap.put(delete, afterOrderDelete);

        HashMap<String, ArrayList<IStrategy>> beforePurchaseMap = new HashMap<>();
        beforePurchaseMap.put(create, beforePurchaseSave);
        beforePurchaseMap.put(update, beforePurchaseUpdate);
        beforePurchaseMap.put(find, beforePurchaseFind);
        beforePurchaseMap.put(delete, beforePurchaseDelete);

        HashMap<String, ArrayList<IStrategy>> beforeReturnMap = new HashMap<>();
        beforeReturnMap.put(update, beforeReturnUpdate);

        HashMap<String, ArrayList<IStrategy>> beforeClientMap = new HashMap<>();
        beforeClientMap.put(create, beforeClientSave);
        beforeClientMap.put(update, beforeClientUpdate);
        beforeClientMap.put(find, beforeClientFind);
        beforeClientMap.put(delete, beforeClientDelete);

        HashMap<String, ArrayList<IStrategy>> afterClientMap = new HashMap<>();
        afterClientMap.put(create, afterClientSave);
        afterClientMap.put(update, afterClientUpdate);
        afterClientMap.put(find, afterClientFind);
        afterClientMap.put(delete, afterClientDelete);

        // map mapping by class
        preprocessing = new HashMap<>();
        preprocessing.put(book, beforeBookMap);
        preprocessing.put(order, beforeOrderMap);
        preprocessing.put(purchaseDto, beforePurchaseMap);
        preprocessing.put(returnDto, beforeReturnMap);
        preprocessing.put(client, beforeClientMap);

        postprocessing = new HashMap<>();
        postprocessing.put(book, afterBookMap);
        postprocessing.put(order, afterOrderMap);
        postprocessing.put(client, afterClientMap);

        // DAO mapping by class
        persistence = new HashMap<>();
        persistence.put(book, new BookDAO());
        persistence.put(user, new UserDAO());
        persistence.put(order, new OrderDAO());
        persistence.put(address, new AddressDAO());
        persistence.put(card, new CreditCardDAO());
        persistence.put(client, new UserDAO());
    }

    public Result create(DomainObject object) {
        Result result = new Result();
        String objectClass = object.getClass().getSimpleName();
        ArrayList<IStrategy> preprocess = preprocessing.get(objectClass).get("create");
        for (IStrategy is : preprocess) {
            if (result.hasMsg("error"))
                break;
            is.process(object, result);
        }
        IStrategy strategy = new RetrieveStatesAndCountries();
        strategy.process(new AddressDTO(), result);
        if (!result.hasMsg("error")) {
            IDAO idao;
            if (objectClass.equals(OrderDTO.class.getSimpleName())) {
                OrderDTO order = (OrderDTO) object;
                idao = persistence.get(Address.class.getSimpleName());
                for (Address a : order.getNewAddresses()) {
                    idao.create(a, result);
                }
                idao = persistence.get(CardDTO.class.getSimpleName());
                for (CardDTO c : order.getCards()) {
                    if (c.getId() == null) {
                        CreditCard card = CardDTO.toCard(c);
                        card.setUser(order.getUser());
                        idao.create(card, result);
                        c.setId(card.getId());
                    }
                }
                idao = persistence.get(objectClass);
                Order o = OrderDTO.toOrder(order);
                idao.create(o, result);
                IStrategy processVouchers = new OrderPlacementProcessVoucher();
                processVouchers.process(order, result);
                idao = new OrderItemDAO();
                for (CartItemDTO item : order.getItems().getCartItems()) {
                    OrderItem orderItem = item.toOrderItem(o.getId());
                    idao.create(orderItem, result);
                }
            } else {
                idao = persistence.get(objectClass);
                idao.create(object, result);
                if (result.hasObject(User.class.getSimpleName())) {
                    ClientDTO client = (ClientDTO) object;
                    client.setUser((User) result.getObject(User.class.getSimpleName()).get(0));
                    object = client;
                }
                ArrayList<IStrategy> postprocess = postprocessing.get(objectClass).get("create");
                for (IStrategy is : postprocess) {
                    is.process(object, result);
                }
            }
        }
        return result;
    }

    public Result update(DomainObject object) {
        Result result = new Result();
        String objectClass = object.getClass().getSimpleName();
        if (objectClass.equals(LoginDTO.class.getSimpleName())) {
            LoginDTO dto = (LoginDTO) object;
            CartDAO dao = new CartDAO();
            if (dto.getCart().getId() != null)
                dao.update(object, result);
            else
                dao.create(object, result);
        } else {
            ArrayList<IStrategy> preprocess = preprocessing.get(objectClass).get("update");
            for (IStrategy is : preprocess) {
                if (result.hasMsg("error"))
                    break;
                is.process(object, result);
            }
            if (!result.hasMsg("error")) {
                IDAO idao;
                if (objectClass.equals(UpdatePurchaseDTO.class.getSimpleName())) {
                    Order order = (Order) result.getObject(Order.class.getSimpleName()).get(0);
                    OrderDAO orderDAO = new OrderDAO();
                    orderDAO.update(order, result);
                    orderDAO.getOrderUser(order, result);
                    idao = new OrderItemDAO();
                    for (OrderItem item : order.getItems()) {
                        item.setUserId(order.getUser().getId());
                        if (item.getModified() != null)
                            idao.update(item, result);
                    }
                    if (result.hasObject(Voucher.class.getSimpleName())) {
                        VoucherDAO voucherDAO = new VoucherDAO();
                        List<DomainObject> vouchers = result.getObject(Voucher.class.getSimpleName());
                        for (DomainObject v : vouchers) {
                            Voucher voucher = (Voucher) v;
                            ((Voucher) v).setUser(order.getUser().getId());
                            voucherDAO.create(voucher, result);
                        }
                    }
                } else if (objectClass.equals(ReturnDTO.class.getSimpleName())) {
                    OrderItemDAO itemDAO = new OrderItemDAO();
                    ReturnDTO dto = (ReturnDTO) object;
                    itemDAO.updateStatus(dto, result);
                    OrderDAO orderDAO = new OrderDAO();
                    orderDAO.updateOrderStatus(dto, result);
                } else {
                    idao = persistence.get(objectClass);
                    idao.update(object, result);
                    ArrayList<IStrategy> postprocess = postprocessing.get(objectClass).get("update");
                    for (IStrategy is : postprocess) {
                        is.process(object, result);
                    }
                }
            }
        }
        return result;
    }

    public Result delete(DomainObject object) {
        Result result = new Result();
        String objectClass = object.getClass().getSimpleName();
        ArrayList<IStrategy> preprocess = preprocessing.get(objectClass).get("delete");
        if (objectClass.equals(ClientDTO.class.getSimpleName())) {
            IDAO dao = new UserDAO();
            dao.delete(object, result);
        } else {
            for (IStrategy is : preprocess) {
                if (result.hasMsg("error"))
                    break;
                is.process(object, result);
            }
            if (!result.hasMsg("error")) {
                IDAO idao = persistence.get(objectClass);
                idao.delete(object, result);
                ArrayList<IStrategy> postprocess = postprocessing.get(objectClass).get("delete");
                for (IStrategy is : postprocess) {
                    is.process(object, result);
                }
            }
        }
        return result;
    }

    public Result find(DomainObject object) {
        Result result = new Result();
        String objectClass = object.getClass().getSimpleName();
        if (objectClass.equals(UserDTO.class.getSimpleName())) {
            UserDAO userDAO = new UserDAO();
            userDAO.getUserDTO(object, result);
            IStrategy strategy = new RetrieveStatesAndCountries();
            strategy.process(new AddressDTO(), result);
        } else if (objectClass.equals(Order.class.getSimpleName())) {
            Order order = (Order) object;
            OrderDAO dao = new OrderDAO();
            if (order.getUser() != null && order.getUser().getId() != null) {
                dao.findOrdersByClient(order, result);
                List<DomainObject> foundOrders = result.getObject(Order.class.getSimpleName());
                ArrayList<DomainObject> clientOrders = new ArrayList<>();
                OrderItemDAO itemDAO = new OrderItemDAO();
                if (foundOrders != null) {
                    for (DomainObject d : foundOrders) {
                        Order o = (Order) d;
                        itemDAO.getPurchaseItems(o, result);
                        clientOrders.add(o);
                    }
                }
                result.removeObject(Order.class.getSimpleName());
                result.putObject(Order.class.getSimpleName(), clientOrders);
            } else {
                dao.findAll(object, result);
                List<DomainObject> orders = result.getObject(Order.class.getSimpleName());
                if (orders != null) {
                    for (DomainObject d : orders) {
                        Order o = (Order) d;
                        dao.findOrderTotal(o, result);
                    }
                }
            }
        } else if (objectClass.equals(OrderItem.class.getSimpleName())) {
            OrderItem item = (OrderItem) object;
            OrderItemDAO itemDAO = new OrderItemDAO();
            if (item.getId() != null) {
                itemDAO.findItemById(item, result);
                AuthorDAO authorDAO = new AuthorDAO();
                Book b = item.getBook();
                authorDAO.findBookAuthors(b, result);
                item.setBook(b);
                result.putObject(OrderItem.class.getSimpleName(), item);
            } else {
                itemDAO.getPurchaseItems(object, result);
            }
        } else if (objectClass.equals(Voucher.class.getSimpleName())) {
            Voucher voucher = (Voucher) object;
            VoucherDAO voucherDAO = new VoucherDAO();
            voucherDAO.findAll(new UserDTO(voucher.getUser()), result);
        } else if (objectClass.equals(BookDTO.class.getSimpleName())) {
            BookDTO dto = (BookDTO) object;
            BookDAO bookDAO = new BookDAO();
            bookDAO.generalSearch(dto, result);
        } else if (objectClass.equals(BookChartDTO.class.getSimpleName())) {
            BookDAO bookDAO = new BookDAO();
            bookDAO.getChartData(object, result);
        } else if (objectClass.equals(LoginDTO.class.getSimpleName())) {
            IStrategy strategy = new LoginPreProcessData();
            strategy.process(object, result);
            if (!result.hasMsg("error")) {
                UserDAO userDAO = new UserDAO();
                userDAO.doLogin(object, result);
                if (result.hasObject(LoginDTO.class.getSimpleName())) {
                    strategy = new LoginPostProcessCart();
                    strategy.process(result.getObject(LoginDTO.class.getSimpleName()).get(0), result);
                } else {
                    result.setMsg("error", "Usu&aacute;rio e/ou senha inv&aacute;lidos!");
                }
            }
        } else {
            IStrategy strategy = new RetrieveStatesAndCountries();
            strategy.process(new AddressDTO(), result);
            ArrayList<IStrategy> preprocess = preprocessing.get(objectClass).get("find");
            for (IStrategy is : preprocess) {
                if (result.hasMsg("error"))
                    break;
                is.process(object, result);
            }

            if (!result.hasMsg("error")) {
                IDAO idao = persistence.get(objectClass);
                idao.findActive(object, result);
                ArrayList<IStrategy> postprocess = postprocessing.get(objectClass).get("find");
                if (objectClass.equals(ClientDTO.class.getSimpleName())) {
                    if (result.hasObject(User.class.getSimpleName())) {
                        ClientDTO dto = new ClientDTO();
                        dto.setUser((User) result.getObject(User.class.getSimpleName()).get(0));
                        for (IStrategy is : postprocess) {
                            is.process(dto, result);
                        }
                    }
                } else {
                    ArrayList<DomainObject> searchResult = result.getObject(Book.class.getSimpleName());
                    if (searchResult != null) {
                        for (IStrategy is : postprocess) {
                            for (DomainObject d : searchResult) {
                                is.process(d, result);
                            }
                        }
                    }
                }

            } else if (objectClass.equals(OrderDTO.class.getSimpleName())) {
                OrderDTO order = (OrderDTO) object;
                UserDAO dao = new UserDAO();
                dao.getUserDTO(new UserDTO(order.getUser()), result);
            }
        }
        return result;
    }
}