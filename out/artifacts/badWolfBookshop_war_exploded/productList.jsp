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
<body class="col-2 left-col">
<div class="preloader loader" style="display: block;"><img src="resources/image/loader-circle.gif" alt="#"/></div>
<header>
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="top-left pull-left">
                        <div class="wel-come-msg" style="font-size: 24px"><a href="#"><img
                                src="resources/image/logo_black_small.jpg" title="Bad Wolf Bookshop"
                                alt="Bad Wolf Bookshop Logo" class="img-responsive"/></a></div>
                    </div>
                    <div class="top-right pull-right">
                        <div id="top-links" class="nav pull-right">
                            <ul class="list-inline">
                                <li class="dropdown"><a href="#" title="Conta" class="dropdown-toggle"
                                                        data-toggle="dropdown"><i class="fa fa-user"
                                                                                  aria-hidden="true"></i><span>Perfil</span>
                                    <span class="caret"></span></a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li><a href="index.jsp">Sair</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

</header>
<nav id="menu" class="navbar">
    <div class="nav-inner">

        <div class="navbar-collapse">
            <ul class="main-navigation">
                <li><a href="dashboard.jsp" class="active parent">Dashboard</a>
                </li>
                <li><a href="#" class="active parent">Produtos</a>
                    <ul>
                        <li><a href="productList.jsp">Listagem de Produtos</a></li>
                        <li><a href="bookRegistration.jsp">Cadastrar Produto</a></li>
                    </ul>
                </li>
                <li><a href="#" class="active parent">Pedidos</a>
                    <ul>
                        <li><a href="orderList.jsp">Listagem de Pedidos</a></li>
                        <li><a href="orderList.jsp">Pedidos em Aberto</a></li>
                        <li><a href="orderList.jsp">Pedidos de Troca e Devolu&ccedil;&atilde;o</a></li>
                    </ul>
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
<div class="container">
    <div class="row">
        <div class="container" style="height:40px;"></div>
        <div class="center-block" id="content">
            <h2 class="text-center m-b-20">Listagem de Produtos</h2>
            <div class="category-page-wrapper">
                <div class="col-md-2 text-right sort-wrapper">
                    <label class="control-label" for="input-sort">Ordenar :</label>
                    <div class="sort-inner">
                        <select id="input-sort" class="form-control">
                            <option value="ASC" selected="selected">Mais Recentes</option>
                            <option value="ASC">Mais Antigos</option>
                            <option value="ASC">Nome (A - Z)</option>
                            <option value="DESC">Nome (Z - A)</option>
                            <option value="ASC">Valor</option>
                            <option value="DESC">Status</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-1 text-right page-wrapper">
                    <label class="control-label" for="input-limit">Exibir :</label>
                    <div class="limit">
                        <select id="input-limit" class="form-control">
                            <option value="8" selected="selected">15</option>
                            <option value="25">30</option>
                            <option value="50">50</option>
                            <option value="75">100</option>
                            <option value="100">Todos</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-6 pull-right">
                    <form>

                        <%--                        <div class="row">--%>
                        <input id="searchProduct" type="text" class="col-sm-4 input-lg col-sm-offset-3"
                               style="box-shadow: 0 0 2px #189b79 !important;">
                        <button class="btn btn-primary col-sm-4 pull-right">Buscar</button>
                        <label for="searchProduct" hidden>Caixa de Busca</label>
                        <%--                        </div>--%>
                    </form>
                </div>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <td class="text-center">Produto</td>
                    <td class="text-left">Nome</td>
                    <td class="text-left">Estoque</td>
                    <td class="text-right">Valor Unit&aacute;rio</td>
                    <td class="text-center">Status</td>
                    <td class="text-center">Editar</td>
                </tr>
                </thead>
                <tbody>
                <%for (int i = 0; i < 15; i++) {%>
                <tr>
                    <td class="text-center"><a href="bookDetail.jsp"><img class="img-thumbnail" title="Produto"
                                                                          alt="Imagem do Produto"
                                                                          src="resources/image/book-front-25x32.jpg"></a>
                    </td>
                    <td class="text-left"><a href="bookDetail.jsp">Livro</a></td>
                    <td class="text-left">25</td>
                    <td class="text-right">$54.00</td>
                    <%if (i % 3 == 1) {%>
                    <td class="text-center"><span class="label label-danger m-r-20 ">Em Falta</span></td>
                    <%} else if (i % 4 == 1) {%>
                    <td class="text-center"><span class="label label-warning m-r-20 ">Estoque Baixo</span></td>
                    <%} else {%>
                    <td class="text-center"><span class="label label-primary m-r-20 ">Em Estoque</span></td>
                    <%}%>
                    <td class="text-center"><a class="btn btn-primary" href="bookRegistration.jsp"><i class="fa fa-edit"></i> </a></td>
                </tr>
                <%}%>
                </tbody>
            </table>

        </div>
        <div class="category-page-wrapper">
            <div class="result-inner">Exibindo 1 a 15 de 245 (17 P&aacute;ginas)</div>
            <div class="pagination-inner">
                <ul class="pagination">
                    <li class="active"><span>1</span></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">...</a></li>
                    <li><a href="#">17</a></li>
                    <li><a href="#">&gt;</a></li>
                    <li><a href="#">&gt;|</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<footer>
    <div class="footer-bottom">
        <div id="bottom-footer">
            <div class="copyright"> Copyright - <a class="yourstore" href="http://www.lionode.com/"> Created by
                Lionode
                &copy; 2017 </a></div>
        </div>
    </div>
    <a id="scrollup">Scroll</a>
</footer>
</body>
</html>