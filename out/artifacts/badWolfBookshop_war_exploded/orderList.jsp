<%@ page import="domain.Result" %>
<%@ page import="domain.Order" %>
<%@ page import="domain.DomainObject" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
    <link href="https://cdn.datatables.net/1.10.18/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.18/js/dataTables.bootstrap4.min.js"></script>
</head>
<body class="col-2 left-col">
<div class="preloader loader" style="display: block;"><img src="resources/image/loader-circle.gif" alt="#"/></div>
<header>
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="top-left pull-left">
                        <div class="wel-come-msg" style="font-size: 24px"><a href="index.jsp"><img
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

<%
    Result result;
    if(request.getAttribute("result") != null)
        result = (Result) request.getAttribute("result");
    else
        result = new Result();
%>
<div class="container">
    <div class="row">
        <div class="container" style="height:40px;"></div>
        <div class="center-block" id="content">
            <h2 class="text-center m-b-20">Listagem de Pedidos</h2>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable">
                <thead>
                <tr>
                    <td class="text-center">Pedido</td>
                    <td class="text-left">Cliente</td>
                    <td class="text-left">Data</td>
                    <td class="text-right">Valor Total</td>
                    <td class="text-center">Status</td>
                    <td class="text-center">Editar</td>
                </tr>
                </thead>
                <tbody>
                <%if(result.hasObject(Order.class.getSimpleName())) {
                    List<DomainObject> orders = result.getObject(Order.class.getSimpleName());
                    for (DomainObject d : orders) {
                        Order order = (Order) d;
                        out.print("<tr>");
                        out.print("<td class=\"text-center\"><strong>#" + order.getId() + "</strong></td>");
                        out.print("<td class=\"text-left\">" + order.getUser().getName() + "</td>");
                        out.print("<td class=\"text-left\">" + DateTimeFormatter.ofPattern("dd/MM/yyyy").format(order.getCreation()) + "</td>");
                        out.print("<td class=\"text-right\">$" + String.format("%.2f", order.getOrderTotal()) + "</td>");
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
                        out.print("<td class=\"text-center\"><span class=\"label " + label + " m-r-20 \">" + order.getStatus().getTitle() + "</span></td>");
                        out.print("<td class=\"text-center\">");
                        out.print("<form method=\"post\" action=\"editPurchase\">");
                        out.print("<button type=\"submit\" class=\"btn btn-primary\" id=\"editOrder" + order.getId() + "\"><i class=\"fa fa-edit\"></i> </button>");
                        out.print("<input type=\"hidden\" value=\"" + order.getId() + "\" name=\"orderId\">");
                        out.print("</form>");
                        out.print("</td>");
                        out.print("</tr>");
                    }
                }
                %>
                </tbody>
            </table>

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
<script>
    $(document).ready(function() {
        $('#dataTable').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json"
            }
        });
    });
</script>
</body>
</html>