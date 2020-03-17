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
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Year', 'Nacionais', 'Importados', 'Didaticos'],
                ['2004',  1000,      400,   100],
                ['2005',  1170,      460,   95],
                ['2006',  660,       1120,  115],
                ['2007',  1030,      540,   127]
            ]);

            var options = {
                title: 'Vendas por Tipo',
                curveType: 'function',
                legend: { position: 'bottom' }
            };

            var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

            chart.draw(data, options);
        }
    </script>
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
                        <li><a href="books/list">Listagem de Produtos</a></li>
                        <li><a href="books/new">Cadastrar Produto</a></li>
                    </ul>
                </li>
                <li><a href="#" class="active parent">Pedidos</a>
                    <ul><form>
                        <li><a href="orderList.jsp">Listagem de Pedidos</a></li>
                        <li><a href="orderList.jsp">Pedidos em Aberto</a></li>
                        <li><a href="orderList.jsp">Pedidos de Troca e Devolu&ccedil;&atilde;o</a></li>
                    </ul>
                </li>

            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="page-inner">

        <div id="main-wrapper">

            <div class="row">
                <div class="col-lg-2"></div>
                <div class="col-lg-8 col-md-12">
                    <div class="panel panel-white">
                        <div class="panel-heading clearfix">
                            <h4 class="panel-title">An&aacute;lise de Vendas</h4>
                        </div>
<%--                        <div class="panel-body text-center">--%>
<%--                            <img class="img-thumbnail" alt="Gráfico de barras das vendas de produto" src="image/barChart.jpg" >--%>
<%--                        </div>--%>
                        <div class="center-block m-l-40 m-r-40 m-t-20" id="content">
                            <fieldset>
                                <div class="row">
                                    <label for="fromDate" class="col-sm-4">Per&iacute;odo: </label>
                                    <input type="date" class="col-sm-3" id="fromDate" name="fromDate">
                                    <label for="toDate" class="col-sm-2">a </label>
                                    <input type="date" class="col-sm-3" id="toDate" name="toDate">
                                </div>
                            </fieldset>
                        </div>
                        <div id="curve_chart" style="width: 900px; height: 500px"></div>
                    </div>
                </div>
            </div><!-- Row -->
            <div class="row">

                <div class="col-lg-2 "></div>
                <div class="col-lg-8 col-md-12">
                    <div class="panel panel-white">
                        <div class="panel-heading clearfix">
                            <h4 class="panel-title">Pedidos</h4>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive invoice-table">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <td class="text-left">Pedido</td>
                                        <td class="text-left">Cliente</td>
                                        <td class="text-left">Data</td>
                                        <td class="text-left">Status</td>
                                        <td class="text-right">Valor Total</td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <th scope="row">0567</th>
                                        <td>Kenny Highland</td>
                                        <td>05/02/2019</td>
                                        <td><span class="label label-success">Conclu&aacute;do</span></td>
                                        <td>$427</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">0186</th>
                                        <td>Darrell Price</td>
                                        <td>03/06/2019</td>
                                        <td><span class="label label-danger">Devolu&ccedil;&atilde;o</span></td>
                                        <td>$1714</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">0712</th>
                                        <td>Richard Lunsford</td>
                                        <td>05/05/2019</td>
                                        <td><span class="label label-warning">Pendente</span></td>
                                        <td>$685</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">0095</th>
                                        <td>Amy Walker</td>
                                        <td>18/12/2018</td>
                                        <td><span class="label label-danger">Devolu&ccedil;&atilde;o</span></td>
                                        <td>$9900</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">1054</th>
                                        <td>Kathy Olson</td>
                                        <td>21/07/2019</td>
                                        <td><span class="label label-primary">Em Tr&acirc;nsito</span></td>
                                        <td>$1250</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">0043</th>
                                        <td>Susan Mabry</td>
                                        <td>08/08/2019</td>
                                        <td><span class="label label-primary">Em Tr&acirc;nsito</span></td>
                                        <td>$399</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div id="chart1"><svg></svg></div>
                </div>
            </div><!-- Row -->

        </div><!-- Main Wrapper -->

    </div><!-- /Page Inner -->
</div>
<!--</div>-->

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