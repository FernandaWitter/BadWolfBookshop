<%@ page import="dto.CartDTO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.AddressDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bad Wolf Bookshop</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="e-commerce site well design with responsive view."/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%--    <link href="resources/image/favicon.png" rel="icon" type="image/png" >--%>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <link href="resources/javascript/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css"/>
    <link href="resources/css/googleFonts.css" rel="stylesheet"/>
    <link href="resources/css/stylesheet.css" rel="stylesheet">
    <link href="resources/css/responsive.css" rel="stylesheet">
    <link href="resources/javascript/owl-carousel/owl.carousel.css" type="text/css" rel="stylesheet" media="screen"/>
    <link href="resources/javascript/owl-carousel/owl.transitions.css" type="text/css" rel="stylesheet" media="screen"/>
    <script type="text/javascript" src="resources/javascript/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="resources/javascript/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="resources/javascript/template_js/jstree.min.js"></script>
    <script type="text/javascript" src="resources/javascript/template_js/template.js"></script>
    <script type="text/javascript" src="resources/javascript/common.js"></script>
    <script type="text/javascript" src="resources/javascript/global.js"></script>
    <script type="text/javascript" src="resources/javascript/owl-carousel/owl.carousel.min.js"></script>
</head>
<body class="index">
<div class="preloader loader" style="display: block;"><img src="resources/image/loader-circle.gif" alt="#"/></div>
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
                                <li class="dropdown"><a href="#" title="Conta" class="dropdown-toggle"
                                                        data-toggle="dropdown"><i class="fa fa-user"
                                                                                  aria-hidden="true"></i><span>Perfil</span>
                                    <span class="caret"></span></a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <%if(request.getSession().getAttribute("user") == null){%>
                                        <li><a href="registration.jsp">Cadastrar</a></li>
                                        <li><a href="login.jsp">Entrar</a></li>
                                        <%} else {%>
                                        <li><a href="${pageContext.request.contextPath}/history">Hist&oacute;rico de Compras</a></li>
                                        <li><a href="${pageContext.request.contextPath}/vouchers">Cupons Dispon&iacute;veis</a> </li>
                                        <li><a href="${pageContext.request.contextPath}/profile">Configura&ccedil;&otilde;es</a></li>
                                        <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
                                        <%}%>
                                    </ul>
                                </li>
                                <li><a href="#" id="wishlist-total" title="Lista de Desejos (0)"><i class="fa fa-heart"
                                                                                                    aria-hidden="true"></i><span>Lista de Desejos</span><span> (0)</span></a>
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
                <div id="logo"><a href="index.jsp"><img src="resources/image/logo.jpg" title="E-Commerce"
                                                       alt="E-Commerce" class="img-responsive"/></a></div>
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
                    <a type="button" class="btn btn-inverse btn-block btn-lg cart-dropdown-button" href="cart.jsp"><span
                            id="cart-total"><i class="fa fa-shopping-cart" style="color: #189b79;"></i>
          <span>Carrinho</span><br><%
                            CartDTO cart = (CartDTO) request.getSession().getAttribute("cart");
                            if(cart == null)
                                out.print("0 item(s) - $0.00");
                            else
                                out.print(cart.getNumberOfItems() + " item(s) - $" + String.format("%.2f", cart.getTotal()));
                        %></span></a>
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
                <li><a href="index.jsp" class="parent">In&iacute;cio</a></li>
                <li><a href="bookSearch.jsp" class="parent">Nacionais</a></li>
                <li><a href="bookSearch.jsp" class="parent">Importados</a></li>
                <li><a href="bookSearch.jsp" class="parent">N&atilde;o-Fic&Ccedil;&atilde;o</a></li>
                <li><a href="bookSearch.jsp" class="active parent">Did&aacute;ticos</a></li>
                <li><a href="about.jsp">Sobre n&oacute;s</a>
                    <%--                    <ul>--%>
                    <%--                        <li><a href="category.html">A Empresa</a></li>--%>
                    <%--                        <li><a href="cart.html">Entre em Contato</a></li>--%>
                    <%--                        <li><a href="checkout.html">Carreiras</a></li>--%>
                    <%--                    </ul>--%>
                </li>
            </ul>
        </div>
    </div>
</nav>
<%--<div class="breadcrumb parallax-container">--%>
<%--    <div class="parallax"><img src="image/prlx.jpg" alt="#"></div>--%>
<%--    <h1>Register Account</h1>--%>
<%--    <ul>--%>
<%--        <li><a href="index.html">Home</a></li>--%>
<%--        <li><a href="#">Account</a></li>--%>
<%--        <li><a href="register.html">Register</a></li>--%>
<%--    </ul>--%>
<%--</div>--%>
<%
    Result result;
    if(request.getAttribute("result") != null)
        result = (Result) request.getAttribute("result");
    else
        result = new Result();
