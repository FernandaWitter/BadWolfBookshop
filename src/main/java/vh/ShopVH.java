package vh;

import domain.*;
import dto.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopVH implements IViewHelper {
    @Override
    public DomainObject getObject(HttpServletRequest request) {
        User user = new User();
        String operation;
        if (request.getAttribute("operation") == null) {
            if (request.getParameter("operation") == null)
                return user;
            operation = request.getParameter("operation");
        } else {
            operation = request.getAttribute("operation").toString();
        }
        if (operation.equals("search")) {
            BookDTO book = new BookDTO();
            if (isValidParameter(request.getParameter("q"))) ;
            book.setTitle(request.getParameter("q"));
            return book;
        } else if (operation.equals("order")) {
            OrderDTO order = new OrderDTO();
            order.setUser(Integer.valueOf(request.getSession().getAttribute("user").toString()));
            if (isValidParameter(request.getParameter("payAddrId")))
                order.addAddress(new AddressDTO(Integer.valueOf(request.getParameter("payAddrId")), "billing"));
            if (isValidParameter(request.getParameter("shipAddrId")))
                order.addAddress(new AddressDTO(Integer.valueOf(request.getParameter("shipAddrId")), "shipping"));
            if (isValidParameter(request.getParameter("shippingCost")))
                order.setShippingCost(Double.valueOf(request.getParameter("shippingCost")));
            if (isValidParameter(request.getParameter("grandTotal")))
                order.setAmountDue(Double.valueOf(request.getParameter("grandTotal")));
            setAddress(order, request, "pay");
            setAddress(order, request, "ship");
            setCards(order, request);
            setVouchers(order, request);
            setOrderItems(order, request);
            return order;
        } else if (operation.equals("find")) {
            return new Book();
        } else if (operation.equals("detail")) {
            if (isValidParameter(request.getAttribute("bookId").toString())) {
                int id = Integer.valueOf(request.getAttribute("bookId").toString());
                return new Book(id);
            }
        } else if (operation.equals("addToCart")) {
            int id, qty = 1;
            double price = 0;
            String cover = "", title = "";
            if (isValidParameter(request.getParameter("bookId"))) {
                id = Integer.valueOf(request.getParameter("bookId").toString());
                if (isValidParameter(request.getParameter("qty"))) {
                    qty = Integer.valueOf(request.getParameter("qty").toString());
                }
                if (isValidParameter(request.getParameter("price"))) {
                    price = Double.valueOf(request.getParameter("price").toString());
                }
                if (isValidParameter(request.getParameter("cover"))) {
                    cover = request.getParameter("cover");
                }
                if (isValidParameter(request.getParameter("title"))) {
                    title = request.getParameter("title");
                }
                return new CartItemDTO(id, qty, price, title, cover);
            }
        } else if (operation.equals("cart")) {
            return (CartDTO) request.getSession().getAttribute("cart");
        } else if (operation.equals("conclude") || operation.equals("history") || operation.equals("vouchers")) {
            UserDTO currentUser = null;
            if (request.getSession().getAttribute("user") != null) {
                currentUser = new UserDTO();
                currentUser.setId(Integer.valueOf(request.getSession().getAttribute("user").toString()));
            }
            return currentUser;
        } else if (operation.equals("updateQty") || operation.equals("remove")) {
            Integer id = null, qty = null;
            if (isValidParameter(request.getParameter("bookId"))) {
                String bookId = request.getParameter("bookId");
                id = Integer.valueOf(bookId);
                if (operation.equals("remove"))
                    qty = 0;
                else if (isValidParameter(request.getParameter("quantity"))) {
                    qty = Integer.valueOf(request.getParameter("quantity"));
                }
            }
            if (qty != null) {
                CartDTO cart = (CartDTO) request.getSession().getAttribute("cart");
                cart.updateCartItem(id, qty);
                return cart;
            }
        } else if (operation.equals("return")) {
            OrderItem item = new OrderItem();
            if (isValidParameter(request.getParameter("orderId")))
                item.setOrderId(Integer.valueOf(request.getParameter("orderId")));
            if (isValidParameter(request.getParameter("itemId")))
                item.setId(Integer.valueOf(request.getParameter("itemId")));
            return item;
        } else if (operation.equals("requestReturn")) {
            ReturnDTO item = new ReturnDTO();
            if (isValidParameter(request.getParameter("itemId")))
                item.setItemId(Integer.valueOf(request.getParameter("itemId")));
            if (isValidParameter(request.getParameter("returnOption")))
                item.setOperation(request.getParameter("returnOption"));
            if (isValidParameter(request.getParameter("returnReason")))
                item.setReturnReason(request.getParameter("returnReason"));
            return item;
        }
        return null;
    }

    public void setView(HttpServletRequest request, HttpServletResponse response, Result result) {
        RequestDispatcher dispatcher;
        request.setAttribute("result", result);
        String operation = "";
        if (request.getAttribute("operation") == null)
            operation = request.getParameter("operation");
        else
            operation = request.getAttribute("operation").toString();
        try {
            switch (operation) {
                case "detail":
                    dispatcher = request.getRequestDispatcher("/bookDetail.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "addToCart":
                    CartDTO cart = (CartDTO) request.getSession().getAttribute("cart");
                    if (cart == null)
                        cart = new CartDTO();
                    CartItemDTO item = (CartItemDTO) request.getAttribute("cartItem");
                    cart.addItem(item);
                    request.getSession().setAttribute("cart", cart);
                    response.sendRedirect("/badWolfBookshop/index.jsp");
                    break;
                case "cart":
                    CartDTO newCart = (CartDTO) request.getAttribute("cart");
                    request.getSession().setAttribute("cart", newCart);
                    response.sendRedirect("badWolfBookshop/cart.jsp");
                    break;
                case "conclude":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("last", "cart");
                        response.sendRedirect("/badWolfBookshop/login.jsp");
                    } else {
                        dispatcher = request.getRequestDispatcher("/checkout.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "order":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/book/conclude");
                        dispatcher.forward(request, response);
                    } else {
                        request.getSession().removeAttribute("cart");
                        request.getSession().removeAttribute(OrderDTO.class.getSimpleName());
                        dispatcher = request.getRequestDispatcher("/transactionConcluded.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "updateQty":
                case "remove":
                    if (request.getAttribute("cart") != null) {
                        CartDTO updatedCart = (CartDTO) request.getAttribute("cart");
                        request.getSession().setAttribute("cart", updatedCart);
                    }
                    response.sendRedirect("/badWolfBookshop/cart.jsp");
                    break;
                case "history":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/index.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/orderHistory.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "return":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/history");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/returnItem.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "requestReturn":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/return");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/history");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "vouchers":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/index.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/vouchers.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "search":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/index.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/bookSearch.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                default:
                    dispatcher = request.getRequestDispatcher("/home.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Address initAddress(Address address) {
        if (address == null)
            return new Address();
        return address;
    }

    private void setAddress(OrderDTO order, HttpServletRequest request, String prefix) {
        Address address = null;
        if (isValidParameter(request.getParameter(prefix + "AddNickname"))) {
            address = new Address();
            address.setNickname(request.getParameter(prefix + "AddNickname"));
        }
        if (isValidParameter(request.getParameter(prefix + "AddPlace"))) {
            address = initAddress(address);
            address.setPlace(request.getParameter(prefix + "AddPlace"));
        }
        if (isValidParameter(request.getParameter(prefix + "AddNumber"))) {
            address = initAddress(address);
            address.setNumber(request.getParameter(prefix + "AddNumber"));
        }
        if (isValidParameter(request.getParameter(prefix + "AddNeighborhood"))) {
            address = initAddress(address);
            address.setNeighborhood(request.getParameter(prefix + "AddNeighborhood"));
        }
        if (isValidParameter(request.getParameter(prefix + "AddZipCode"))) {
            address = initAddress(address);
            address.setZipCode(request.getParameter(prefix + "AddZipCode"));
        }
        if (isValidParameter(request.getParameter(prefix + "AddCompl"))) {
            address = initAddress(address);
            address.setComplement(request.getParameter(prefix + "AddCompl"));
        }
        if (isValidParameter(request.getParameter(prefix + "AddCity"))) {
            address = initAddress(address);
            address.setCity(request.getParameter(prefix + "AddCity"));
        }
        if (isValidParameter(request.getParameter(prefix + "AddState"))) {
            address = initAddress(address);
            address.setState(new State(Integer.valueOf(request.getParameter(prefix + "AddState"))));
        }
        if (isValidParameter(request.getParameter(prefix + "AddCountry"))) {
            address = initAddress(address);
            address.setCountry(new Country(Integer.valueOf(request.getParameter(prefix + "AddCountry"))));
        }
        if (address != null) {
            if (isValidParameter(request.getParameter(prefix + "AddSave"))) {
                address.setSaveAddress(true);
            }
            if (prefix.equals("pay"))
                address.setIsBilling(true);
            if (prefix.equals("ship"))
                address.setIsDelivery(true);
            address.setUser(Integer.valueOf(request.getSession().getAttribute("user").toString()));
            order.addNewAddress(address);
        }
    }

    private void setCards(OrderDTO order, HttpServletRequest request) {
        if (request.getParameterValues("usedCardsList[]") != null) {
            String[] usedCards = request.getParameterValues("usedCardsList[]");
            String[] usedAmounts = request.getParameterValues("usedCardsAmount[]");
            for (int i = 0; i < usedCards.length; i++) {
                CardDTO card = new CardDTO(Integer.valueOf(usedCards[i]));
                String amount = usedAmounts[i];
                amount.replaceAll(",", ".");
                card.setAmountPaid(Double.valueOf(amount));
                order.addCard(card);
            }
        }
        int i = 0;
        boolean flag = true;
        while (flag) {
            flag = false;
            CardDTO card = new CardDTO();
            if (isValidParameter(request.getParameter("card[" + i + "][cardCompany]"))) {
                card.setCompany(Integer.valueOf(request.getParameter("card[" + i + "][cardCompany]")));
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][cardExpiration]"))) {
                card.setExpiration(request.getParameter("card[" + i + "][cardExpiration]"));
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][cardNumber]"))) {
                card.setNumber(request.getParameter("card[" + i + "][cardNumber]"));
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][cvv]"))) {
                card.setCvv(request.getParameter("card[" + i + "][cvv]"));
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][cardName]"))) {
                card.setHolder(request.getParameter("card[" + i + "][cardName]"));
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][saveCard]"))) {
                card.setSaveCard(true);
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][amount]"))) {
                card.setAmountPaid(Double.valueOf(request.getParameter("card[" + i + "][amount]")));
                flag = true;
            }
            if (flag) {
                if (card.getSaveCard() != true)
                    card.setSaveCard(false);
                order.addCard(card);
            }
            i++;
        }
    }

    public void setVouchers(OrderDTO order, HttpServletRequest request) {
        if (request.getParameterValues("vouchers[]") != null) {
            String[] voucherIds = request.getParameterValues("vouchers[]");
            for (String v : voucherIds) {
                int voucherId = Integer.valueOf(v);
                Voucher voucher = new Voucher(voucherId);
                voucher.setAmount(Double.valueOf(request.getParameter("voucherAmount" + voucherId)));
                order.addVoucher(voucher);
            }
        }
    }

    private void setOrderItems(OrderDTO order, HttpServletRequest request) {
        order.setItems((CartDTO) request.getSession().getAttribute("cart"));
    }

    private boolean isValidParameter(String value) {
        return value != null && !value.equals("") && !value.equals("null");
    }
}
