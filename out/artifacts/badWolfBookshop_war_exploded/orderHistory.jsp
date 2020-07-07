<%@ page import="dto.CartDTO" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.List" %>
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
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/resources/css/googleFonts.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/stylesheet.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.css" type="text/css" rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.transitions.css" type="text/css" rel="stylesheet" media="screen"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/template_js/jstree.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/template_js/template.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/global.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.min.js"></script>
</head>
<body class="index">
<div class="preloader loader" style="display: block;"><img src="${pageContext.request.contextPath}/resources/image/loader-circle.gif" alt="#"/></div>
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
                                        <li><a href="editClientPersonalData.jsp">Configura&ccedil;&otilde;es</a></li>
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
                <div id="logo"><a href="index.jsp"><img src="${pageContext.request.contextPath}/resources/image/logo.jpg" title="E-Commerce"
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
<%--    <h1>Shopping Cart</h1>--%>
<%--    <ul>--%>
<%--        <li><a href="index.html">Home</a></li>--%>
<%--        <li><a href="cart.html">Shopping Cart</a></li>--%>
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
    <div class="row m-t-40">
        <div id="column-left" class="col-sm-3 hidden-xs column-left">
            <div class="Categories left-sidebar-widget" style="position: absolute">
                <div class="columnblock-title">Hist&oacute;rico de Compras</div>
            </div>
        </div>
        <div class="col-sm-9" id="content">
            <div id="accordion" class="panel-group">
                <div class="panel panel-default">
                    <%
                        if(result.hasObject(Order.class.getSimpleName())) {
                            List<DomainObject> orders = result.getObject(Order.class.getSimpleName());
                            for(DomainObject d : orders){
                                Order order = (Order) d;
                    %>
                    <div class="panel-heading">
                        <h4 class="panel-title"><a class="accordion-toggle collapsed" data-parent="#accordion"
                                                   data-toggle="collapse" href="#collapse-order-<%out.print(order.getId());%>"
                                                   aria-expanded="false">Pedido #<%out.print(order.getId());%> - <%out.print(DateTimeFormatter.ofPattern("dd/MM/yyyy").format(order.getCreation()));%> <i
                                class="fa fa-caret-down"></i></a>
<%
    String label = "";
    switch (order.getStatus().getCode()) {
        case 1:
            label = "label-success";
            break;
        case 2:
            label = "label-primary";
            break;
        case 11:
            label = "label-warning";
            break;
        case 3:
        case 6:
            label = "label-info";
            break;
        case 5:
        case 8:
        case 10:
            label = "label-danger";
            break;
        default:
            label = "label-default";
            break;
    }
%>
                            <span class="label <%out.print(label);%> m-r-20 pull-right"><%out.print(order.getStatus().getTitle());%></span>
                        </h4>
                    </div>
                    <div id="collapse-order-<%out.print(order.getId());%>" role="heading" class="panel-collapse collapse"
                         aria-expanded="false" style="height: 0px;">
                        <div class="panel-body">
                            <%if(order.getItems() != null && order.getItems().size() > 0){
                                for(OrderItem item : order.getItems()){%>
                            <div class="row">
                                <div class="col-sm-2">
                                    <a href="${pageContext.request.contextPath}/book/<%out.print(item.getBook().getId());%>"><img class="img-thumbnail" style="max-height: 50px;" title="Produto" alt="Imagem do Produto" src="${pageContext.request.contextPath}/<%out.print(item.getBook().getImages().get(0).getPath());%>"></a>
                                </div>
                                <div class="col-sm-5">
                                    <a href="${pageContext.request.contextPath}/book/<%out.print(item.getBook().getId());%>"><%out.print(item.getBook().getTitle());%></a>
                                </div>
                                <div class="col-sm-1">Qtde: <%out.print(item.getQuantity());%></div>
                                <div class="col-sm-1"><a>$<%out.print(String.format("%.2f", item.getBook().getPrice()));%></a></div>
                                <form method="post" action="book/return">
                                <%if(item.getStatus().getCode()<4){%>
                                <div class="col-sm-3 pull-right"><button type="submit" class="btn label pull-right" id="cancelItem<%out.print(item.getId());%>">Cancelar Item</button> </div>
                                <%} else if(item.getStatus().equals(Status.DELIVERED)){%>
                                <div class="col-sm-3 pull-right"><button type="submit" class="btn label pull-right" id="returnItem<%out.print(item.getId());%>">Devolver/Trocar</button> </div>
                                <%} else {%>
                                    <div class="col-sm-3 pull-right text-right"><p style="color: darkorange;"><strong><%out.print(item.getStatus().getTitle());%></strong></p> </div>
                                <%}%>
                                    <input type="hidden" name="orderId" value="<%out.print(order.getId());%>">
                                    <input type="hidden" name="itemId" value="<%out.print(item.getId());%>">
                                </form>
                            </div>
                            <hr/>
                            <%
                            }
                            }%>
                        </div>
                    </div>
                    <%

                            }
                        }%>
                </div>