%>
<div class="container">
    <div class="row">
        <div class="col-sm-3 hidden-xs column-left m-t-40" id="column-left">
            <div class="Categories left-sidebar-widget">
                <div class="columnblock-title">Dados do Usu&aacute;rio</div>
                <div class="category_block">
                    <ul class="box-category">
                        <li><a href="${pageContext.request.contextPath}/profile">Dados Pessoais</a></li>
                        <li><a href="${pageContext.request.contextPath}/address">Endere&ccedil;os</a></li>
                        <li><a href="${pageContext.request.contextPath}/cards">Formas de Pagamento</a></li>
                        <li><a href="${pageContext.request.contextPath}/credentials">Alterar Senha</a></li>
                        <li><a href="removeAccount.jsp">Excluir Conta</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="container" style="height:40px;"></div>
        <div class="center-block m-l-40 m-r-40" id="content">
            <h2 class="text-center">Endere&ccedil;os</h2>
            <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/alterAddress">
                <p>&Eacute; necess&aacute;rio cadastrar pelo menos um endere&ccedil;o para entrega e cobran&ccedil;a. Se
                    desejar, insira endere&ccedil;os adicionais, e poder&aacute; selecion&aacute;-los ao concluir a
                    compra.</p>
                <p>* Campos obrigat&oacute;rios</p>
                <fieldset id="address">
                    <%
                    int max = 1;
                    List<DomainObject> addresses = new ArrayList<>();
                    if(result.hasObject(Address.class.getSimpleName()))
                        addresses = result.getObject(Address.class.getSimpleName());
                    if(addresses.size() > 0)
                        max = addresses.size();
                    Address a = new Address();
                    for(int i = 0; i < max; i++){
                        if(addresses.size() > i)
                            a = (Address) addresses.get(i);
                    %>
                    <div id="address<%out.print(i);%>">
                    <legend class="address-label"><%out.print(a.getNickname() != null ? a.getNickname() : "Cadastre um endere&ccedil;o...");%>
                        <button type="button" class="btn btn-danger pull-right" style="height:30px;" onclick="deleteAddress(<%out.print(i);%>)"><i class="fa fa-remove m-b-20 pt-n2"></i> </button>
                    </legend>
                    <input type="hidden" name="<%out.print("address[" + i + "][nickname]");%>"
                           value="<%out.print(a.getNickname() != null ? a.getNickname() : "");%>">
                    <input type="hidden" name="<%out.print("address[" + i + "][id]");%>"
                           value="<%out.print(a.getId() != null ? a.getId() : "");%>">
                    <div class="form-group required">
                        <label for="addressPlace0" class="col-sm-2 control-label">Logradouro*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="addressPlace0"
                                   placeholder="ex. Rua, Avenida, Travessa..." value="Rua Principal"
                                   name="<%out.print("address[" + i + "][place]");%>"
                                   value="<%out.print(a.getPlace() != null ? a.getPlace() : "");%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="addressNumber0" class="col-sm-2 control-label">N&uacute;mero*</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="addressNumber0" placeholder="ex. 51"
                                   name="<%out.print("address[" + i + "][number]");%>"
                                   value="<%out.print(a.getNumber() != null ? a.getNumber() : "");%>">
                        </div>
                        <label for="addressNeighborhood0" class="col-sm-2 control-label">Bairro</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="addressNeighborhood0" placeholder="ex. Centro"
                                   name="<%out.print("address[" + i + "][neighborhood]");%>"
                                   value="<%out.print(a.getNeighborhood() != null ? a.getNeighborhood() : "");%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="addressZipCode0" class="col-sm-2 control-label">CEP*</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="addressZipCode0" placeholder="ex. 99999-999"
                                   name="<%out.print("address[" + i + "][zipcode]");%>"
                                   value="<%out.print(a.getZipCode() != null ? a.getZipCode() : "");%>">
                        </div>
                        <label for="addressCompl0" class="col-sm-2 control-label">Complemento</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="addressCompl0" placeholder="ex. Apto 10"
                                   name="<%out.print("address[" + i + "][compl]");%>"
                                   value="<%out.print(a.getComplement() != null ? a.getComplement() : "");%>">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="addressCity0" class="col-sm-2 control-label">Cidade*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="addressCity0" placeholder="ex. S&atilde;o Paulo"
                                   name="<%out.print("address[" + i + "][city]");%>"
                                   value="<%out.print(a.getCity() != null ? a.getCity() : "");%>">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="input-zone" class="col-sm-2 control-label">Estado*</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="input-zone"
                                    name="<%out.print("address[" + i + "][state]");%>">
                                <option value=""> --- Selecione ---</option>
                                <%
                                    if (result != null && result.hasObject(State.class.getSimpleName())) {
                                        List<DomainObject> states = result.getObject(State.class.getSimpleName());
                                        for (DomainObject d : states) {
                                            String selected = "";
                                            State s = (State) d;
                                            if (a.getState() != null && a.getState().getCode() == s.getCode()) {
                                                selected = " selected";
                                            }
                                            out.print("<option value=\"" + s.getCode() + "\"" + selected + ">" + s.getName() + "</option>");
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <label for="addressCountry0" class="col-sm-2 control-label">Pa&iacute;s*</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="addressCountry0" name="<%out.print("address[" + i + "][country]");%>">
                                <option value=""> --- Selecione ---</option>
                                <%
                                    if (result != null && result.hasObject(Country.class.getSimpleName())) {
                                        List<DomainObject> states = result.getObject(Country.class.getSimpleName());
                                        for (DomainObject d : states) {
                                            String selected = "";
                                            Country c = (Country) d;
                                            if (a.getCountry() != null && a.getCountry().getCode() == c.getCode()) {
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
                        <label class="col-sm-2 control-label" for="isDelivery0">Entrega?</label>
                        <input type="checkbox" class="col-sm-2" id="isDelivery0"
                               name="<%out.print("address[" + i + "][shipping]");%>"
                                <%out.print(a.getIsDelivery() != null ? "checked" : "");%>>
                        <label class="col-sm-2 control-label text-right" for="isBilling0">Cobran&ccedil;a?</label>
                        <input type="checkbox" class="col-sm-2 text-right" id="isBilling0"
                               name="<%out.print("address[" + i + "][billing]");%>"
                                <%out.print(a.getIsBilling() != null ? "checked" : "");%>>
                        <label class="col-sm-2 control-label text-right" for="isMain0">Principal?</label>
                        <input type="checkbox" class="col-sm-2" id="isMain0"
                               name="<%out.print("address[" + i + "][main]");%>"
                                <%out.print(a.getIsMain() != null ? "checked" : "");%>>
                    </div>
                    </div>
                    <%}%>
                    <script>
                        function deleteAddress(id){
                            document.getElementById('address' + id).innerHTML = '';
                        }
                    </script>
                    <div id="new-address-wrapper"></div>
                    <div class="form-group text-right m-t-40">
                        <a class="btn btn-primary" id="addAddress">Adicionar Novo Endere&ccedil;o</a>
                    </div>

                    <div class="m-t-40"></div>
                    <div class="buttons clearfix">
                        <div class="pull-left"><a href="index.jsp" class="btn btn-default">Cancelar</a></div>
                        <div class="pull-right">
                            <input type="submit" value="Salvar" class="btn btn-primary"/>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>
<div class="footer-top-cms parallax-container">
    <div class="parallax"><img src="resources/image/parallax1.jpg" alt="#"></div>
    <div class="container">
        <div class="row">
            <div class="newslatter">
                <form>
                    <h5>FIQUE POR DENTRO!</h5>
                    <h4 class="title-subline text-white">Receba todas as novidades, promo&ccedil;&otilde;es, e eventos diretamente
                        na sua caixa de entrada!</h4>
                    <div class="input-group">
                        <label hidden for="emailSubscription">Assinatura de newsletter por e-mail</label>
                        <input type="text" id="emailSubscription" class=" form-control"
                               placeholder="Your-email@website.com">
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
    <div class="container">
        <div class="row">
            <div class="col-sm-3 footer-block">
                <h5 class="footer-title">PRODUTOS</h5>
                <ul class="list-unstyled ul-wrapper">
                    <li><a href="bookSearch.jsp">Todos os produtos</a></li>
                    <li><a href="bookSearch.jsp">Nacionais</a></li>
                    <li><a href="bookSearch.jsp">Importados</a></li>
                    <li><a href="bookSearch.jsp">N&atilde;o fic&ccedil;&atilde;o</a></li>
                    <li><a href="bookSearch.jsp">Did&aacute;ticos</a></li>
                </ul>
            </div>
            <div class="col-sm-3 footer-block">
                <h5 class="footer-title">MINHA CONTA</h5>
                <ul class="list-unstyled ul-wrapper">
                    <li><a href="editClientPersonalData.jsp">Meu Perfil</a></li>
                    <li><a href="orderHistory.jsp">Hist&otilde;rico de Compras</a></li>
                    <li><a href="#">Lista de Desejos</a></li>
                    <li><a href="#">Newsletter</a></li>
                    <%--                    <li><a href="#">Cupons de Troca</a></li>--%>
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
                            <li><i class="fa fa-map-marker"></i><span class="location2">Onde Estamos:<br>
                Rua Sem Nome, 0<br>
                Centro, Cidade Capital <br>
                00000-000 BRASIL</span></li>
                            <li><i class="fa fa-envelope"></i><span class="mail2"><a href="#">contato@badwolfbookshop.com</a><br>
                            <li><i class="fa fa-mobile"></i><span class="phone2">+55 xx 1234-5678<br>
                +55 xx 8765-4321</span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div id="bottom-footer">
            <ul class="footer-link">
                <li><a href="#">In&iacute;cio</a></li>
                <li><a href="#">Sobre</a></li>
                <li><a href="#">Carreiras</a></li>
                <li><a href="#">Contato</a></li>
            </ul>
            <div class="copyright"> Copyright - <a class="yourstore" href="http://www.lionode.com/"> Created by Lionode
                &copy; 2017 </a></div>
            <div class="footer-bottom-cms">
                <div class="footer-payment">
                    <ul>
                        <li class="mastero"><a href="#"><img alt="" src="resources/image/payment/mastero.jpg"></a></li>
                        <li class="visa"><a href="#"><img alt="" src="resources/image/payment/visa.jpg"></a></li>
                        <li class="currus"><a href="#"><img alt="" src="resources/image/payment/currus.jpg"></a></li>
                        <li class="discover"><a href="#"><img alt="" src="resources/image/payment/discover.jpg"></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <a id="scrollup">Scroll</a>
</footer>

<script src="resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        $('.parallax').parallax();
        var addButton = $('#addAddress');
        var wrapper = $('#new-address-wrapper');
        var addAddress = $('#addAddress');
        var addressWrapper = $('#new-address-wrapper');
        var stateOptions = '<option value=""> --- Selecione --- </option>' +
            '<option value="12">Acre / AC</option>' +
            '<option value="27">Alagoas / AL</option>' +
            '<option value="16">Amap&aacute; / AM</option>' +
            '<option value="13">Amazonas / AM</option>' +
            '<option value="29">Bahia / BA</option>' +
            '<option value="23">Cear&aacute; / CE</option>' +
            '<option value="53">Distrito Federal DF</option>' +
            '<option value="32">Esp&iacute;rito Santo / ES</option>' +
            '<option value="52">Goi&aacute;s / GO</option>' +
            '<option value="21">Maranh&atilde;o / MA</option>' +
            '<option value="51">Mato Grosso / MT</option>' +
            '<option value="50">Mato Grosso do Sul / MS</option>' +
            '<option value="31">Minas Gerais / MG</option>' +
            '<option value="15">Par&aacute; / PA</option>' +
            '<option value="25">Para&iacute;ba / PB</option>' +
            '<option value="41">Paran&aacute; / PR</option>' +
            '<option value="26">Pernambuco / PE</option>' +
            '<option value="22">Piau&iacute; / PI</option>' +
            '<option value="33">Rio de Janeiro / RJ</option>' +
            '<option value="24">Rio Grande do Norte / RN</option>' +
            '<option value="43">Rio Grande do Sul / RS</option>' +
            '<option value="11">Rond&ocirc;nia / RO</option>' +
            '<option value="14">Roraima / RR</option>' +
            '<option value="42">Santa Catarina / SC</option>' +
            '<option value="35">S&atilde;o Paulo / SP</option>' +
            '<option value="28">Sergipe / SE</option>' +
            '<option value="17">Tocantins / TO</option>' +
            '<option value="99">Exterior</option>';

        let countryOptions = '<option value=""> --- Selecione --- </option>' +
            '<option value="4">Afeganist&atilde;o</option>' +
            '<option value="710">&Aacute;frica do Sul</option>' +
            '<option value="8">Alb&acirc;nia</option>' +
            '<option value="276">Alemanha</option>' +
            '<option value="12">Alg&eacute;ria</option>' +
            '<option value="20">Andorra</option>' +
            '<option value="24">Angola</option>' +
            '<option value="660">Anguilla</option>' +
            '<option value="10">Ant&aacute;rtica</option>' +
            '<option value="28">Antigua e Barbuda</option>' +
            '<option value="682">Ar&aacute;bia Saudita</option>' +
            '<option value="32">Argentina</option>' +
            '<option value="51">Arm&ecirc;nia</option>' +
            '<option value="533">Aruba</option>' +
            '<option value="36">Austr&aacute;lia</option>' +
            '<option value="40">&Aacute;ustria</option>' +
            '<option value="31">Azerbaij&atilde;o</option>' +
            '<option value="44">Bahamas</option>' +
            '<option value="48">Bahrain</option>' +
            '<option value="50">Bangladesh</option>' +
            '<option value="52">Barbados</option>' +
            '<option value="112">Bielorr&uacute;ssia</option>' +
            '<option value="56">B&eacute;lgica</option>' +
            '<option value="84">Belize</option>' +
            '<option value="204">Benin</option>' +
            '<option value="60">Bermudas</option>' +
            '<option value="68">Bol&iacute;via</option>' +
            '<option value="535">Bonaire, Sint Eustatius e Saba</option>' +
            '<option value="70">B&oacute;snia e Herzegovina</option>\n' +
            '<option value="72">Botswana</option>\n' +
            '<option value="76">Brasil</option>\n' +
            '<option value="96">Brunei Darussalam</option>\n' +
            '<option value="100">Bulgaria</option>\n' +
            '<option value="854">Burkina Faso</option>\n' +
            '<option value="108">Burundi</option>\n' +
            '<option value="64">But&atilde;o</option>\n' +
            '<option value="132">Cabo Verde</option>\n' +
            '<option value="120">Camar&otilde;es</option>\n' +
            '<option value="116">Camboja</option>\n' +
            '<option value="124">Canad&aacute;</option>\n' +
            '<option value="634">Catar</option>\n' +
            '<option value="398">Cazaquist&atilde;o</option>\n' +
            '<option value="148">Chade</option>\n' +
            '<option value="152">Chile</option>\n' +
            '<option value="156">China</option>\n' +
            '<option value="196">Chipre</option>\n' +
            '<option value="170">Col&ocirc;mbia</option>\n' +
            '<option value="174">Comoros</option>\n' +
            '<option value="408">Cor&eacute;ia do Norte</option>\n' +
            '<option value="410">Cor&eacute;ia do Sul</option>\n' +
            '<option value="384">Costa do Marfim</option>\n' +
            '<option value="188">Costa Rica</option>\n' +
            '<option value="191">Cro&aacute;cia</option>\n' +
            '<option value="192">Cuba</option>\n' +
            '<option value="531">Cura&ccedil;ao</option>\n' +
            '<option value="208">Dinamarca</option>\n' +
            '<option value="262">Djibouti</option>\n' +
            '<option value="212">Dominica</option>\n' +
            '<option value="818">Egito</option>\n' +
            '<option value="222">El Salvador</option>\n' +
            '<option value="784">Emirados &Aacute;rabes Unidos</option>\n' +
            '<option value="218">Equador</option>\n' +
            '<option value="232">Eritrea</option>\n' +
            '<option value="703">Eslovaquia</option>\n' +
            '<option value="705">Eslov&ecirc;nia</option>\n' +
            '<option value="724">Espanha</option>\n' +
            '<option value="840">Estados Unidos</option>\n' +
            '<option value="748">Essuat&iacute;ni</option>\n' +
            '<option value="233">Estonia</option>\n' +
            '<option value="231">Eti&oacute;pia</option>\n' +
            '<option value="242">Fiji</option>\n' +
            '<option value="608">Filipinas</option>\n' +
            '<option value="246">Finl&acirc;ndia</option>\n' +
            '<option value="250">Fran&ccedil;a</option>\n' +
            '<option value="266">Gab&atilde;o</option>\n' +
            '<option value="270">G&acirc;mbia</option>\n' +
            '<option value="288">Gana</option>\n' +
            '<option value="268">Ge&oacute;rgia</option>\n' +
            '<option value="292">Gibraltar</option>\n' +
            '<option value="300">Gr&eacute;cia</option>\n' +
            '<option value="304">Groenl&acirc;ndia</option>\n' +
            '<option value="308">Grenada</option>\n' +
            '<option value="312">Guadalupe</option>\n' +
            '<option value="316">Guam</option>\n' +
            '<option value="320">Guatemala</option>\n' +
            '<option value="831">Guernsey</option>\n' +
            '<option value="328">Guiana</option>\n' +
            '<option value="254">Guiana Francesa</option>\n' +
            '<option value="324">Guin&eacute;</option>\n' +
            '<option value="624">Guin&eacute;-Bissau</option>\n' +
            '<option value="226">Guin&eacute; Equatorial</option>\n' +
            '<option value="332">Haiti</option>\n' +
            '<option value="528">Holanda</option>\n' +
            '<option value="340">Honduras</option>\n' +
            '<option value="344">Hong Kong</option>\n' +
            '<option value="348">Hungria</option>\n' +
            '<option value="887">I&ecirc;men</option>\n' +
            '<option value="248">Ilhas Aaland</option>\n' +
            '<option value="74">Ilhas Bouvet</option>\n' +
            '<option value="136">Ilhas Cayman</option>\n' +
            '<option value="162">Ilhas Christmas</option>\n' +
            '<option value="166">Ilhas Cocos (Keeling)</option>\n' +
            '<option value="184">Ilhas Cook</option>\n' +
            '<option value="833">Ilha de Man</option>\n' +
            '<option value="238">Ilhas Falkland (Malvinas)</option>\n' +
            '<option value="234">Ilhas Faroe</option>\n' +
            '<option value="239">Ilhas Ge&oacute;rgias do Sul e Sandwich do Sul</option>\n' +
            '<option value="334">Ilhas Heard and Mc Donald</option>\n' +
            '<option value="580">Ilhas Marianas Setentrionais</option>\n' +
            '<option value="584">Ilhas Marshall</option>\n' +
            '<option value="581">Ilhas Menores Distantes dos Estados Unidos</option>\n' +
            '<option value="612">Ilhas Pitcairn</option>\n' +
            '<option value="90">Ilhas Salom&atilde;o</option>\n' +
            '<option value="796">Ilhas Turcas e Caicos</option>\n' +
            '<option value="850">Ilhas Virgens Americanas</option>\n' +
            '<option value="92">Ilhas Virgens Brit&acirc;nicas</option>\n' +
            '<option value="356">Índia</option>\n' +
            '<option value="360">Indon&eacute;sia</option>\n' +
            '<option value="364">Ir&atilde; (Rep&uacute;blica Isl&acirc;mica do)</option>\n' +
            '<option value="352">Isl&acirc;dia</option>\n' +
            '<option value="368">Iraque</option>\n' +
            '<option value="372">Irlanda</option>\n' +
            '<option value="376">Israel</option>\n' +
            '<option value="380">It&aacute;lia</option>\n' +
            '<option value="388">Jamaica</option>\n' +
            '<option value="392">Jap&atilde;o</option>\n' +
            '<option value="832">Jersey</option>\n' +
            '<option value="400">Jord&acirc;nia</option>\n' +
            '<option value="296">Kiribati</option>\n' +
            '<option value="898">Kosovo, Rep&uacute;blica do</option>\n' +
            '<option value="414">Kuwait</option>\n' +
            '<option value="418">Laos</option>\n' +
            '<option value="428">Let&ocirc;nia</option>\n' +
            '<option value="422">L&iacute;bano</option>\n' +
            '<option value="434">L&iacute;bia</option>\n' +
            '<option value="426">Lesoto</option>\n' +
            '<option value="430">Lib&eacute;ria</option>\n' +
            '<option value="438">Liechtenstein</option>\n' +
            '<option value="440">Litu&acirc;nia</option>\n' +
            '<option value="442">Luxemburgo</option>\n' +
            '<option value="446">Macau</option>\n' +
            '<option value="807">Maced&ocirc;nia do Norte</option>\n' +
            '<option value="450">Madagascar</option>\n' +
            '<option value="454">Malawi</option>\n' +
            '<option value="458">Mal&aacute;sia</option>\n' +
            '<option value="462">Maldivas</option>\n' +
            '<option value="466">Mali</option>\n' +
            '<option value="470">Malta</option>\n' +
            '<option value="504">Marrocos</option>\n' +
            '<option value="474">Martinica</option>\n' +
            '<option value="480">Maur&iacute;cia</option>\n' +
            '<option value="478">Maurit&acirc;nia</option>\n' +
            '<option value="175">Mayotte</option>\n' +
            '<option value="484">M&eacute;xico</option>\n' +
            '<option value="583">Micron&eacute;sia</option>\n' +
            '<option value="508">Mo&ccedil;ambique</option>\n' +
            '<option value="498">Moldova</option>\n' +
            '<option value="492">M&ocirc;naco</option>\n' +
            '<option value="496">Mong&oacute;lia</option>\n' +
            '<option value="499">Montenegro</option>\n' +
            '<option value="500">Montserrat</option>\n' +
            '<option value="104">Myanmar</option>\n' +
            '<option value="516">Nam&iacute;bia</option>\n' +
            '<option value="520">Nauru</option>\n' +
            '<option value="524">Nepal</option>\n' +
            '<option value="540">Nova Caled&ocirc;nia</option>\n' +
            '<option value="554">Nova Zeal&acirc;ndia</option>\n' +
            '<option value="558">Nicar&aacute;gua</option>\n' +
            '<option value="562">N&iacute;ger</option>\n' +
            '<option value="566">Nig&eacute;ria</option>\n' +
            '<option value="570">Niue</option>\n' +
            '<option value="574">Norfolk</option>\n' +
            '<option value="578">Noruega</option>\n' +
            '<option value="512">Om&atilde;</option>\n' +
            '<option value="586">Paquist&atilde;o</option>\n' +
            '<option value="585">Palau</option>\n' +
            '<option value="275">Palestina</option>\n' +
            '<option value="591">Panam&aacute;</option>\n' +
            '<option value="598">Papua Nova Guin&eacute;</option>\n' +
            '<option value="600">Paraguai</option>\n' +
            '<option value="604">Peru</option>\n' +
            '<option value="616">Pol&ocirc;nia</option>\n' +
            '<option value="258">Polin&eacute;sia Francesa</option>\n' +
            '<option value="620">Portugal</option>\n' +
            '<option value="630">Porto Rico</option>\n' +
            '<option value="404">Qu&ecirc;nia</option>\n' +
            '<option value="417">Quirguist&atilde;o</option>\n' +
            '<option value="826">Reino Unido</option>\n' +
            '<option value="140">Rep&uacute;blica da &Aacute;frica Central</option>\n' +
            '<option value="180">Rep&uacute;blica Democr&aacute;tica do Congo</option>\n' +
            '<option value="178">Rep&uacute;blica do Congo</option>\n' +
            '<option value="203">Rep&uacute;blica Tcheca</option>\n' +
            '<option value="638">Reuni&atilde;o (DOM)</option>\n' +
            '<option value="642">Rom&acirc;nia</option>\n' +
            '<option value="646">Ruanda</option>\n' +
            '<option value="643">R&uacute;ssia</option>\n' +
            '<option value="732">Saara Ocidental</option>\n' +
            '<option value="882">Samoa</option>\n' +
            '<option value="16">Samoa Americana</option>\n' +
            '<option value="674">San Marino</option>\n' +
            '<option value="654">Santa Helena, Ascenci&oacute;n, e Tristan da Cunha</option>\n' +
            '<option value="662">Santa L&uacute;cia</option>\n' +
            '<option value="652">S&atilde;o Bartolomeu</option>\n' +
            '<option value="659">S&atilde;o Crist&oacute;v&atilde;o e Neves</option>\n' +
            '<option value="663">S&atilde;o Martin (Fran&ccedil;a)</option>\n' +
            '<option value="534">S&atilde;o Martin (Holanda)</option>\n' +
            '<option value="666">S&atilde;o Pierre e Miquelon</option>\n' +
            '<option value="678">S&atilde;o Tom&eacute; e Pr&iacute;ncipe</option>\n' +
            '<option value="670">S&atilde;o Vicente e Grenadinas</option>\n' +
            '<option value="682">Senegal</option>\n' +
            '<option value="694">Serra Leoa</option>\n' +
            '<option value="688">S&eacute;rvia</option>\n' +
            '<option value="690">Seychelles</option>\n' +
            '<option value="702">Singapura</option>\n' +
            '<option value="760">S&iacute;ria</option>\n' +
            '<option value="706">Som&aacute;lia</option>\n' +
            '<option value="144">Sri Lanka</option>\n' +
            '<option value="728">Sud&atilde;o do Sul</option>\n' +
            '<option value="729">Sud&atilde;o</option>\n' +
            '<option value="752">Su&eacute;cia</option>\n' +
            '<option value="756">Su&iacute;&ccedil;a</option>\n' +
            '<option value="740">Suriname</option>\n' +
            '<option value="744">Svalbard e Ilhas Jan Mayen</option>\n' +
            '<option value="764">Tail&acirc;ndia</option>\n' +
            '<option value="158">Taiwan</option>\n' +
            '<option value="762">Tajiquiist&atilde;o</option>\n' +
            '<option value="834">Tanz&acirc;nia</option>\n' +
            '<option value="260">Terras Austrais Francesas</option>\n' +
            '<option value="86">Territ&oacute;rio Brit&acirc;nico do Oceano Índico</option>\n' +
            '<option value="626">Timor Leste</option>\n' +
            '<option value="768">Togo</option>\n' +
            '<option value="772">Tokelau</option>\n' +
            '<option value="776">Tonga</option>\n' +
            '<option value="780">Trinidade e Tobago</option>\n' +
            '<option value="788">Tun&iacute;sia</option>\n' +
            '<option value="792">Turquia</option>\n' +
            '<option value="795">Turcomenist&atilde;o</option>\n' +
            '<option value="798">Tuvalu</option>\n' +
            '<option value="804">Ucr&acirc;nia</option>\n' +
            '<option value="800">Uganda</option>\n' +
            '<option value="858">Uruguai</option>\n' +
            '<option value="860">Uzbequist&atilde;o</option>\n' +
            '<option value="548">Vanuatu</option>\n' +
            '<option value="336">Vaticano</option>\n' +
            '<option value="862">Venezuela</option>\n' +
            '<option value="704">Vietn&atilde;</option>\n' +
            '<option value="876">Wallis e Futuna</option>\n' +
            '<option value="894">Z&acirc;mbia</option>\n' +
            '<option value="716">Zimbabwe</option>' +

            $(addAddress).click(function () {
                var addressCounter = document.getElementsByClassName('address-label').length;
                var addressFieldHTML = '<hr/><div class="form-group">' +
                    '<label for="addressId0" class="col-sm-2 control-label">Identificador</label>' +
                    '<div class="col-sm-10">' +
                    '<input type="text" class="form-control" id="addressId0" placeholder="Escolha um nome para identificar esse endere&ccedil;o" value="" name="address[' + addressCounter +'][nickname]">' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group required">' +
                    '<label for="addressPlace0" class="col-sm-2 control-label">Logradouro*</label>' +
                    '<div class="col-sm-10">' +
                    '<input type="text" class="form-control" id="addressPlace0" placeholder="ex. Rua, Avenida, Travessa..." value="" name="address[' + addressCounter +'][place]">' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="addressNumber0" class="col-sm-2 control-label">N&uacute;mero*</label>' +
                    '<div class="col-sm-2">' +
                    '<input type="text" class="form-control" id="addressNumber0" placeholder="ex. 51" value="" name="address[' + addressCounter +'][number]">' +
                    '</div>' +
                    '<label for="addressNeighborhood0" class="col-sm-2 control-label">Bairro</label>' +
                    '<div class="col-sm-6">' +
                    '<input type="text" class="form-control" id="addressNeighborhood0" placeholder="ex. Centro" value="" name="address[' + addressCounter +'][neighborhood]">' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="addressZipCode0" class="col-sm-2 control-label">CEP*</label>' +
                    '<div class="col-sm-2">' +
                    '<input type="text" class="form-control" id="addressZipCode0" placeholder="ex. 99999-999" value="" name="address[' + addressCounter +'][zipcode]">' +
                    '</div>' +
                    '<label for="addressCompl0" class="col-sm-2 control-label">Complemento</label>' +
                    '<div class="col-sm-6">' +
                    '<input type="text" class="form-control" id="addressCompl0" placeholder="ex. Apto 10" value="" name="address[' + addressCounter +'][compl~]">' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group required">' +
                    '<label for="addressCity0" class="col-sm-2 control-label">Cidade*</label>' +
                    '<div class="col-sm-10">' +
                    '<input type="text" class="form-control" id="addressCity0" placeholder="ex. S&atilde;o Paulo" value="" name="address[' + addressCounter +'][city]">' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group required">' +
                    '<label for="state" class="col-sm-2 control-label">Estado*</label>' +
                    '<div class="col-sm-4">' +
                    '<select class="form-control" id="state" name="address[' + addressCounter +'][state]">' +
                    stateOptions +
                    '</select>' +
                    '</div>' +
                    '<label for="addressCountry0" class="col-sm-2 control-label">Pa&iacute;s*</label>' +
                    '<div class="col-sm-4">' +
                    '<select class="form-control" id="addressCountry0" name="address[' + addressCounter +'][country]">' +
                    countryOptions +
                    '</select>' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label class="col-sm-2 control-label" for="isDelivery0">Entrega?</label>' +
                    '<input type="checkbox" class="col-sm-2" id="isDelivery0" name="address[' + addressCounter +'][isDelivery]">' +
                    '<label class="col-sm-2 control-label text-right" for="isBilling0">Cobran&ccedil;a?</label>' +
                    '<input type="checkbox" class="col-sm-2 text-right" id="isBilling0" name="address[' + addressCounter +'][isBilling]">' +
                    '<label class="col-sm-2 control-label text-right" for="isMain0">Principal?</label>' +
                    '<input type="checkbox" class="col-sm-2" id="isMain0" name="address[' + addressCounter +'][isMain]">' +
                    '</div>';
                $(addressWrapper).append(addressFieldHTML);
                addressCounter++;
            })
    });
</script>
</body>
</html>