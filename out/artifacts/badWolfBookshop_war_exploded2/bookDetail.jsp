<%@ page import="domain.*" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.CartDTO" %>
<!DOCTYPE html>
<html lang="en">
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
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.css"
          type="text/css" rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.transitions.css"
          type="text/css" rel="stylesheet" media="screen"/>
</head>
<body class="index">
<div class="preloader loader" style="display: block;">
    <img src="resources/image/loader-circle.gif" alt="#"/>
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
                                        <span>Perfil</span><span class="caret"></span>
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
    Result result;
    if(request.getAttribute("result") != null)
        result = (Result) request.getAttribute("result");
    else
        result = new Result();
%>
<div class="container">
    <div class="row">
        <%
            if (result.getObject(Book.class.getSimpleName()) != null) {
                Book b = (Book) result.getObject(Book.class.getSimpleName()).get(0);
        %>
        <div class="content col-sm-12">
            <div class="row">
                <div class="col-sm-5">
                    <div class="thumbnails">
                        <div>
                            <a class="thumbnail fancybox">
                                <img style="max-height: 500px;" src="<%out.print(b.getImages().size() > 0 ? b.getImages().get(0).getPath():"");%>"
                                     title="<%out.print(b.getTitle());%>" alt="Capa do Livro <%out.print(b.getTitle());%>"/>
                            </a>
                        </div>
                        <%for(Image i : b.getImages()){%>
                        <div id="product-thumbnail" class="owl-carousel">
                            <div class="item">
                                <div class="image-additional">
                                    <a class="thumbnail fancybox" href="" title="<%out.print(b.getTitle());%>">
                                        <img style="max-height: 100px;" src="<%out.print(i.getPath());%>"
                                             title="<%out.print(b.getTitle());%>"
                                             alt="Capa do Livro <%out.print(b.getTitle());%>"/>
                                    </a>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="col-sm-7 prodetail">
                    <h1 class="productpage-title"><%out.print(b.getTitle());%></h1>
                    <div class="rating">
                        <span class="fa fa-stack">
                            <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                            <i class="fa fa-thumbs-up fa-stack-2x"></i>
                        </span>
                        <span class="fa fa-stack">
                            <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                            <i class="fa fa-thumbs-up fa-stack-2x"></i>
                        </span>
                        <span class="fa fa-stack">
                            <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                            <i class="fa fa-thumbs-up fa-stack-2x"></i>
                        </span>
                        <span class="fa fa-stack">
                            <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                            <i class="fa fa-thumbs-up fa-stack-2x"></i>
                        </span>
                        <span class="fa fa-stack">
                            <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                        </span>
                    </div>
                    <ul class="list-unstyled productinfo-details-top">
                        <li>
                            <h2 class="productpage-price">$<%out.print(String.format("%.2f", b.getPrice()));%></h2>
                        </li>
                    </ul>
                    <hr/>
                    <ul class="list-unstyled product_info">
                        <li>
                            <label>Autor(es):</label>
                            <span>
                                <%
                                List<Author> authors = b.getAuthors();
                                int authorNum = b.getAuthors().size();
                                for(int i =0; i < authorNum; i++){
                                    out.print(authors.get(i).getName());
                                    if(i < authorNum -1){
                                        out.print("; ");
                                    }
                                }
                                %>
                            </span>
                        </li>
                        <li>
                            <label>Editora:</label>
                            <span> <%out.print(b.getPublisher().getName());%></span>
                        </li>
                        <li>
                            <label>Disponibilidade:</label>
                            <span>
                                <%
                                    if(b.getInStock() < 1){
                                        out.print("Em Falta. Se comprar este produto, ele será enviado assim que estiver disponível.");
                                    } else if(b.getInStock() < 10) {
                                        out.print("Restam poucas unidades em estoque. Corra e garanta o seu!!");
                                    } else {
                                        out.print("Em estoque.");
                                    }
                                %>
                            </span>
                        </li>
                    </ul>
                    <hr>
                    <p class="product-desc">
                        <%
                            String summary = "";
                            if( b.getSummary().length() <= 100)
                                summary = b.getSummary();
                            else
                                summary = b.getSummary().substring(0, 100) + "...";
                            out.print(summary);
                        %>
                    </p>
                    <div id="product">
                        <form action="addToCart" method="POST">
                            <div class="form-group">
                                <div class="qty">
                                    <label for="qty">Quantidade</label>
                                    <input id="qty" name="qty" placeholder="1" type="number" value="1">
                                    <ul class="button-group list-btn">
                                        <li>
                                            <button type="button" class="wishlist" data-toggle="tooltip"
                                                    data-placement="top"
                                                    title="Adicionar &agrave; Lista de Desejos"><i
                                                    class="fa fa-heart-o"></i></button>
                                        </li>
                                        <li>
                                            <button type="submit" class="addtocart-btn" data-toggle="tooltip" name="operation" value="addToCart"
                                                    data-placement="top" title="Colocar no Carrinho">
                                                <i class="fa fa-shopping-cart"></i>
                                            </button>
                                            <input type="hidden" name="bookId" value="<%out.print(b.getId());%>"/>
                                            <input type="hidden" name="price" value="<%out.print(b.getPrice());%>"/>
                                            <input type="hidden" name="cover" value="<%out.print(b.getImages().size() > 0 ? b.getImages().get(0).getPath() : "");%>"/>
                                            <input type="hidden" name="title" value="<%out.print(b.getTitle());%>"/>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="productinfo-tab">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-description" data-toggle="tab">Descri&ccedil;&atilde;o do Produto</a></li>
                <li><a href="#tab-review" data-toggle="tab">Avalia&ccedil;&otilde;es (0)</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab-description">
                    <div class="cpt_product_description ">
                        <div>
                            <p><strong>Descri&ccedil;&atilde;o do produto.</strong></p>
                            <p><%out.print(b.getSummary());%></p>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="tab-review">
                    <form class="form-horizontal">
                        <div id="review"></div>
                        <h2>Deixe sua avalia&ccedil;&atilde;o</h2>
                        <p>&Eacute; necess&aacute;rio estar logado no site para postar avalia&ccedil;&otilde;es.</p>
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label" for="input-review">Sua Avalia&ccedil;&atilde;o</label>
                                <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                                </div>
                        </div>
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label">Classifica&ccedil;&atilde;o</label>&nbsp;&nbsp;&nbsp; P&eacute;ssimo&nbsp;
                                <input type="radio" name="rating" value="1"/>&nbsp;
                                <input type="radio" name="rating" value="2"/>&nbsp;
                                <input type="radio" name="rating" value="3"/>&nbsp;
                                <input type="radio" name="rating" value="4"/>&nbsp;
                                <input type="radio" name="rating" value="5"/>&nbsp;Excelente
                            </div>
                        </div>
                        <div class="buttons clearfix">
                            <div class="pull-right">
                                <button type="button" id="button-review" data-loading-text="Loading..."
                                        class="btn btn-primary">Salvar Avalia&ccedil;&atilde;o
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%} else {
                out.print("<h3> Produto n&atilde;o encontrado!</h5><br/><p> Parece que o produto selecionado n&atilde;o est&aacute; indispon&iacute;vel no momento. Que tal dar uma olhada no resto do nosso acervo?");
        }%>
        <h3 class="productblock-title">Produtos Relacionados</h3>
        <h4 class="title-subline">Que tal aproveitar e dar uma olhada nesses tamb&eacute;m?</h4>
        <div class="box">
            <div id="related-slidertab" class="row owl-carousel product-slider">
                <% for (int i = 0; i < 4; i++) {%>
                <div class="product-layout product-list col-xs-12">
                    <div class="product-thumb">
                        <div class="image product-imageblock">
                            <a href="bookDetail.jsp">
                                <img src="${pageContext.request.contextPath}/resources/image/book-front-150x192.jpg"
                                     alt="Livro" title="Livro" class="img-responsive"/>
                                <img src="${pageContext.request.contextPath}/resources/image/book-front-150x192.jpg"
                                     alt="Livro" title="Livro" class="img-responsive"/>
                            </a>
                            <ul class="button-group grid-btn">
                                <li>
                                    <button type="button" class="wishlist" data-toggle="tooltip"
                                            data-placement="top" title="Adicionar &agrave; Lista de Desejos">
                                        <i class="fa fa-heart-o"></i>
                                    </button>
                                </li>
                                <li>
                                    <button type="button" class="wishlist" data-toggle="tooltip"
                                            data-placement="top" title="Colocar no Carrinho">
                                        <i class="fa fa-shopping-cart"></i>
                                    </button>
                                </li>
                            </ul>
                        </div>
                        <div class="caption product-detail">
                            <div class="rating">
                                <span class="fa fa-stack">
                                    <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                                    <i class="fa fa-thumbs-up fa-stack-2x"></i>
                                </span>
                                <span class="fa fa-stack">
                                    <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                                    <i class="fa fa-thumbs-up fa-stack-2x"></i>
                                </span>
                                <span class="fa fa-stack">
                                    <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                                    <i class="fa fa-thumbs-up fa-stack-2x"></i>
                                </span>
                                <span class="fa fa-stack">
                                    <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                                    <i class="fa fa-thumbs-up fa-stack-2x"></i>
                                </span>
                                <span class="fa fa-stack">
                                    <i class="fa fa-thumbs-o-up fa-stack-2x"></i>
                                </span>
                            </div>
                            <h4 class="product-name">
                                <a href="#" title="product-name">Nome do Produto</a>
                            </h4>
                            <p class="price product-price">$122.00</p>
                            <ul class="button-group list-btn">
                                <li>
                                    <button type="button" class="wishlist" data-toggle="tooltip"
                                            data-placement="top" title="Adicionar &agrave; Lista de Desejos">
                                        <i class="fa fa-heart-o"></i>
                                    </button>
                                </li>
                                <li>
                                    <button type="button" class="addtocart-btn" data-toggle="tooltip"
                                            data-placement="top" title="Colocar no Carrinho">
                                        <i class="fa fa-shopping-cart"></i>
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <%}%>
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
                ul class="list-unstyled ul-wrapper">
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
            <div class="copyright"> Copyright - <a class="yourstore" href="http://www.lionode.com/"> Created by Lionode &copy; 2017 </a></div>
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
    <a id="scrollup">Scroll</a>
</footer>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/jquery-2.1.1.min.js"></script>
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
<script src="${pageContext.request.contextPath}/resources/javascript/custom.js"></script>
<script src="${pageContext.request.contextPath}/resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        $('.parallax').parallax();
    });
</script>
</body>
</html>