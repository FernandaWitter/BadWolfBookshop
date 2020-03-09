<!DOCTYPE html>
<html lang="en">
<head>
    <title>YourTurn</title>
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
                <li><a href="admin-dash.html" class="active parent">Dashboard</a>
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
    <div class="row m-t-40">
        <div id="column-left" class="col-sm-3 hidden-xs column-left">
            <div class="Categories left-sidebar-widget" style="position: absolute">
                <div class="columnblock-title">Pedido <strong>#123ABC456</strong></div>
                <p><strong>Cliente:</strong> Cliente Principal</p>
                <p><strong>Data do Pedido:</strong> 15/02/2020</p>
                <p><strong>Valor:</strong> $254.00</p>
            </div>
        </div>
        <div class="col-sm-9" id="content">
            <div id="accordion" class="panel-group">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title"><a class="accordion-toggle collapsed" data-parent="#accordion"
                                                   data-toggle="collapse" href="#collapse-order-1"
                                                   aria-expanded="false"><strong>Item:</strong> Produto 1 <i
                                class="fa fa-caret-down"></i></a><span class="label label-primary m-r-20 pull-right">Em Tr&acirc;nsito</span></h4>
                    </div>
                    <div id="collapse-order-1" role="heading" class="panel-collapse collapse"
                         aria-expanded="false" style="height: 0px;">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-2">
                                    <a href="bookDetail.jsp"><img class="img-thumbnail" title="Produto" alt="Imagem do Produto" src="resources/image/book-front-50x64.jpg"></a>
                                </div>
                                <div class="col-sm-5">
                                    <a href="bookDetail.jsp">T&iacute;tulo do Livro</a>
                                </div>
                                <div class="col-sm-1">Qtde: 1</div>
                                <div class="col-sm-1"><a>$24.00</a></div>
                                <div class="col-sm-3 pull-right"><a class="btn label pull-right" href="orderDetail.jsp">Entregue</a> </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title"><a class="accordion-toggle collapsed" data-parent="#accordion"
                                                   data-toggle="collapse" href="#collapse-order-2"
                                                   aria-expanded="false"><strong>Item:</strong> Produto 2 <i
                                class="fa fa-caret-down"></i></a><span class="label label-success m-r-20 pull-right">Entregue</span></h4>
                    </div>
                    <div id="collapse-order-2" role="heading" class="panel-collapse collapse"
                         aria-expanded="false" style="height: 0px;">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-2">
                                    <a href="bookDetail.jsp"><img class="img-thumbnail" title="Produto" alt="Imagem do Produto" src="resources/image/book-front-50x64.jpg"></a>
                                </div>
                                <div class="col-sm-5">
                                    <a href="bookDetail.jsp">T&iacute;tulo do Livro</a>
                                </div>
                                <div class="col-sm-1">Qtde: 1</div>
                                <div class="col-sm-1"><a>$24.00</a></div>
<%--                                <div class="col-sm-3 pull-right"><a class="btn label pull-right" href="returnItem.jsp">Devolver/Trocar</a> </div>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title"><a class="accordion-toggle collapsed" data-parent="#accordion"
                                                   data-toggle="collapse" href="#collapse-order-3"
                                                   aria-expanded="false"><strong>Item:</strong> Produto 3 <i
                                class="fa fa-caret-down"></i></a><span class="label label-danger m-r-20 pull-right">Troca/Devolu&ccedil;&atilde;o</span></h4>
                    </div>
                    <div id="collapse-order-3" role="heading" class="panel-collapse collapse"
                         aria-expanded="false" style="height: 0px;">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-2">
                                    <a href="bookDetail.jsp"><img class="img-thumbnail" title="Produto" alt="Imagem do Produto" src="resources/image/book-front-50x64.jpg"></a>
                                </div>
                                <div class="col-sm-5">
                                    <p><a href="bookDetail.jsp">T&iacute;tulo do Livro</a></p>
                                    <p><strong>Motivo da Troca:</strong></p>
                                    <p>Motivo da Troca Informado na Solicita&ccedil;&atilde;o</p>
                                </div>
                                <div class="col-sm-1">Qtde: 1</div>
                                <div class="col-sm-1"><a>$24.00</a></div>
                                <div class="col-sm-3 pull-right"><a class="btn label pull-right" href="orderDetail.jsp">Aceitar</a> </div>
                                <div class="col-sm-offset-8"><a class="btn label pull-right m-t-10 m-r-10" href="orderDetail.jsp">Rejeitar</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<footer>
    <div class="footer-bottom">
        <div id="bottom-footer">
            <div class="copyright"> Copyright - <a class="yourstore" href="http://www.lionode.com/"> Created by Lionode
                &copy; 2017 </a></div>
        </div>
    </div>
    <a id="scrollup">Scroll</a>
</footer>
</body>
</html>