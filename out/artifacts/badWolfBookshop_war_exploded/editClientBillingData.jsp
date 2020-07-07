<%@ page import="dto.CartDTO" %>
<%@ page import="domain.Result" %>
<%@ page import="domain.DomainObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="domain.CreditCard" %>
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
                            <form action="${pageContext.request.contextPath}/alterCards" method="post" id="currency">
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
            <h2 class="text-center">Formas de Pagamento</h2>
            <form class="form-horizontal m-l-10 p-l-10" method="post" action="${pageContext.request.contextPath}/alterCards">
                <p>O pagamento pode ser realizado por meio de cupons de troca ou cart&atilde;o de cr&eacute;dito</p>
                <p>* Campos obrigat&oacute;rios</p>
                <fieldset>
                    <%
                        int max = 1;
                        List<DomainObject> cards = new ArrayList<>();
                        if(result.hasObject(CreditCard.class.getSimpleName()))
                            cards = result.getObject(CreditCard.class.getSimpleName());
                        if(cards.size() > 0)
                            max = cards.size();
                        CreditCard c = new CreditCard();
                        for(int i = 0; i < max; i++){
                            if(cards.size() > i)
                                c = (CreditCard) cards.get(i);
                    %>
                    <legend class="card-label"><%out.print(c.getCardCompany() != null ? c.getCardCompany().getName() + " terminado em " + c.getCardNumber().substring(12,16) : "Cadastre um cart&atilde;o...");%>
                        <button class="btn btn-danger pull-right" style="height:30px;"><i class="fa fa-remove"></i> </button>
                    </legend>
                    <input type="hidden" class="form-control" id="cardExpiration0"
                           name="<%out.print("card[" + i + "][id]");%>"
                           value="<%out.print(c.getId() != null ? c.getId() : "");%>">
                    <div class="form-group">
                        <label for="cardCompany0" class="col-sm-3 control-label">Bandeira</label>
                        <div class="col-sm-3">
                            <select class="form-control" id="cardCompany0"
                                    name="<%out.print("card[" + i + "][cardCompany]");%>">
                                <option value=""> -- Selecione --</option>
                                <option value="1" <%out.print(c.getCardCompany() != null && c.getCardCompany().getCode() == 1 ? "selected" : "");%>>Mastercard</option>
                                <option value="2" <%out.print(c.getCardCompany() != null && c.getCardCompany().getCode() == 2 ? "selected" : "");%>>Visa</option>
                                <option value="3" <%out.print(c.getCardCompany() != null && c.getCardCompany().getCode() == 3 ? "selected" : "");%>>American Express</option>
                                <option value="4" <%out.print(c.getCardCompany() != null && c.getCardCompany().getCode() == 4 ? "selected" : "");%>>Diner\'s Club</option>
                                <option value="5" <%out.print(c.getCardCompany() != null && c.getCardCompany().getCode() == 5 ? "selected" : "");%>>Cirrus</option>
                                <option value="6" <%out.print(c.getCardCompany() != null && c.getCardCompany().getCode() == 6 ? "selected" : "");%>>Discovery</option>
                                <option value="6" <%out.print(c.getCardCompany() != null && c.getCardCompany().getCode() == 7 ? "selected" : "");%>>Elo</option>
                                <option value="6" <%out.print(c.getCardCompany() != null && c.getCardCompany().getCode() == 8 ? "selected" : "");%>>Outro</option>
                            </select>
                        </div>
                        <label class="col-sm-3 control-label " for="cardExpiration0">Data
                            de Expira&ccedil;&atilde;o</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="cardExpiration0"
                                   name="<%out.print("card[" + i + "][cardExpiration]");%>"
                                   value="<%out.print(c.getExpiration() != null ? c.getExpiration() : "");%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="cardNumber0">N&uacute;mero do cart&atilde;o</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="cardNumber0"
                                   placeholder="ex. 9999 9999 9999 9999"
                                   name="<%out.print("card[" + i + "][cardNumber]");%>"
                                   value="<%out.print(c.getCardNumber() != null ? c.getCardNumber() : "");%>">
                        </div>
                        <label class="col-sm-1 control-label" for="cvv-btn">CVV</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="cvv-btn"
                                   name="<%out.print("card[" + i + "][cvv]");%>"
                                   value="<%out.print(c.getCvv() != null ? c.getCvv() : "");%>">
                        </div>
                        <div class="col-sm-1 text-center">
                            <a href="#" onclick="window.open('resources/image/Credit-Card-CVV.png');return false;"><i
                                    class="fa fa-question"></i></a>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="cardName0">Nome do Titular</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="cardName0"
                                   placeholder="Exatamente como aparece no cart&atilde;o"
                                   name="<%out.print("card[" + i + "][cardName]");%>"
                                   value="<%out.print(c.getHolderName() != null ? c.getHolderName() : "");%>">
                        </div>
                        <label class="col-sm-1 control-label text-right" for="isMainCard0">Principal?</label>
                        <input type="checkbox" class="col-sm-1 text-right" id="isMainCard0" name="isMainCard0" checked>
                    </div>
                    <%}%>
                    <div id="new-card-wrapper"></div>
                    <div class="row">
                        <a class="btn btn-primary m-t-40 pull-right" id="addCard">Adicionar Novo Cart&atilde;o</a>
                    </div>
                    <div class="m-t-40"></div>
                    <div class="buttons clearfix">
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
    <div class="cms_searvice">
        <div class="container">
            <div class="row">
                <%--                <div class="col-md-3 ">--%>
                <%--                    <div class="cms-block1 z-depth-5">--%>
                <%--                        <h4>Frete Gr&aacute;tis</h4>--%>
                <%--                        <p>Nas compras acima de $150</p>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <%--                <div class="col-md-3 ">--%>
                <%--                    <div class="cms-block2">--%>
                <%--                        <h4>30 Dias de Garantia</h4>--%>
                <%--                        <p>Money Back Guarantee</p>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <%--                <div class="col-md-3 ">--%>
                <%--                    <div class="cms-block3">--%>
                <%--                        <h4>24/7 Support</h4>--%>
                <%--                        <p>Feel free to Contact us</p>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <%--                <div class="col-md-3 ">--%>
                <%--                    <div class="cms-block4">--%>
                <%--                        <h4>Online Shopping </h4>--%>
                <%--                        <p>Save Up to 70% on Store</p>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
            </div>
        </div>
    </div>
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
        var addCard = $('#addCard');
        var cardWrapper = $('#new-card-wrapper');

        $(addCard).click(function () {
            var cardCounter = document.getElementsByClassName('card-label').length;
            var cardFieldHTML = '<hr/><div id="card-form" class="m-t-40">\n' +
                '<form>\n' +
                '<div class="form-group">\n' +
                '<div class="row">\n' +
                '<label for="cardCompany0" class="col-sm-3 control-label">Bandeira</label>\n' +
                '<div class="col-sm-3">\n' +
                '<select class="form-control" id="cardCompany0" name="card[' + cardCounter + '][company]">\n' +
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
                '<label class="col-sm-3 control-label " for="cardExpiration0">Data\n' +
                'de Expira&ccedil;&atilde;o</label>\n' +
                '<div class="col-sm-3">\n' +
                '<input type="text" class="form-control" id="cardExpiration0"\n' +
                'name="card[' + cardCounter + '][expiration]">\n' +
                '</div>\n' +
                '</div>\n' +
                '<div class="form-group">\n' +
                '<label class="col-sm-3 control-label" for="cardNumber0">N&uacute;mero do\n' +
                'cart&atilde;o</label>\n' +
                '<div class="col-sm-5">\n' +
                '<input type="text" class="form-control" id="cardNumber0"\n' +
                'name="card[' + cardCounter + '][number]" placeholder="ex. 9999 9999 9999 9999">\n' +
                '</div>\n' +
                '\n' +
                '<label class="col-sm-1 control-label" for="CVV">CVV</label>\n' +
                '<div class="col-sm-2">\n' +
                '<input type="text" class="form-control" id="CVV"\n' +
                'name="card[' + cardCounter + '][cvv]">\n' +
                '</div>\n' +
                '<div class="col-sm-1 text-center">\n' +
                '<a href="#" onclick="window.open(\'resources/image/Credit-Card-CVV.png\');return false;"><i ' +
                'class="fa fa-question"></i></a>\n' +
                '</div>\n' +
                '</div>\n' +
                '</div>\n' +
                '<div class="row">\n' +
                '<div class="form-group">\n' +
                '<label class="col-sm-2 control-label" for="cardName0">Nome do\n' +
                'Titular</label>\n' +
                '<div class="col-sm-8">\n' +
                '<input type="text" class="form-control" id="cardName0"\n' +
                'name="card[' + cardCounter + '][name]"\n' +
                'placeholder="Exatamente como aparece no cart&atilde;o">\n' +
                '</div>\n' +
                '<label class="col-sm-1 control-label text-right" for="isMainCard0">Cart&atilde;o Principal?</label>\n' +
                '<input type="checkbox" class="col-sm-1 text-right" id="isMainCard0"\n' +
                'name="card[' + cardCounter + '][isMainCard]" checked>\n' +
                '</div>\n' +
                '</div>\n' +
                '</form>\n' +
                '</div>';
            $(cardWrapper).append(cardFieldHTML);
            cardCounter++;
        })

    });
</script>
</body>
</html>