<%--                <div class="panel panel-default">--%>
<%--                    <div class="panel-heading">--%>
<%--                        <h4 class="panel-title"><a class="accordion-toggle collapsed" data-parent="#accordion"--%>
<%--                                                   data-toggle="collapse" href="#collapse-order-2"--%>
<%--                                                   aria-expanded="false">Pedido #QWE789EWQ - 17/01/2020 <i--%>
<%--                                class="fa fa-caret-down"></i></a><span class="label label-success m-r-20 pull-right">Entregue</span></h4>--%>
<%--                    </div>--%>
<%--                    <div id="collapse-order-2" role="heading" class="panel-collapse collapse"--%>
<%--                         aria-expanded="false" style="height: 0px;">--%>
<%--                        <div class="panel-body">--%>
<%--                            <%for(int i = 0; i < 3; i++){%>--%>
<%--                            <div class="row">--%>
<%--                                <div class="col-sm-2">--%>
<%--                                    <a href="bookDetail.jsp"><img class="img-thumbnail" title="Produto" alt="Imagem do Produto" src="resources/image/book-front-50x64.jpg"></a>--%>
<%--                                </div>--%>
<%--                                <div class="col-sm-5">--%>
<%--                                    <a href="bookDetail.jsp">T&iacute;tulo do Livro</a>--%>
<%--                                </div>--%>
<%--                                <div class="col-sm-1">Qtde: 1</div>--%>
<%--                                <div class="col-sm-1"><a>$24.00</a></div>--%>
<%--                                <div class="col-sm-3 pull-right"><a class="btn label pull-right" href="returnItem.jsp">Devolver/Trocar</a> </div>--%>
<%--                            </div>--%>
<%--                            <%if(i < 2){%>--%>
<%--                            <hr/>--%>
<%--                            <%}}%>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="panel panel-default">--%>
<%--                    <div class="panel-heading">--%>
<%--                        <h4 class="panel-title"><a class="accordion-toggle collapsed" data-parent="#accordion"--%>
<%--                                                   data-toggle="collapse" href="#collapse-order-3"--%>
<%--                                                   aria-expanded="false">Pedido #321CDE654 - 18/12/2019 <i--%>
<%--                                class="fa fa-caret-down"></i></a><span class="label label-danger m-r-20 pull-right">Troca/Devolu&ccedil;&atilde;o</span></h4>--%>
<%--                    </div>--%>
<%--                    <div id="collapse-order-3" role="heading" class="panel-collapse collapse"--%>
<%--                         aria-expanded="false" style="height: 0px;">--%>
<%--                        <div class="panel-body">--%>
<%--                            <%for(int i = 0; i < 3; i++){%>--%>
<%--                            <div class="row">--%>
<%--                                <div class="col-sm-2">--%>
<%--                                    <a href="bookDetail.jsp"><img class="img-thumbnail" title="Produto" alt="Imagem do Produto" src="resources/image/book-front-50x64.jpg"></a>--%>
<%--                                </div>--%>
<%--                                <div class="col-sm-5">--%>
<%--                                    <p><a href="bookDetail.jsp">T&iacute;tulo do Livro</a></p>--%>
<%--                                    <p><strong>Motivo da Troca:</strong></p>--%>
<%--                                    <p>Motivo da Troca Informado na Solicita&ccedil;&atilde;o</p>--%>
<%--                                </div>--%>
<%--                                <div class="col-sm-1">Qtde: 1</div>--%>
<%--                                <div class="col-sm-1"><a>$24.00</a></div>--%>
<%--                                <div class="col-sm-3 pull-right"><a class="btn label pull-right" disabled="true" >Pendente</a> </div>--%>
<%--                            </div>--%>
<%--                            <%if(i < 2){%>--%>
<%--                            <hr/>--%>
<%--                            <%}}%>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
</div>
<div class="footer-top-cms parallax-container">
    <div class="parallax"><img src="${pageContext.request.contextPath}/resources/image/parallax1.jpg" alt="#"></div>
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
                        <li class="mastero"><a href="#"><img alt="" src="${pageContext.request.contextPath}/resources/image/payment/mastero.jpg"></a></li>
                        <li class="visa"><a href="#"><img alt="" src="${pageContext.request.contextPath}/resources/image/payment/visa.jpg"></a></li>
                        <li class="currus"><a href="#"><img alt="" src="${pageContext.request.contextPath}/resources/image/payment/currus.jpg"></a></li>
                        <li class="discover"><a href="#"><img alt="" src="${pageContext.request.contextPath}/resources/image/payment/discover.jpg"></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <a id="scrollup">Scroll</a>
</footer>

<script src="${pageContext.request.contextPath}/resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        $('.parallax').parallax();
    });
</script>
</body>
</html>
