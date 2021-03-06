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
    <%--    <link href="resources/image/favicon.png" rel="icon" type="image/png" >--%>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/resources/css/googleFonts.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/stylesheet.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.css" type="text/css" rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.transitions.css" type="text/css" rel="stylesheet" media="screen"/>
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
                <div id="logo"><a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/resources/image/logo.jpg" title="E-Commerce"
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
          <span>Carrinho</span><br>
                        <div id="cartItems"><%
                        CartDTO cart = (CartDTO) request.getSession().getAttribute("cart");
                        if(cart == null)
                            out.print("0 item(s) - $0.00");
                        else
                            out.print(cart.getNumberOfItems() + " item(s) - $" + String.format("%.2f", cart.getTotal()));
                        %></div></span></a>
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
<%--    <h1>Product</h1>--%>
<%--    <ul>--%>
<%--        <li><a href="index.html">Home</a></li>--%>
<%--        <li><a href="category.html">Desktops</a></li>--%>
<%--        <li><a href="#">Casual Shirt With Ruffle Hem</a></li>--%>
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
        <%
            if (result.getObject(Book.class.getSimpleName()) != null) {
//                                for (DomainObject d : result.getObject(Book.class.getSimpleName())) {
                Book b = (Book) result.getObject(Book.class.getSimpleName()).get(0);
        %>
        <div class="content col-sm-12">
            <div class="row">
                <div class="col-sm-5">
                    <div class="thumbnails">
                        <div><a class="thumbnail fancybox"><img style="max-height: 500px;" src="<%out.print(b.getImages().size() > 0 ? b.getImages().get(0).getPath():"");%>"
                                                                    title="T&iacute;tulo do Livro" alt="Capa do Livro"/></a>
                        </div>
                        <%for(Image i : b.getImages()){%>
                        <div id="product-thumbnail" class="owl-carousel">
                            <div class="item">
                                <div class="image-additional">
                                    <a class="thumbnail fancybox" href=""
                                                                 title="Livro"> <img style="max-height: 100px;"
                                        src="<%out.print(i.getPath());%>" title="T&iacute;tulo do Livro"
                                        alt="Capa do Livro"/></a></div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="col-sm-7 prodetail">
                    <h1 class="productpage-title"><%out.print(b.getTitle());%></h1>
                    <div class="rating"><span class="fa fa-stack"><i class="fa fa-thumbs-o-up fa-stack-2x"></i><i
                            class="fa fa-thumbs-up fa-stack-2x"></i></span> <span class="fa fa-stack"><i
                            class="fa fa-thumbs-o-up fa-stack-2x"></i><i class="fa fa-thumbs-up fa-stack-2x"></i></span>
                        <span
                                class="fa fa-stack"><i class="fa fa-thumbs-o-up fa-stack-2x"></i><i
                                class="fa fa-thumbs-up fa-stack-2x"></i></span> <span class="fa fa-stack"><i
                                class="fa fa-thumbs-o-up fa-stack-2x"></i><i
                                class="fa fa-thumbs-up fa-stack-2x"></i></span> <span
                                class="fa fa-stack"><i class="fa fa-thumbs-o-up fa-stack-2x"></i></span><span
                                class="riview"><a
                                href="#">1 Avalia&ccedil;&atilde;o</a> / <a
                                href="#">Escrever Avalia&ccedil;&atilde;o</a></span></div>
                    <ul class="list-unstyled productinfo-details-top">
                        <li>
                            <h2 class="productpage-price">$<%out.print(String.format("%.2f", b.getPrice()));%></h2>
                        </li>
                    </ul>
                    <hr>
                    <ul class="list-unstyled product_info">
                        <li>
                            <label>Autor(es):</label>
                            <span> <a href="#"><%
                                List<Author> authors = b.getAuthors();
                                int authorNum = b.getAuthors().size();
                                for(int i =0; i < authorNum; i++){
                                    out.print(authors.get(i).getName());
                                    if(i < authorNum -1){
                                        out.print("; ");
                                    }
                                }

                            %></a></span></li>
                        <li>
                            <label>Editora:</label>
                            <span> <%out.print(b.getPublisher().getName());%></span></li>
                        <li>
                            <label>Disponibilidade:</label>
                            <span> <%
                                if(b.getInStock() < 1){
                                    out.print("Em Falta. Se comprar este produto, ele será enviado assim que estiver disponível.");
                                } else if(b.getInStock() < 10) {
                                    out.print("Restam poucas unidades em estoque. Corra e garanta o seu!!");
                                } else {
                                    out.print("Em estoque.");
                                }
                            %></span></li>
                    </ul>
                    <hr>
                    <p class="product-desc"> <%
                        String summary = "";
                        if( b.getSummary().length() <= 100)
                            summary = b.getSummary();
                        else
                            summary = b.getSummary().substring(0, 100) + "...";
                        out.print(summary);%>
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
                                                    data-placement="top" title="Colocar no Carrinho" onclick="addToCart(<%%>)"><i
                                                    class="fa fa-shopping-cart"></i></button>
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
                <li class="active"><a href="#tab-description" data-toggle="tab">Descri&ccedil;&atilde;o do
                    Produto</a></li>
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
                    <!-- cpt_container_end --></div>
                <div class="tab-pane" id="tab-review">
                    <form class="form-horizontal">
                        <div id="review"></div>
                        <h2>Deixe sua avalia&ccedil;&atilde;o</h2>
                        <p>&Eacute; necess&aacute;rio estar logado no site para postar avalia&ccedil;&otilde;es.</p>
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label" for="input-review">Sua Avalia&ccedil;&atilde;o</label>
                                <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                                <%--                                    <div class="help-block"><span class="text-danger">Note:</span> HTML is not translated!</div>--%>
                            </div>
                        </div>
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label">Classifica&ccedil;&atilde;o</label>
                                &nbsp;&nbsp;&nbsp; P&eacute;ssimo&nbsp;
                                <input type="radio" name="rating" value="1"/>
                                &nbsp;
                                <input type="radio" name="rating" value="2"/>
                                &nbsp;
                                <input type="radio" name="rating" value="3"/>
                                &nbsp;
                                <input type="radio" name="rating" value="4"/>
                                &nbsp;
                                <input type="radio" name="rating" value="5"/>
                                &nbsp;Excelente
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
                                <img src="${pageContext.request.contextPath}/resources/image/book-front-150x192.jpg" alt="Livro"
                                     title="Livro" class="img-responsive"/>
                                <img src="${pageContext.request.contextPath}/resources/image/book-front-150x192.jpg" alt="Livro"
                                     title="Livro" class="img-responsive"/>
                            </a>
                            <ul class="button-group grid-btn">
                                <li>
                                    <button type="button" class="wishlist" data-toggle="tooltip"
                                            data-placement="top" title="Adicionar &agrave; Lista de Desejos"><i
                                            class="fa fa-heart-o"></i></button>
                                </li>
                                <li>
                                    <button type="button" class="wishlist" data-toggle="tooltip"
                                            data-placement="top" title="Colocar no Carrinho"><i
                                            class="fa fa-shopping-cart"></i></button>
                                </li>
                            </ul>
                        </div>
                        <div class="caption product-detail">
                            <div class="rating"><span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i><i
                                    class="fa fa-thumbs-up fa-stack-2x"></i></span> <span class="fa fa-stack"><i
                                    class="fa fa-thumbs-o-up fa-stack-2x"></i><i
                                    class="fa fa-thumbs-up fa-stack-2x"></i></span> <span class="fa fa-stack"><i
                                    class="fa fa-thumbs-o-up fa-stack-2x"></i><i
                                    class="fa fa-thumbs-up fa-stack-2x"></i></span> <span class="fa fa-stack"><i
                                    class="fa fa-thumbs-o-up fa-stack-2x"></i><i
                                    class="fa fa-thumbs-up fa-stack-2x"></i></span> <span class="fa fa-stack"><i
                                    class="fa fa-thumbs-o-up fa-stack-2x"></i></span></div>
                            <h4 class="product-name"><a href="#" title="product-name">Nome do Produto</a></h4>
                            <p class="price product-price">$122.00</p>
                            <ul class="button-group list-btn">
                                <li>
                                    <button type="button" class="wishlist" data-toggle="tooltip"
                                            data-placement="top" title="Adicionar &agrave; Lista de Desejos"><i
                                            class="fa fa-heart-o"></i></button>
                                </li>
                                <li>
                                    <button type="button" class="addtocart-btn" data-toggle="tooltip"
                                            data-placement="top" title="Colocar no Carrinho"><i
                                            class="fa fa-shopping-cart"></i></button>
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
                        diretamente
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/template_js/jstree.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/template_js/template.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/global.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/javascript/custom.js"></script>
<script src="${pageContext.request.contextPath}/resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        $('.parallax').parallax();
    });
    var CART_ITEMS = $('#cartItems');
    var ADD_TO_CART = $('#addToCart')

    function addToCart(id) {
        var data = {id:id};
        fetch("/book/addToCart", {
            method: "POST",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        }).then(function (){
            var cur = parseInt(CART_ITEMS);
            CART_ITEMS.html(cur+1);
        });
    }

    // ADD_TO_CART.onclick(function (){
    //     var data = {id: ADD_TO_CART.val()};
    //     fetch("/book/addToCart", {
    //         method: "POST",
    //         headers: {
    //             'Accept': 'application/json',
    //             'Content-Type': 'application/json'
    //         },
    //         body: JSON.stringify(data)
    //     }).then(function (){
    //         var cur = parseInt(CART_ITEMS);
    //         CART_ITEMS.html(cur+1);
    //     });
    // })
</script>
</body>
</html>