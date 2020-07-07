package vh;

import domain.*;
import dto.ClientDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;

public class ClientVH implements IViewHelper {
    @Override
    public DomainObject getObject(HttpServletRequest request) {
        String operation;
        ClientDTO client = new ClientDTO();
        if (request.getAttribute("operation") == null) {
            if (request.getParameter("operation") == null) {
                return client;
            }
            operation = request.getParameter("operation");
        } else {
            operation = request.getAttribute("operation").toString();
        }

        User user = new User();
        getAccessCredential(user, request);
        getUserData(user, request);
        setAddress(user, request);
        setCards(user, request);
        if (isValidParameter(request.getParameter("termsOfUse")))
            client.setSignedUseTerms(true);
        if (operation.equals("register"))
            client.setCreate(true);
        if (request.getSession().getAttribute("user") != null)
            user.setId(Integer.valueOf(request.getSession().getAttribute("user").toString()));
        client.setUser(user);
        return client;
    }

    @Override
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
                case "register":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/registration.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        request.getSession().setAttribute("user", result.getObject(User.class.getSimpleName()).get(0).getId());
                        response.sendRedirect("index.jsp");
                    }
                    break;
                case "profile":
                    dispatcher = request.getRequestDispatcher("/editClientPersonalData.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "credentials":
                    dispatcher = request.getRequestDispatcher("/alterPassword.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "address":
                    dispatcher = request.getRequestDispatcher("/editClientAddressData.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "cards":
                    dispatcher = request.getRequestDispatcher("/editClientBillingData.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "alterCards":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/editClientBillingData.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/profile");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "alterAddress":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/editClientAddressData.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/profile");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "alterProfile":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/editClientPersonalData.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/profile");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "deleteAccount":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/removeAccount.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        request.getSession().removeAttribute("user");
                        dispatcher = request.getRequestDispatcher("/index.jsp");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "alterPW":
                    if (result.hasMsg("error")) {
                        request.getSession().setAttribute("error", result.getMsg("error"));
                        dispatcher = request.getRequestDispatcher("/alterPassword.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        dispatcher = request.getRequestDispatcher("/profile");
                        dispatcher.forward(request, response);
                    }
                    break;
                case "signup":
                    dispatcher = request.getRequestDispatcher("/registration.jsp");
                    dispatcher.forward(request, response);
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

    private void setAddress(User user, HttpServletRequest request) {
        boolean flag = true;
        int i = 0;
        while (flag) {
            flag = false;
            Address address = null;
            if (isValidParameter(request.getParameter("address[" + i + "][nickname]"))) {
                address = new Address();
                address.setNickname(request.getParameter("address[" + i + "][nickname]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][id]"))) {
                address = initAddress(address);
                address.setId(Integer.valueOf(request.getParameter("address[" + i + "][id]").trim()));
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][place]"))) {
                address = initAddress(address);
                address.setPlace(request.getParameter("address[" + i + "][place]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][number]"))) {
                address = initAddress(address);
                address.setNumber(request.getParameter("address[" + i + "][number]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][neighborhood]"))) {
                address = initAddress(address);
                address.setNeighborhood(request.getParameter("address[" + i + "][neighborhood]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][zipCode]"))) {
                address = initAddress(address);
                address.setZipCode(request.getParameter("address[" + i + "][zipCode]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][compl]"))) {
                address = initAddress(address);
                address.setComplement(request.getParameter("address[" + i + "][compl]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][city]"))) {
                address = initAddress(address);
                address.setCity(request.getParameter("address[" + i + "][city]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][state]"))) {
                address = initAddress(address);
                address.setState(new State(Integer.valueOf(request.getParameter("address[" + i + "][state]").trim())));
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][country]"))) {
                address = initAddress(address);
                address.setCountry(new Country(Integer.valueOf(request.getParameter("address[" + i + "][country]").trim())));
                flag = true;
            }
            if (isValidParameter(request.getParameter("address[" + i + "][billing]"))) {
                address.setIsBilling(true);
            }
            if (isValidParameter(request.getParameter("address[" + i + "][shipping]"))) {
                address.setIsDelivery(true);
            }
            if (isValidParameter(request.getParameter("address[" + i + "][main]"))) {
                address.setIsMain(true);
            }
            if (address != null) {
                address.setSaveAddress(Boolean.TRUE);
                user.addAddress(address);
            }
            i++;
        }
    }

    private void setCards(User user, HttpServletRequest request) {
        int i = 0;
        boolean flag = true;
        while (flag) {
            flag = false;
            CreditCard card = new CreditCard();
            if (isValidParameter(request.getParameter("card[" + i + "][id]"))) {
                card.setId(Integer.valueOf(request.getParameter("card[" + i + "][id]").trim()));
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][company]"))) {
                card.setCardCompany(new CardCompany(Integer.valueOf(request.getParameter("card[" + i + "][company]").trim())));
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][expiration]"))) {
                card.setExpiration(request.getParameter("card[" + i + "][expiration]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][number]"))) {
                card.setCardNumber(request.getParameter("card[" + i + "][number]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][cvv]"))) {
                card.setCvv(request.getParameter("card[" + i + "][cvv]").trim());
                flag = true;
            }
            if (isValidParameter(request.getParameter("card[" + i + "][name]"))) {
                card.setHolderName(request.getParameter("card[" + i + "][name]").trim());
                flag = true;
            }
            if (flag) {
                user.addCard(card);
            }
            i++;
        }
    }

    private boolean isValidParameter(String value) {
        return value != null && !value.equals("") && !value.equals("null");
    }

    private void getAccessCredential(User user, HttpServletRequest request) {
        if (isValidParameter(request.getParameter("email"))) {
            if (user.getAccessCredential() == null)
                user.setAccessCredential(new AccessCredential());
            user.getAccessCredential().setUsername(request.getParameter("email").trim());
        }
        if (isValidParameter(request.getParameter("password"))) {
            if (user.getAccessCredential() == null)
                user.setAccessCredential(new AccessCredential());
            user.getAccessCredential().setPassword(request.getParameter("password").trim());
        }
        if (isValidParameter(request.getParameter("confirm"))) {
            if (user.getAccessCredential() == null)
                user.setAccessCredential(new AccessCredential());
            user.getAccessCredential().setConfirmPassword(request.getParameter("confirm").trim());
        }
    }

    private void getUserData(User user, HttpServletRequest request) {
        if (isValidParameter(request.getParameter("nickname"))) {
            user.setNickname(request.getParameter("nickname").trim());
        }
        if (isValidParameter(request.getParameter("fullname"))) {
            user.setName(request.getParameter("fullname").trim());
        }
        if (isValidParameter(request.getParameter("federalId"))) {
            user.setFederalId(request.getParameter("federalId").trim());
        }
        if (isValidParameter(request.getParameter("dob"))) {
            user.setBirthday(LocalDate.parse(request.getParameter("dob").trim()));
        }
        if (isValidParameter(request.getParameter("areacode"))) {
            user.setAreaCode(request.getParameter("areacode").trim());
        }
        if (isValidParameter(request.getParameter("phone"))) {
            user.setPhone(request.getParameter("phone").trim());
        }
    }
}
