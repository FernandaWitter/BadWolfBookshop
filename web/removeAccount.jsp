<%@ page import="dto.CartDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bad Wolf Bookshop</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="e-commerce site well design with responsive view."/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <link href="resources/javascript/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css"/>
    <link href="resources/css/googleFonts.css" rel="stylesheet"/>
    <link href="resources/css/stylesheet.css" rel="stylesheet">
    <link href="resources/css/responsive.css" rel="stylesheet">
    <link href="resources/javascript/owl-carousel/owl.carousel.css" type="text/css" rel="stylesheet" media="screen"/>
    <link href="resources/javascript/owl-carousel/owl.transitions.css" type="text/css" rel="stylesheet" media="screen"/>
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
                                <li class="dropdown">
                                    <a href="#" title="Conta" class="dropdown-toggle" data-toggle="dropdown">
                                        <i class="fa fa-user" aria-hidden="true"></i><span>Perfil</span>
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
                    <a href="index.jsp">
                        <img src="resources/image/logo.jpg" title="E-Commerce" alt="E-Commerce" class="img-responsive"/>
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
            <h2 class="text-center">EXCLUIR A CONTA?</h2>
            <div class="m-t-40"></div>
            <h3>Tem certeza que deseja excluir sua conta? N&atilde;o ser&aacute; mais poss&iacute;vel realizar compras,
                e todos os produtos salvos no seu carrinho ser&atilde;o perdidos. E, mais importante, n&atilde;o
                queremos que voc&ecirc; se v&aacute;!</h3>
            <div class="m-t-40"></div>
            <form action="${pageContext.request.contextPath}/deleteAccount">
                <div class="buttons clearfix">
                    <div class="pull-right">
                        <button type="submit" class="btn btn-danger">Excluir Conta</button>
                    </div>
                </div>
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
                        <li class="mastero"><img alt="Logo MasterCard Maestro" src="resources/image/payment/mastero.jpg"></li>
                        <li class="visa"><img alt="Logo Visa" src="resources/image/payment/visa.jpg"></li>
                        <li class="currus"><img alt="Logo Cirrus" src="resources/image/payment/currus.jpg"></li>
                        <li class="discover"><img alt="Logo Discover" src="resources/image/payment/discover.jpg"></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
<script type="text/javascript" src="resources/javascript/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="resources/javascript/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/javascript/template_js/jstree.min.js"></script>
<script type="text/javascript" src="resources/javascript/template_js/template.js"></script>
<script type="text/javascript" src="resources/javascript/common.js"></script>
<script type="text/javascript" src="resources/javascript/global.js"></script>
<script type="text/javascript" src="resources/javascript/owl-carousel/owl.carousel.min.js"></script>
<script src="resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        $('.parallax').parallax();
    });
</script>
</body>
</html>