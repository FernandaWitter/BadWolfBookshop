<%@ page import="dto.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.*" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <title>Bad Wolf Bookshop</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="e-commerce site well design with responsive view."/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/font-awesome/css/font-awesome.css"
          rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/resources/css/googleFonts.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/stylesheet.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.css" type="text/css"
          rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.transitions.css"
          type="text/css" rel="stylesheet" media="screen"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/javascript/jquery-2.1.1.min.js"></script>
</head>
<body class="index">
<div class="preloader loader" style="display: block;">
    <img src="${pageContext.request.contextPath}/resources/image/loader-circle.gif" alt="#"/>
</div>
<header>
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="top-left pull-left">
                        <div class="language">
                            <form action="#" method="post" enctype="multipart/form-data" id="language">
                                <div class="btn-group">
                                    <button class="btn btn-link dropdown-toggle" data-toggle="dropdown"
                                            aria-expanded="false"> English <span class="caret"></span></button>
                                    <ul class="dropdown-menu">
                                        <li><a href="#"> Portugu&ecirc;s</a></li>
                                        <li><a href="#"> English</a></li>
                                        <li><a href="#"> Espa&ntilde;ol</a></li>
                                    </ul>
                                </div>
                            </form>
                        </div>
                        <div class="currency">
                            <form action="#" method="post" enctype="multipart/form-data" id="currency">
                                <div class="btn-group">
                                    <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                                        <strong>USD</strong> <span class="caret"></span></button>
                                    <ul class="dropdown-menu">
                                        <li><a href="#">Real</a></li>
                                        <li><a href="#">USD</a></li>
                                        <li><a href="#">Euro</a></li>
                                    </ul>
                                </div>
                            </form>
                        </div>
                        <div class="wel-come-msg"> Seja bem-vindx!</div>
                    </div>
                    <div class="top-right pull-right">
                        <div id="top-links" class="nav pull-right">
                            <ul class="list-inline">
                                <li class="dropdown">
                                    <a href="#" title="Conta" class="dropdown-toggle" data-toggle="dropdown">
                                        <i class="fa fa-user" aria-hidden="true"></i>
                                        <span>Perfil</span>
                                        <span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <%if (request.getSession().getAttribute("user") == null) {%>
                                        <li><a href="${pageContext.request.contextPath}/signup">Cadastrar</a></li>
                                        <li><a href="login.jsp">Entrar</a></li>
                                        <%} else {%>
                                        <li><a href="${pageContext.request.contextPath}/history">Hist&oacute;rico de Compras</a></li>
                                        <li><a href="${pageContext.request.contextPath}/vouchers">Cupons Dispon&iacute;veis</a></li>
                                        <li><a href="${pageContext.request.contextPath}/profile">Configura&ccedil;&otilde;es</a></li>
                                        <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
                                        <%}%>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#" id="wishlist-total" title="Lista de Desejos (0)">
                                        <i class="fa fa-heart" aria-hidden="true"></i>
                                        <span>Lista de Desejos</span><span> (0)</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="header-inner">
            <div class="col-sm-3 col-xs-3 header-left">
                <div id="logo">
                    <a href="${pageContext.request.contextPath}/index.jsp">
                        <img src="${pageContext.request.contextPath}/resources/image/logo.jpg" title="E-Commerce"
                        alt="E-Commerce" class="img-responsive"/>
                    </a>
                </div>
            </div>
            <div class="col-sm-9 col-xs-9 header-right">
                <div id="search" class="input-group">
                    <form action="search" method="get">
                        <input type="text" name="q" id="q" class="form-control input-lg" aria-label="Caixa de busca"/>
                        <span class="input-group-btn">
                          <button type="submit" class="btn btn-default btn-lg"><span>Buscar</span></button>
                        </span>
                    </form>
                </div>
                <div id="cart" class="btn-group btn-block">
                    <a type="button" class="btn btn-inverse btn-block btn-lg cart-dropdown-button" href="${pageContext.request.contextPath}/cart.jsp">
                        <span id="cart-total">
                            <i class="fa fa-shopping-cart" style="color: #189b79;"></i>
                            <span>Carrinho</span>
                            <br>
                            <div id="cartItems">
                                <%
                                    CartDTO cart = (CartDTO) request.getSession().getAttribute("cart");
                                    if (cart == null)
                                        out.print("0 item(s) - $0.00");
                                    else
                                        out.print(cart.getNumberOfItems() + " item(s) - $" + String.format("%.2f", cart.getTotal()));
                                %>
                            </div>
                        </span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>
<nav id="menu" class="navbar">
    <div class="nav-inner">
        <div class="navbar-header"><span id="category" class="visible-xs">Categorias</span>
            <button type="button" class="btn btn-navbar navbar-toggle"><i class="fa fa-bars"></i></button>
        </div>
        <div class="navbar-collapse">
            <ul class="main-navigation">
                <li>
                    <div class="m-l-20 m-r-20">
                        <a href="index.jsp" class="parent"><button type="button" style="background: transparent"><span>IN&Iacute;CIO</span></button></a>
                    </div>
                </li>
                <li>
                    <div class="m-l-20 m-r-20">
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros Nacionais" value="nacional"/>
                            <a class="parent"><button type="submit" class="" style="background: transparent"><span>NACIONAIS</span></button></a>
                        </form>
                    </div>
                </li>
                <li>
                    <div class="m-l-20 m-r-20">
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros Importados" value="importado"/>
                            <a class="parent"><button type="submit" class="" style="background: transparent"><span>IMPORTADOS</span></button></a>
                        </form>
                    </div>
                </li>
                <li>
                    <div class="m-l-20 m-r-20">
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros de Não-Ficção" value="não-ficção"/>
                            <a class="parent"><button type="submit" class="" style="background: transparent"><span>N&Atilde;O-FIC&Ccedil;&Atilde;O</span></button></a>
                        </form>
                    </div>
                </li>
                <li>
                    <div class="m-l-20 m-r-20">
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros Didáticos" value="didático"/>
                            <a class="parent"><button type="submit" class="" style="background: transparent"><span>DID&Aacute;TICOS</span></button></a>
                        </form>
                    </div>
                </li>
                <li>
                    <div class="m-l-20 m-r-20">
                        <a href="about.jsp"><button type="button" style="background: transparent"><span>SOBRE N&Oacute;S</span></button></a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>
