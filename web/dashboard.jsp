<%@ page import="domain.Result" %>
<%@ page import="domain.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="domain.DomainObject" %>
<%@ page import="dto.BookChartDTO" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="dto.ReturnChartDTO" %>
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
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <%
        Result result;
        if (request.getAttribute("result") != null)
            result = (Result) request.getAttribute("result");
        else
            result = new Result();
        String data = "[\'Data\'";
        BookChartDTO dto = null;
        if (result.hasObject(BookChartDTO.class.getSimpleName())) {
            dto = (BookChartDTO) result.getObject(BookChartDTO.class.getSimpleName()).get(0);
            if (dto.getFoundCategories().size() > 0) {
                for (String cat : dto.getFoundCategories())
                    data += ", \'" + cat + "\'";
            }
            data += "]";
            if (dto.getResults().size() > 0) {
                int i = 0;
                for (Map.Entry<String, HashMap<String, Integer>> entry : dto.getResults().entrySet()) {
                    data += ",[new Date(\'" + entry.getKey() + "\')";
                    i++;
                    for (String cat : dto.getFoundCategories())
                        data += ", " + entry.getValue().get(cat);
                    data += "]";
                }
            } else {
                data = "['',''],['',0]";
            }
        }
        String donutData = "[\'Status\', \'Pedidos\']";
        if (result.hasObject(ReturnChartDTO.class.getSimpleName())) {
            ReturnChartDTO chartData = (ReturnChartDTO) result.getObject(ReturnChartDTO.class.getSimpleName()).get(0);
            for (Map.Entry<String, Integer> entry : chartData.getBooksByStatus().entrySet()) {
                donutData += ",[\'" + entry.getKey() + "\', " + entry.getValue() + "]";
            }
        }
    %>
    <script type="text/javascript">
        google.charts.load('current', {'packages': ['corechart']});
        google.charts.setOnLoadCallback(drawSalesChart);
        google.charts.setOnLoadCallback(drawStatusChart);

        function drawSalesChart() {
            var data = google.visualization.arrayToDataTable([<%out.print(data);%>]);

            var options = {
                curveType: 'function',
                chartArea: {'width': '90%', 'height': '80%'},
                legend: {position: 'bottom'},
                hAxis: {format: 'dd/MM/yy'},
                vAxis: {
                    gridlines: {color: 'none'},
                    viewWindow: {min: 0},
                    format:'#',
                    viewWindow: {min:0}
                }
            };

            var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
            chart.draw(data, options);
        }

        function drawStatusChart() {
            var data = google.visualization.arrayToDataTable([<%out.print(donutData);%>]);

            var options = {
                chartArea: {'width': '90%', 'height': '80%'},
                legend: {position: 'bottom', alignment: 'center'},
                pieHole: 0.4
            };

            var chart = new google.visualization.PieChart(document.getElementById('donut_chart'));
            chart.draw(data, options);
        }

    </script>
</head>
<body class="col-2 left-col">
<div class="preloader loader" style="display: block;">
    <img src="resources/image/loader-circle.gif" alt="#"/>
</div>
<header>
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="top-left pull-left">
                        <div class="wel-come-msg" style="font-size: 24px">
                            <a href="index.jsp">
                                <img src="resources/image/logo_black_small.jpg" title="Bad Wolf Bookshop"
                                     alt="Bad Wolf Bookshop Logo" class="img-responsive"/>
                            </a>
                        </div>
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
                                        <li><a href="${pageContext.request.contextPath}/index.jsp">Sair</a></li>
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
                <li>
                    <a href="${pageContext.request.contextPath}/dash" class="active parent">Dashboard</a>
                </li>
                <li><a href="#" class="active parent">Produtos</a>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/admin/list">Listagem de Produtos</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/new">Cadastrar Produto</a></li>
                    </ul>
                </li>
                <li><a href="#" class="active parent">Pedidos</a>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/orderList">Listagem de Pedidos</a></li>
                        <li><a href="${pageContext.request.contextPath}/orderList">Pedidos em Aberto</a></li>
                        <li><a href="${pageContext.request.contextPath}/orderList">Pedidos de Troca e Devolu&ccedil;&atilde;o</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row m-t-40">
        <div id="column-left" class="col-sm-3 hidden-xs column-left">
            <div class="panel-heading clearfix">
                <h4 class="panel-title">Pedidos por Status</h4>
            </div>
            <div class="m-t-30">
                <div id="donut_chart" class="w-100 h-100" style="height: 350px;"></div>
            </div>
        </div>
        <div class="col-sm-9">
            <div class="row p-b-40 m-b-40">
                <div class="col-md-12">
                    <div class="panel panel-white">
                        <div class="panel-heading clearfix">
                            <h4 class="panel-title">Vendas por Categoria</h4>
                        </div>
                        <div class="center-block m-l-40 m-r-40 m-t-20" id="content">
                            <fieldset>
                                <div class="row">
                                    <form class="form-group" method="post" action="getChart">
                                        <label for="fromDate" class="col-sm-2">Per&iacute;odo: </label>
                                        <input type="date" class="col-sm-3" id="fromDate" name="fromDate"
                                            <%
                                                if(dto != null)
                                                    out.print("value=\"" + dto.getStartDate() + "\"");
                                            %>>
                                        <label for="toDate" class="col-sm-2">a </label>
                                        <input type="date" class="col-sm-3" id="toDate" name="toDate"
                                            <%
                                                if(dto != null)
                                                    out.print("value=\"" + dto.getEndDate() + "\"");
                                            %>>
                                        <button class="btn btn-primary col-sm-2">Filtrar</button>
                                    </form>
                                </div>
                            </fieldset>
                        </div>
                        <div id="curve_chart" class="w-100 h-100" style="height: 350px;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row m-t-40 p-t-40">
        <div class="col-md-12">
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
                            <%
                                if (result.hasObject(Order.class.getSimpleName())) {
                                    List<DomainObject> orders = result.getObject(Order.class.getSimpleName());
                                    for (int i = 0; i < 5; i++) {
                                        Order o = (Order) orders.get(i);
                                        out.print("<tr>");
                                        out.print("<th scope=\"row\">" + o.getId() + "</th>");
                                        out.print("<td>" + o.getUser().getName() + "</td>");
                                        out.print("<td>" + o.getCreation() + "</td>");
                                        String label = "";
                                        switch (o.getStatus().getCode()) {
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
                                        }
                                        out.print("<td><span class=\"label " + label + "\">" + o.getStatus().getTitle() + "</span></td>");
                                        out.print("<td class=\"text-right\">$" + String.format("%.2f", o.getOrderTotal()) + "</td>");
                                        out.print("</tr>");
                                    }
                                }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<footer>
    <div class="footer-bottom">
        <div id="bottom-footer">
            <div class="copyright"> Copyright - <a class="yourstore" href="http://www.lionode.com/"> Created by
                Lionode &copy; 2017 </a></div>
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
</body>
</html>