<%
    if (request.getSession().getAttribute("error") != null) {
        out.print("<div class=\"row m-t-40 text-center\">");
        out.print("<p style=\"color:red; font-weight: bold;\"><strong>");
        out.print(request.getSession().getAttribute("error") + "<br/>");
        out.print("</strong></p><br/>");
        out.print("</div>");
        request.getSession().removeAttribute("error");
    }
    if (request.getAttribute("result") != null) {
        Result result = (Result) request.getAttribute("result");
        if (result.hasObject(UserDTO.class.getSimpleName())) {
            UserDTO userDTO = (UserDTO) result.getObject(UserDTO.class.getSimpleName()).get(0);
%>
<div class="container">
    <div class="row m-t-40">
        <div id="column-left" class="col-sm-3 hidden-xs column-left">
            <div class="Categories left-sidebar-widget" style="position: absolute">
                <div class="columnblock-title">Finalizar Compra</div>
            </div>
        </div>
        <form method="post">
            <div class="col-sm-9" id="content">
                <div id="accordion" class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="accordion-toggle collapsed" data-parent="#accordion"
                                   data-toggle="collapse" href="#collapse-payment-address"
                                   aria-expanded="false">Passo 1: Endere&ccedil;o de Cobran&ccedil;a
                                    <i class="fa fa-caret-down"></i>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse-payment-address" role="heading" class="panel-collapse collapse"
                             aria-expanded="false" style="height: 0px;">
                            <div class="panel-body">
                                <div class="form-horizontal">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" checked="checked" value="existing"
                                                   name="payment_address" data-id="payment-existing">
                                            Quero usar um endere&ccedil;o j&aacute; cadastrado:</label>
                                    </div>
                                    <div id="payment-existing">
                                        <select class="form-control" name="payAddrId" id="payAddrId">
                                            <option value=""> ===== Selecione =====</option>
                                            <%
                                                OrderDTO order = null;
                                                if (request.getSession().getAttribute(OrderDTO.class.getSimpleName()) != null)
                                                    order = (OrderDTO) request.getSession().getAttribute(OrderDTO.class.getSimpleName());
                                                if (userDTO.getAddresses().size() > 0) {
                                                    for (AddressDTO address : userDTO.getAddresses()) {
                                                        boolean selected = false;
                                                        if (address.getIsBilling()) {
                                                            if (order != null && order.getAddresses().size() > 0) {
                                                                for (AddressDTO a : order.getAddresses()) {
                                                                    if (a.getIsBilling() != null && a.getIsBilling() && address.getId() == a.getId()) {
                                                                        out.print("<option selected=\"selected\" value=\"" + address.getId()
                                                                                + "\" label=\"" + address.getNickname() + "\"></option>");
                                                                        selected = true;
                                                                    }
                                                                }

                                                            }
                                                            if (!selected && address.getIsMain()) {
                                                                out.print("<option selected=\"selected\" value=\"" + address.getId()
                                                                        + "\" label=\"" + address.getNickname() + "\"></option>");
                                                                selected = true;
                                                            } else
                                                                out.print("<option value=\"" + address.getId()
                                                                        + "\" label=\"" + address.getNickname() + "\"></option>");
                                                        }
                                                    }
                                                }
                                                Address billing = null, shipping = null;
                                                if (order != null) {
                                                    for (Address a : order.getNewAddresses()) {
                                                        if (a.getIsBilling() != null && a.getIsBilling())
                                                            billing = a;
                                                        if (a.getIsDelivery() != null && a.getIsDelivery())
                                                            shipping = a;
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" value="new" name="payment_address" data-id="payment-new">
                                            Quero enviar para um novo endere&ccedil;o:</label>
                                    </div>
                                    <br>
                                    <div id="payment-new" style="display: none;">
                                        <p>* Campos obrigat&oacute;rios</p>
                                        <fieldset>
                                            <div class="form-group">
                                                <label for="payAddNickname" class="col-sm-2 control-label">Identificador</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="payAddNickname"
                                                           placeholder="Escolha um nome para identificar esse endere&ccedil;o"
                                                           value="<%out.print(billing != null ? billing.getNickname() : "");%>"
                                                           name="payAddNickname">
                                                </div>
                                            </div>
                                            <div class="form-group required">
                                                <label for="payAddPlace" class="col-sm-2 control-label">Logradouro*</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="payAddPlace"
                                                           placeholder="ex. Rua, Avenida, Travessa..." name="payAddPlace"
                                                           value="<%out.print(billing != null ? billing.getPlace() : "");%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="payAddNumber" class="col-sm-2 control-label">N&uacute;mero*</label>
                                                <div class="col-sm-2">
                                                    <input type="text" class="form-control" id="payAddNumber"
                                                           placeholder="ex. 51" name="payAddNumber"
                                                           value="<%out.print(billing != null ? billing.getNumber() : "");%>">
                                                </div>
                                                <label for="payAddNeighborhood" class="col-sm-2 control-label">Bairro</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" id="payAddNeighborhood"
                                                           placeholder="ex. Centro" name="payAddNeighborhood"
                                                           value="<%out.print(billing != null ? billing.getNeighborhood() : "");%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="payAddZipCode" class="col-sm-2 control-label">CEP*</label>
                                                <div class="col-sm-2">
                                                    <input type="text" class="form-control" id="payAddZipCode"
                                                           placeholder="ex. 99999-999" name="payAddZipCode"
                                                           value="<%out.print(billing != null ? billing.getZipCode() : "");%>">
                                                </div>
                                                <label for="payAddCompl" class="col-sm-2 control-label">Complemento</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" id="payAddCompl"
                                                           placeholder="ex. Apto 10" name="payAddCompl"
                                                           value="<%out.print(billing != null ? billing.getComplement() : "");%>">
                                                </div>
                                            </div>
                                            <div class="form-group required">
                                                <label for="payAddCity" class="col-sm-2 control-label">Cidade*</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="payAddCity"
                                                           placeholder="ex. S&atilde;o Paulo" name="payAddCity"
                                                           value="<%out.print(billing != null ? billing.getCity() : "");%>">
                                                </div>
                                            </div>
                                            <div class="form-group required">
                                                <label for="payAddState" class="col-sm-2 control-label">Estado*</label>
                                                <div class="col-sm-4">
                                                    <select class="form-control" id="input-zone" name="payAddState" id="payAddState">
                                                        <%
                                                            int state = 0;
                                                            if (billing != null && billing.getState() != null && billing.getState().getCode() != null)
                                                                state = billing.getState().getCode();
                                                        %>
                                                        <option value=""> ===== Selecione =====</option>
                                                        <%
                                                            if (result != null && result.hasObject(State.class.getSimpleName())) {
                                                                List<DomainObject> states = result.getObject(State.class.getSimpleName());
                                                                for (DomainObject d : states) {
                                                                    String selected = "";
                                                                    State s = (State) d;
                                                                    if (state == s.getCode()) {
                                                                        selected = " selected";
                                                                    }
                                                                    out.print("<option value=\"" + s.getCode() + "\"" + selected + ">" + s.getName() + "</option>");
                                                                }
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                                <label for="payAddCountry" class="col-sm-1 control-label">Pa&iacute;s*</label>
                                                <div class="col-sm-5">
                                                    <select class="form-control" id="payAddCountry" name="payAddCountry">
                                                        <option value=""> ===== Selecione =====</option>
                                                        <%
                                                            if (result != null && result.hasObject(Country.class.getSimpleName())) {
                                                                List<DomainObject> countries = result.getObject(Country.class.getSimpleName());
                                                                for (DomainObject d : countries) {
                                                                    String selected = "";
                                                                    Country c = (Country) d;
                                                                    if (billing != null && billing.getCountry() != null && billing.getCountry().getCode() == c.getCode()) {
                                                                        selected = " selected";
                                                                    }
                                                                    out.print("<option value=\"" + c.getCode() + "\"" + selected + ">" + c.getName() + "</option>");
                                                                }
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label" for="payAddSave">Salvar Endere&ccedil;o?</label>
                                                <input type="checkbox" class="col-sm-1" id="payAddSave" name="payAddSave"
                                                    <%
                                                   if(billing == null)
                                                       out.print("checked");
                                                   else{
                                                       if(billing.getSaveAddress())
                                                            out.print("checked");
                                                   }
                                                    %>>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                <script type="text/javascript">
                                    $('input[name=\'payment_address\']').on('change', function () {
                                        if (this.value == 'new') {
                                            $('#payment-existing').hide();
                                            $('#payAddrId').val('');
                                            $('#payment-new').show();
                                        } else {
                                            $('#payment-existing').show();
                                            $('#payAddCountry').val('');
                                            $('#payAddCity').val('');
                                            $('#payAddCompl').val('');
                                            $('#payAddZipCode').val('');
                                            $('#payAddNeighborhood').val('');
                                            $('#payAddNumber').val('');
                                            $('#payAddPlace').val('');
                                            $('#payAddNickname').val('');
                                            $('#payAddState').val('');
                                            $('#payment-new').hide();
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="accordion-toggle collapsed" data-parent="#accordion" data-toggle="collapse"
                                   href="#collapse-shipping-address" aria-expanded="false">Passo 2: Endere&ccedil;o de Entrega
                                    <i class="fa fa-caret-down"></i>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse-shipping-address" role="heading" class="panel-collapse collapse"
                             aria-expanded="false" style="height: 0px;">
                            <div class="panel-body">
                                <div class="form-horizontal">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" checked="checked" value="existing"
                                                   name="shipping_address" data-id="shipping-existing">
                                            Quero usar um endere&ccedil;o j&aacute; cadastrado:</label>
                                    </div>
                                    <div id="shipping-existing">
                                        <select class="form-control" name="shipAddrId" id="shipAddrId">
                                            <option value=""> ===== Selecione =====</option>
                                            <%
                                                if (userDTO.getAddresses().size() > 0) {
                                                    for (AddressDTO address : userDTO.getAddresses()) {
                                                        boolean selected = false;
                                                        if (address.getIsShipping()) {
                                                            if (order != null && order.getAddresses().size() > 0) {
                                                                for (AddressDTO a : order.getAddresses()) {
                                                                    if (a.getIsShipping() != null && a.getIsShipping() && address.getId() == a.getId()) {
                                                                        out.print("<option selected=\"selected\" value=\"" + address.getId()
                                                                                + "\" label=\"" + address.getNickname() + "\"></option>");
                                                                        selected = true;
                                                                    }
                                                                }

                                                            }
                                                            if (!selected && address.getIsMain()) {
                                                                out.print("<option selected=\"selected\" value=\"" + address.getId()
                                                                        + "\" label=\"" + address.getNickname() + "\"></option>");
                                                                selected = true;
                                                            } else
                                                                out.print("<option value=\"" + address.getId()
                                                                        + "\" label=\"" + address.getNickname() + "\"></option>");
                                                        }
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" value="new" name="shipping_address" data-id="shipping-new">
                                            Quero enviar para um novo endere&ccedil;o:</label>
                                    </div>
                                    <br>
                                    <div id="shipping-new" style="display: none;">
                                        <p>* Campos obrigat&oacute;rios</p>
                                        <fieldset>
                                            <div class="form-group">
                                                <label for="shipAddNickname" class="col-sm-2 control-label">Identificador</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="shipAddNickname"
                                                           placeholder="Escolha um nome para identificar esse endere&ccedil;o"
                                                           value="<%out.print(shipping != null ? shipping.getNickname() : "");%>"
                                                           name="shipAddNickname">
                                                </div>
                                            </div>
                                            <div class="form-group required">
                                                <label for="shipAddPlace" class="col-sm-2 control-label">Logradouro*</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="shipAddPlace"
                                                           placeholder="ex. Rua, Avenida, Travessa..." name="shipAddPlace"
                                                           value="<%out.print(shipping != null ? shipping.getPlace() : "");%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="shipAddNumber" class="col-sm-2 control-label">N&uacute;mero*</label>
                                                <div class="col-sm-2">
                                                    <input type="text" class="form-control" id="shipAddNumber"
                                                           placeholder="ex. 51" name="shipAddNumber"
                                                           value="<%out.print(shipping != null ? shipping.getNumber() : "");%>">
                                                </div>
                                                <label for="shipAddNeighborhood" class="col-sm-2 control-label">Bairro</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" id="shipAddNeighborhood"
                                                           placeholder="ex. Centro" name="shipAddNeighborhood"
                                                           value="<%out.print(shipping != null ? shipping.getNeighborhood() : "");%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="shipAddZipCode" class="col-sm-2 control-label">CEP*</label>
                                                <div class="col-sm-2">
                                                    <input type="text" class="form-control" id="shipAddZipCode"
                                                           placeholder="ex. 99999-999" name="shipAddZipCode"
                                                           value="<%out.print(shipping != null ? shipping.getZipCode() : "");%>">
                                                </div>
                                                <label for="shipAddCompl" class="col-sm-2 control-label">Complemento</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" id="shipAddCompl"
                                                           placeholder="ex. Apto 10" name="shipAddCompl"
                                                           value="<%out.print(shipping != null ? shipping.getComplement() : "");%>">
                                                </div>
                                            </div>
                                            <div class="form-group required">
                                                <label for="shipAddCity" class="col-sm-2 control-label">Cidade*</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="shipAddCity"
                                                           placeholder="ex. S&atilde;o Paulo" name="shipAddCity"
                                                           value="<%out.print(shipping != null ? shipping.getCity() : "");%>">
                                                </div>
                                            </div>
                                            <div class="form-group required">
                                                <label for="shipAddState" class="col-sm-2 control-label">Estado*</label>
                                                <div class="col-sm-4">
                                                    <select class="form-control" id="shipAddState" name="shipAddState">
                                                        <%
                                                            int stateb = 0;
                                                            if (shipping != null && shipping.getState() != null && shipping.getState().getCode() != null)
                                                                stateb = shipping.getState().getCode();
                                                        %>
                                                        <option value=""> ===== Selecione =====</option>
                                                        <%
                                                            if (result != null && result.hasObject(State.class.getSimpleName())) {
                                                                List<DomainObject> states = result.getObject(State.class.getSimpleName());
                                                                for (DomainObject d : states) {
                                                                    String selected = "";
                                                                    State s = (State) d;
                                                                    if (stateb == s.getCode()) {
                                                                        selected = " selected";
                                                                    }
                                                                    out.print("<option value=\"" + s.getCode() + "\"" + selected + ">" + s.getName() + "</option>");
                                                                }
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                                <label for="shipAddCountry" class="col-sm-1 control-label">Pa&iacute;s*</label>
                                                <div class="col-sm-5">
                                                    <select class="form-control" id="shipAddCountry" name="shipAddCountry">
                                                        <option value=""> ===== Selecione =====</option>
                                                        <%
                                                            if (result != null && result.hasObject(Country.class.getSimpleName())) {
                                                                List<DomainObject> countries = result.getObject(Country.class.getSimpleName());
                                                                for (DomainObject d : countries) {
                                                                    String selected = "";
                                                                    Country c = (Country) d;
                                                                    if (shipping != null && shipping.getCountry() != null && shipping.getCountry().getCode() == c.getCode()) {
                                                                        selected = " selected";
                                                                    }
                                                                    out.print("<option value=\"" + c.getCode() + "\"" + selected + ">" + c.getName() + "</option>");
                                                                }
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label" for="shipAddSave">Salvar Endere&ccedil;o?</label>
                                                <input type="checkbox" class="col-sm-1" id="shipAddSave" name="shipAddSave" checked>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                <script type="text/javascript">
                                    $('input[name=\'shipping_address\']').on('change', function () {
                                        if (this.value == 'new') {
                                            $('#shipping-existing').hide();
                                            $('#shipping-new').show();
                                        } else {
                                            $('#shipping-existing').show();
                                            $('#shipping-new').hide();
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="accordion-toggle collapsed" data-parent="#accordion" data-toggle="collapse"
                                   href="#collapse-shipping-method" aria-expanded="false">Passo 3: Frete
                                    <i class="fa fa-caret-down"></i>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse-shipping-method" role="heading" class="panel-collapse collapse"
                             aria-expanded="false" style="height: 0px;">
                            <div class="panel-body">
                                <p>Por favor selecione o tipo de frete a ser utilizado neste pedido.</p>
                                <div class="radio">
                                    <label>
                                        <input type="radio" value="5" name="shipping-method">
                                        Entrega Padr&atilde;o (10-20 dias &uacute;teis) - $5.00</label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" value="25" name="shipping-method">
                                        Entrega Expressa (3-5 dias &uacute;teis) - $25.00</label>
                                </div>
                                <p><strong>Se desejar, acrescente observa&ccedil;&otilde;es sobre sua entrega:</strong>
                                </p>
                                <p>
                                    <textarea class="form-control" rows="8" name="comment"></textarea>
                                </p>
                                <script type="text/javascript">
                                    $('input[name=\'shipping-method\']').on('change', function () {
                                        var shipping = parseFloat($("input[name='shipping-method']:checked").val());
                                        var subtotal = parseFloat($('#subtotal').val());
                                        var tax = parseFloat($('#tax').val());
                                        var total = shipping + subtotal + tax;
                                        $('#shippingCost').val(shipping);
                                        shipping = shipping.toFixed(2);
                                        $('#shipping').html('$' + shipping);
                                        $('#grandTotal').val(total);
                                        total = parseFloat(total).toFixed(2);
                                        console.log('total: ' + total);
                                        $('#orderTotal').html('$' + total);
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="accordion-toggle collapsed" data-parent="#accordion" data-toggle="collapse"
                                   href="#collapse-payment-method" aria-expanded="false">Passo 4: Forma de Pagamento
                                    <i class="fa fa-caret-down"></i>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse-payment-method" role="heading" class="panel-collapse collapse"
                             aria-expanded="false" style="height: 0px;">
                            <div class="panel-body">
                                <p>Por favor selecione a forma de pagamento a ser utilizada.</p>
                                <p>Se voc&ecirc; possuir cupons de troca ou devolu&ccedil;&atilde;o dispon&iacute;veis, eles aparecer&atilde;o aqui. </p>
                                <p>Se o valor do cupom ultrapassar o valor da compra, o saldo restante permanecer&aacute;
                                    dispon&iacute;vel para transa&ccedil;&otilde;es futuras.</p>
                                <div class="panel-body">
                                    <div class="row">
                                        <%
                                            if (userDTO.getVouchers().size() > 0) {
                                                for (Voucher v : userDTO.getVouchers()) {
                                                    out.print("<div class=\"col-sm-4\">");
                                                    out.print("<div class=\"category-page-wrapper selected-payment\" style=\"background-color: #189b79; color: white;\">");
                                                    out.print("<h2 class=\"text-white\" style=\"color: white;\">Cupom de Troca</h2>");
                                                    out.print("<p>Gerado em: " + DateTimeFormatter.ofPattern("dd/MM/yyyy").format(v.getCreationDate()) + "</p>");
                                                    if (v.getExpirationDate() == null)
                                                        out.print("<p>V&aacute;lido at&eacute;: Indefinido</p>");
                                                    else
                                                        out.print("<p>V&aacute;lido at&eacute;: " + DateTimeFormatter.ofPattern("dd/MM/yyyy").format(v.getExpirationDate()) + "</p>");
                                                    out.print("<p>Valor total: <strong>$" + String.format("%.2f", v.getAmount()) + "</strong></p>");
                                                    out.print("<div id=\"btnDiv" + v.getId() + "\"><button type=\"button\" class=\"btn btn-warning\" onclick=\"useVoucher(" + v.getId() + ")\" name=\"useVoucher" + v.getId() + "\">Utilizar Cupom</button></div>");
                                                    out.print("<input type=\"hidden\" name=\"voucherAmount" + v.getId() + "\" value=\"" + v.getAmount() + "\">");
                                                    out.print("</div>");
                                                    out.print("</div>");
                                                }
                                            }
                                            out.print("<div id=\"usedVouchers\"></div>");
                                        %>
                                        <script>
                                            function useVoucher(id) {
                                                document.getElementById('usedVouchers').innerHTML = document.getElementById('usedVouchers').innerHTML + '<input type="hidden" name="vouchers[]" value="' + id + '"/>';
                                                // document.getElementById('useVoucher' + id).disabled = true;
                                                document.getElementById('btnDiv' + id).innerHTML = '<p style="color: white;" >CUPOM SELECIONADO </p>'
                                                console.log("ADDED VOUCHER " + id);
                                            }
                                        </script>
                                        <%
                                            if (userDTO.getCards().size() > 0) {
                                                for (CardDTO card : userDTO.getCards()) {
                                                    out.print("<div class=\"col-sm-4\">");
                                                    out.print("<div class=\"category-page-wrapper selected-payment\" style=\"background-color: #189b79; color: white;\">");
                                                    out.print("<h2 class=\"text-white\" style=\"color: white;\">Cart&atilde;o Principal</h2>");
                                                    out.print("<p>N&uacute;mero: XXXX XXXX XXXX " + card.getNumber() + "</p>");
                                                    out.print("<p>Titular: : " + card.getHolder() + "</p>");
                                                    out.print("<p>Expira&ccedil;&atilde;o: <strong>" + card.getExpiration() + "</strong></p>");
                                                    if (card.isExpired())
                                                        out.print("<p style=\"color: white; background: red;\" class=\"text-center\">CART&Atilde;O EXPIRADO!</p>");
                                                    else {
                                                        out.print("<div class=\"row\">");
                                                        out.print("<div class=\"col-sm-4\">");
                                                        out.print("<label for=\"cardCharge\">Valor:</label>");
                                                        out.print("</div>");
                                                        out.print("<div class=\"col-sm-8\">");
                                                        out.print("<input type=\"number\" step=\"0.01\" class=\"p-r-10 form-control text-white text-right m-r-10\" value=\"\" id=\"cardCharge" + card.getId() + "\" name=\"cardCharge\"" + card.getId() + "\">");
                                                        out.print("<div id=\"card-error" + card.getId() + "\"></div>");
                                                        out.print("</div>");
                                                        out.print("</div>");
                                                        out.print("<br/><a class=\"btn btn-danger\" id=\"selectCard" + card.getId() + "\" onclick=\"useCard(" + card.getId() + ");\">Utilizar Cart&atilde;o</a>");
                                                        out.print("<a class=\"btn btn-warning\" style=\"display: none;\" id=\"cancelCardUse" + card.getId() + "\" onclick=\"cancelCardUse(" + card.getId() + ");\">N&atilde;o Utilizar</a>");
                                                    }
                                                    out.print("</div>");
                                                    out.print("</div>");
                                                }
                                            }%>
                                    </div>
                                    <%
                                        out.print("<div id=\"usedCards\"></div>");
                                        List<CardDTO> cards = new ArrayList<>();
                                        if (order != null)
                                            cards = order.getCards();
                                        for (CardDTO c : cards) {
                                            int i = 0;
                                            if (c.getId() == null) {
                                                out.print("<hr/><div id=\"card-form\" class=\"m-t-40 card-form\">");
                                                out.print("<div class=\"form-group\">");
                                                out.print("<div class=\"row\">");
                                                out.print("<label for=\"cardCompany\" class=\"col-sm-3 control-label\">Bandeira</label>");
                                                out.print("<div class=\"col-sm-3\">");
                                                out.print("<select class=\"form-control\" id=\"cardCompany\" name=\"card[" + i + "][cardCompany]\">");
                                                out.print("<option value=\"\"> -- Selecione --</option>");
                                                int company = c.getCompany();
                                                if (company == 1)
                                                    out.print("<option value=\"1\" selected>Mastercard</option>");
                                                else
                                                    out.print("<option value=\"1\">Mastercard</option>");
                                                if (company == 2)
                                                    out.print("<option value=\"2\" selected>Visa</option>");
                                                else
                                                    out.print("<option value=\"2\">Visa</option>");
                                                if (company == 3)
                                                    out.print("<option value=\"3\" selected>American Express</option>");
                                                else
                                                    out.print("<option value=\"3\">American Express</option>");
                                                if (company == 4)
                                                    out.print("<option value=\"4\" selected>Diner\'s Club</option>");
                                                else
                                                    out.print("<option value=\"4\">Diner\'s Club</option>");
                                                if (company == 5)
                                                    out.print("<option value=\"5\" selected>Cirrus</option>");
                                                else
                                                    out.print("<option value=\"5\">Cirrus</option>");
                                                if (company == 6)
                                                    out.print("<option value=\"6\" Discovery>Mastercard</option>");
                                                else
                                                    out.print("<option value=\"6\">Discovery</option>");
                                                if (company == 7)
                                                    out.print("<option value=\"7\" selected>Elo</option>");
                                                else
                                                    out.print("<option value=\"7\">Elo</option>");
                                                if (company == 8)
                                                    out.print("<option value=\"8\" selected>Outro</option>");
                                                else
                                                    out.print("<option value=\"8\">Outro</option>");
                                                out.print("</select>");
                                                out.print("</div>");
                                                out.print("<label class=\"col-sm-3 control-label \" for=\"cardExpiration\">Data de Expira&ccedil;&atilde;o</label>");
                                                out.print("<div class=\"col-sm-3\">");
                                                out.print("<input type=\"text\" class=\"form-control\" id=\"cardExpiration\" name=\"card[" + i + "][cardExpiration]\" value=\"" + c.getExpiration() + "\">");
                                                out.print("</div>");
                                                out.print("</div>");
                                                out.print("<div class=\"row\">");
                                                out.print("<div class=\"form-group\">");
                                                out.print("<label class=\"col-sm-3 control-label\" for=\"cardNumber\">N&uacute;mero do cart&atilde;o</label>");
                                                out.print("<div class=\"col-sm-5\">");
                                                out.print("<input type=\"text\" class=\"form-control\" id=\"cardNumber\" name=\"card[" + i + "][cardNumber]\" placeholder=\"ex. 9999 9999 9999 9999\" value=\"" + c.getNumber() + "\">");
                                                out.print("</div>");
                                                out.print("<label class=\"col-sm-1 control-label\" for=\"cvv\">CVV</label>");
                                                out.print("<div class=\"col-sm-2\">");
                                                out.print("<input type=\"text\" class=\"form-control\" id=\"cvv\" name=\"card[" + i + "][cvv]\" value=\"" + c.getCvv() + "\">");
                                                out.print("</div>");
                                                out.print("<div class=\"col-sm-1 text-center\">");
                                                out.print("<a href=\"#\" onclick=\"window.open(\'resources/image/Credit-Card-CVV.png\');return false;\"><i class=\"fa fa-question\"></i></a>");
                                                out.print("</div>");
                                                out.print("</div>");
                                                out.print("</div>");
                                                out.print("</div>");
                                                out.print("<div class=\"row\">");
                                                out.print("<div class=\"form-group\">");
                                                out.print("<label class=\"col-sm-2 control-label\" for=\"cardName\">Nome do Titular</label>");
                                                out.print("<div class=\"col-sm-8\">");
                                                out.print("<input type=\"text\" class=\"form-control\" id=\"cardName\" name=\"card[" + i + "][cardName]\" placeholder=\"Exatamente como aparece no cart&atilde;o\" value=\"" + c.getHolder() + "\">");
                                                out.print("</div>");
                                                out.print("<label class=\"col-sm-1 control-label text-right\" for=\"saveCard\">Salvar?</label>");
                                                if (c.getSaveCard())
                                                    out.print("<input type=\"checkbox\" class=\"col-sm-1 text-right\" id=\"saveCard\" name=\"card[" + i + "][saveCard]\" checked>");
                                                else
                                                    out.print("<input type=\"checkbox\" class=\"col-sm-1 text-right\" id=\"saveCard\" name=\"card[" + i + "][saveCard]\" >");
                                                out.print("</div>");
                                                out.print("</div>");
                                                out.print("<div class=\"row\">");
                                                out.print("<div class=\"form-group\">");
                                                out.print("<label class=\"col-sm-4 control-label\" for=\"cardAmount\">Valor a ser cobrado: </label>");
                                                out.print("<div class=\"col-sm-8\">");
                                                out.print("<input type=\"number\" class=\"form-control\" id=\"cardAmount\" name=\"card[" + i + "][amount]\" value=\" " + c.getAmountPaid() + "\">");
                                                out.print("</div>");
                                                out.print("</div>");
                                                out.print("</div>");
                                                out.print("</div>");
                                                i++;
                                            }
                                        }
                                    %>
                                    <script>
                                        function useCard(id) {
                                            $('#card-error' + id).html('');
                                            $('#cancelCardUse' + id).show();
                                            var cardAmount = $('#cardCharge' + id).val();
                                            cardAmount = parseFloat(cardAmount)
                                            if (isNaN(cardAmount)) {
                                                document.getElementById('card-error' + id).innerHTML = '<p style="color: red"><strong>Campo obrigat&oacute;rio!</strong></p>'
                                                console.log("IS NAN!")
                                            } else {
                                                document.getElementById('usedCards').innerHTML = document.getElementById('usedCards').innerHTML + '<input type="hidden" name="usedCardsList[]" value="' + id + '"/>';
                                                var amount = $('#cardCharge' + id).val();
                                                document.getElementById('usedCards').innerHTML = document.getElementById('usedCards').innerHTML + '<input type="hidden" name="usedCardsAmount[]" value="' + amount + '"/>';
                                                $('#selectCard' + id).hide();
                                                console.log("ADDED CARD " + id);
                                            }
                                        }
                                        function cancelCardUse(id) {
                                            $('#cardCharge' + id).val('');
                                            $('#card-error' + id).html('');
                                            var cancelButton = '#cancelCardUse' + id;
                                            $('#cancelCardUse' + id).hide();
                                            $('input[name=usedCardsList[]]').each(function () {
                                                if ($(this).val() == id) {
                                                    $(this).remove();
                                                }
                                            });
                                            $('#selectCard' + id).show();
                                        }
                                    </script>
                                    <div id="new-card-wrapper"></div>
                                    <div class="row">
                                        <a class="btn btn-primary m-t-40 pull-right" id="addCard">Adicionar Outro Cart&atilde;o</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="accordion-toggle" data-parent="#accordion" data-toggle="collapse"
                                   href="#collapse-checkout-confirm" aria-expanded="true">Passo 5: Confirme o Pedido
                                    <i class="fa fa-caret-down"></i>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse-checkout-confirm" role="heading" class="panel-collapse collapse in"
                             aria-expanded="true" style="">
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                        <tr>
                                            <td class="text-center">Produto</td>
                                            <td class="text-left">T&iacute;tulo</td>
                                            <td class="text-right">Quantidade</td>
                                            <td class="text-right">Valor Unit&aacute;rio</td>
                                            <td class="text-right">Total</td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%
                                            for (CartItemDTO item : cart.getCartItems()) {
                                        %>
                                        <tr>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/book/<%out.print(item.getId());%>">
                                                    <img class="img-thumbnail"
                                                         title="<%out.print(item.getTitle());%>"
                                                         alt="Capa do livro <%out.print(item.getTitle());%>"
                                                         src="<%out.print(item.getCover());%>"
                                                         style="max-height: 50px">
                                                </a>
                                            </td>
                                            <td class="text-left">
                                                <a href="${pageContext.request.contextPath}/book/<%out.print(item.getId());%>">
                                                    <%out.print(item.getTitle());%>
                                                </a>
                                            </td>
                                            <td class="text-right"><%out.print(item.getQuantity());%></td>
                                            <td class="text-right">$<%
                                                out.print(String.format("%.2f", item.getPrice()));%></td>
                                            <td class="text-right">$<%
                                                out.print(String.format("%.2f", item.getTotal()));%></td>
                                        </tr>
                                        <%}%>
                                        </tbody>
                                        <tfoot>
                                        <tr>
                                            <td class="text-right" colspan="4"><strong>Sub-Total:</strong></td>
                                            <td class="text-right">$<%
                                                out.print(String.format("%.2f", cart.getTotal()));%></td>
                                            <input type="hidden" value="<%out.print(cart.getTotal());%>" id="subtotal"
                                                   name="subtotal"/>
                                        </tr>
                                        <tr>
                                            <td class="text-right" colspan="4"><strong>Impostos (20%):</strong></td>
                                            <td class="text-right">$<%
                                                out.print(String.format("%.2f", cart.getTotal() * 0.2));%></td>
                                            <input type="hidden" value="<%out.print(cart.getTotal()*0.2);%>" id="tax"
                                                   name="tax"/>
                                        </tr>
                                        <tr>
                                            <td class="text-right" colspan="4"><strong>Frete:</strong></td>
                                            <td class="text-right" id="shipping"></td>
                                            <input type="hidden" id="shippingCost" name="shippingCost"/>
                                        </tr>
                                        <tr>
                                            <td class="text-right" colspan="4"><strong>Total:</strong></td>
                                            <td class="text-right" id="orderTotal"></td>
                                            <input type="hidden" id="grandTotal" name="grandTotal"/>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                <div class="buttons">
                                    <div class="pull-right">
                                        <div class="pull-right">
                                            <button type="submit" formaction="${pageContext.request.contextPath}/order"
                                                    class="btn btn-primary">Finalizar Compra
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<%
        }
    }
%>
<div class="footer-top-cms parallax-container">
    <div class="parallax"><img src="${pageContext.request.contextPath}/resources/image/parallax1.jpg" alt="#"></div>
    <div class="container">
        <div class="row">
            <div class="newslatter">
                <form>
                    <h5>FIQUE POR DENTRO!</h5>
                    <h4 class="title-subline text-white">Receba todas as novidades, promo&ccedil;&otilde;es, e eventos
                        diretamente na sua caixa de entrada!</h4>
                    <div class="input-group">
                        <label hidden for="emailSubscription">Assinatura de newsletter por e-mail</label>
                        <input type="text" id="emailSubscription" class=" form-control" placeholder="Your-email@website.com">
                        <button type="submit" value="Sign up" class="btn btn-large btn-primary">Inscreva-se!</button>
                    </div>
                </form>
            </div>
            <div class="footer-social">
                <ul>
                    <li class="facebook"><a href="#"><i class="fa fa-facebook"></i></a></li>
                    <li class="linkedin"><a href="#"><i class="fa fa-linkedin"></i></a></li>
                    <li class="twitter"><a href="#"><i class="fa fa-twitter"></i></a></li>
                    <li class="gplus"><a href="#"><i class="fa fa-google-plus"></i></a></li>
                    <li class="youtube"><a href="#"><i class="fa fa-youtube-play"></i></a></li>
                </ul>
            </div>
        </div>

    </div>
</div>
<footer>
    <div class="cms_searvice">
        <div class="container">
            <div class="row"></div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-sm-3 footer-block">
                <h5 class="footer-title">PRODUTOS</h5>
                <ul class="list-unstyled ul-wrapper">
                    <li>
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros Nacionais" value=""/>
                            <a><button type="submit" class="" style="background: transparent"><span>Todos os produtos</span></button></a>
                        </form>
                    </li>
                    <li>
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros Nacionais" value="nacional"/>
                            <a><button type="submit" class="" style="background: transparent"><span>Nacionais</span></button></a>
                        </form>
                    </li>
                    <li>
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros Nacionais" value="importado"/>
                            <a><button type="submit" class="" style="background: transparent"><span>Importados</span></button></a>
                        </form>
                    </li>
                    <li>
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros Nacionais" value="não-ficção"/>
                            <a><button type="submit" class="" style="background: transparent"><span>N&atilde;o-fic&ccedil;&atilde;o</span></button></a>
                        </form>
                    </li>
                    <li>
                        <form action="search" method="get">
                            <input type="hidden" name="q" aria-label="Buscar Livros Nacionais" value="didático"/>
                            <a><button type="submit" class="" style="background: transparent"><span>Did&aacute;ticos</span></button></a>
                        </form>
                    </li>
                </ul>
            </div>
            <div class="col-sm-3 footer-block">
                <h5 class="footer-title">MINHA CONTA</h5>
                <ul class="list-unstyled ul-wrapper">
                    <%if (request.getSession().getAttribute("user") == null) {%>
                    <li><a href="${pageContext.request.contextPath}/signup">Cadastrar</a></li>
                    <li><a href="login.jsp">Entrar</a></li>
                    <%} else {%>
                    <li><a href="${pageContext.request.contextPath}/history">Hist&oacute;rico de Compras</a></li>
                    <li><a href="${pageContext.request.contextPath}/vouchers">Cupons Dispon&iacute;veis</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile">Configura&ccedil;&otilde;es</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
                    <%}%>
                </ul>
            </div>
            <div class="col-sm-3 footer-block">
                <h5 class="footer-title">INFORMA&Ccedil;&Otilde;ES</h5>
                <ul class="list-unstyled ul-wrapper">
                    <li><a href="about.jsp">Sobre N&oacute;s</a></li>
                    <li><a href="#">Prazos de Entrega</a></li>
                    <li><a href="#">Entre em Contato</a></li>
                    <li><a href="#">Carreiras</a></li>
                </ul>
            </div>
            <div class="col-sm-3 footer-block">
                <div class="content_footercms_right">
                    <div class="footer-contact">
                        <h5 class="contact-title footer-title">ENTRE EM CONTATO</h5>
                        <ul class="ul-wrapper">
                            <li>
                                <i class="fa fa-map-marker"></i>
                                <span class="location2">Onde Estamos:
                                    <br/>Rua Sem Nome, 0
                                    <br/>Centro, Cidade Capital
                                    <br/> 00000-000 BRASIL
                                </span>
                            </li>
                            <li>
                                <i class="fa fa-envelope"></i>
                                <span class="mail2">
                                    <a href="#">contato@badwolfbookshop.com</a><br/>
                                    <li>
                                        <i class="fa fa-mobile"></i><span class="phone2">+55 xx 1234-5678</span><br>
                                        <i class="fa fa-mobile"></i><span class="phone2">+55 xx 8765-4321</span>
                                    </li>
                                </span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div id="bottom-footer">
            <ul class="footer-link">
                <li><a href="index.jsp" class="parent">In&iacute;cio</a></li>
                <li><a href="about.jsp">Sobre</a></li>
                <li><a href="#">Carreiras</a></li>
                <li><a href="#">Contato</a></li>
            </ul>
            <div class="copyright"> Copyright - <a class="yourstore" href="http://www.lionode.com/"> Created by Lionode
                &copy; 2017 </a></div>
            <div class="footer-bottom-cms">
                <div class="footer-payment">
                    <ul>
                        <li class="mastero"><img alt="Logo MasterCard Maestro" src="${pageContext.request.contextPath}/resources/image/payment/mastero.jpg"></li>
                        <li class="visa"><img alt="Logo Visa" src="${pageContext.request.contextPath}/resources/image/payment/visa.jpg"></li>
                        <li class="currus"><img alt="Logo Cirrus" src="${pageContext.request.contextPath}/resources/image/payment/currus.jpg"></li>
                        <li class="discover"><img alt="Logo Discover" src="${pageContext.request.contextPath}/resources/image/payment/discover.jpg"></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/javascript/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/javascript/template_js/jstree.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/javascript/template_js/template.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/global.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        $('.parallax').parallax();

        var i = $("input[class*='card-form']").length;
        var addButton = $('#addCard');
        var wrapper = $('#new-card-wrapper');
        var fieldHTML = '<hr/><div id="card-form" class="m-t-40 card-form">\n' +
            '<div class="form-group">\n' +
            '<div class="row">\n' +
            '<label for="cardCompany" class="col-sm-3 control-label">Bandeira</label>\n' +
            '<div class="col-sm-3">\n' +
            '<select class="form-control" id="cardCompany" name="card[' + i + '][cardCompany]">\n' +
            '<option value=""> -- Selecione --</option>\n' +
            '<option value="1">Mastercard</option>\n' +
            '<option value="2">Visa</option>\n' +
            '<option value="3">American Express</option>\n' +
            '<option value="4">Diner\'s Club</option>\n' +
            '<option value="5">Cirrus</option>\n' +
            '<option value="6">Discovery</option>\n' +
            '<option value="7">Elo</option>\n' +
            '<option value="8">Outro</option>\n' +
            '</select>\n' +
            '</div>\n' +
            '<label class="col-sm-3 control-label " for="cardExpiration">Data\n' +
            'de Expira&ccedil;&atilde;o</label>\n' +
            '<div class="col-sm-3">\n' +
            '<input type="text" class="form-control" id="cardExpiration"\n' +
            'name="card[' + i + '][cardExpiration]">\n' +
            '</div>\n' +
            '</div>\n' +
            '<div class="row">\n' +
            '<div class="form-group">\n' +
            '<label class="col-sm-3 control-label" for="cardNumber">N&uacute;mero do\n' +
            'cart&atilde;o</label>\n' +
            '<div class="col-sm-5">\n' +
            '<input type="text" class="form-control" id="cardNumber"\n' +
            'name="card[' + i + '][cardNumber]" placeholder="ex. 9999 9999 9999 9999">\n' +
            '</div>\n' +
            '\n' +
            '<label class="col-sm-1 control-label" for="cvv">CVV</label>\n' +
            '<div class="col-sm-2">\n' +
            '<input type="text" class="form-control" id="cvv"\n' +
            'name="card[' + i + '][cvv]">\n' +
            '</div>\n' +
            '<div class="col-sm-1 text-center">\n' +
            '<a href="#" onclick="window.open(\'resources/image/Credit-Card-CVV.png\');return false;"><i ' +
            'class="fa fa-question"></i></a>\n' +
            '</div>\n' +
            '</div>\n' +
            '</div>\n' +
            '</div>\n' +
            '<div class="row">\n' +
            '<div class="form-group">\n' +
            '<label class="col-sm-2 control-label" for="cardName">Nome do\n' +
            'Titular</label>\n' +
            '<div class="col-sm-8">\n' +
            '<input type="text" class="form-control" id="cardName"\n' +
            'name="card[' + i + '][cardName]"\n' +
            'placeholder="Exatamente como aparece no cart&atilde;o">\n' +
            '</div>\n' +
            '<label class="col-sm-1 control-label text-right" for="saveCard">Salvar?</label>\n' +
            '<input type="checkbox" class="col-sm-1 text-right" id="saveCard"\n' +
            'name="card[' + i + '][saveCard]" checked>\n' +
            '</div>\n' +
            '</div>\n' +
            '<div class="row">\n' +
            '<div class="form-group">\n' +
            '<label class="col-sm-4 control-label" for="cardAmount">Valor a ser cobrado: </label>\n' +
            '<div class="col-sm-8">\n' +
            '<input type="number" class="form-control" id="cardAmount"\n' +
            'name="card[' + i + '][amount]" step="0.01">\n' +
            '</div>\n' +
            '</div>\n' +
            '</div>\n' +
            '</div>';

        $(addButton).click(function () {
            $(wrapper).append(fieldHTML);
            i++;
        })

    });
</script>
</body>
</html>