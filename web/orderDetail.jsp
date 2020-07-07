<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="domain.*" %>
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
<body class="col-2 left-col">
<div class="preloader loader" style="display: block;"><img src="resources/image/loader-circle.gif" alt="#"/></div>
<header>
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="top-left pull-left">
                        <div class="wel-come-msg" style="font-size: 24px">
                            <a href="${pageContext.request.contextPath}/index.jsp">
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
                                        <span class="caret"></span></a>
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
                        <li><a href="${pageContext.request.contextPath}/admin/">Cadastrar Produto</a></li>
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
<%
    if (request.getSession().getAttribute("error") != null) {
        out.print("<div class=\"row m-t-40 text-center\">");
        out.print("<p style=\"color:red; font-weight: bold;\"><strong>");
        out.print(request.getSession().getAttribute("error") + "<br/>");
        out.print("</strong></p><br/>");
        out.print("</div>");
        request.getSession().removeAttribute("error");
    }
    Result result;
    Order order = new Order();
    if (request.getAttribute("result") != null)
        result = (Result) request.getAttribute("result");
    else
        result = new Result();

%>
<div class="container">
    <div class="row m-t-40">
        <form action="updateOrder" method="post">
            <%
                if (result.hasObject(Order.class.getSimpleName()))
                    order = (Order) result.getObject(Order.class.getSimpleName()).get(0);
            %>
            <div id="column-left" class="col-sm-3 hidden-xs column-left">
                <div class="Categories left-sidebar-widget" style="position: absolute">
                    <%
                        out.print("<div class=\"columnblock-title\">Pedido <strong>#" + order.getId() + "</strong></div>");
                        out.print("<p><strong>Cliente: </strong>" + order.getUser().getName() + "</p>");
                        out.print("<p><strong>Data do Pedido: </strong>" + DateTimeFormatter.ofPattern("dd/MM/yyyy").format(order.getCreation()) + "</p>");
                        out.print("<p><strong>Valor:</strong> $" + String.format("%.2f", order.getOrderTotal()) + "</p>");
                    %>
                </div>
            </div>
            <div class="col-sm-9" id="content">
                <p>Clique nos bot&otilde;es de cada item para atualizar seu status. Para salvar as modifica&ccedil;&otilde;es,
                    clique em "Salvar" ao final da listagem.</p>
                <div id="accordion" class="panel-group">
                    <%
                        if (order.getItems() != null && order.getItems().size() > 0) {
                            for (OrderItem item : order.getItems()) {
                    %>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="accordion-toggle collapsed" data-parent="#accordion"
                                   data-toggle="collapse" href="#collapse-order-<%out.print(item.getId());%>"
                                   aria-expanded="false">
                                    <strong>Item: </strong><%out.print(item.getBook().getTitle());%>
                                    <i class="fa fa-caret-down"></i>
                                </a>
                                <%
                                    String label = "";
                                    switch (item.getStatus().getCode()) {
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
                                <span class="label <%out.print(label);%> m-r-20 pull-right">
                                    <% out.print(item.getStatus().getTitle());%>
                                </span>
                            </h4>
                        </div>
                        <div id="collapse-order-<%out.print(item.getId());%>" role="heading"
                             class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-2">
                                        <img class="img-thumbnail" title="Produto" alt="Imagem do Produto" style="max-height: 50px;"
                                             src="<%out.print(item.getBook().getImages().get(0).getPath());%>">
                                    </div>
                                    <div class="col-sm-5">
                                        <p><%out.print(item.getBook().getTitle());%></p>
                                        <%
                                            Status newStatus = Status.getNext(item.getStatus());
                                            if (!newStatus.getTitle().equals(item.getStatus().getTitle())) {
                                                if (newStatus.equals(Status.EXCHANGING)) {
                                                    out.print("<p><strong>Motivo da Troca:</strong></p>");
                                                    out.print("<p>" + item.getReturnReason() + "</p>");
                                                } else if (newStatus.equals(Status.RETURNING)) {
                                                    out.print("<p><strong>Motivo da Devolução:</strong></p>");
                                                    out.print("<p>" + item.getReturnReason() + "</p>");
                                                }
                                            }
                                        %>
                                    </div>
                                    <div class="col-sm-1">Qtde: <%out.print(item.getQuantity());%></div>
                                    <div class="col-sm-1"><a>$<%
                                        out.print(String.format("%.2f", item.getBook().getPrice()));%></a></div>
                                    <%
                                        if (!newStatus.getTitle().equals(item.getStatus().getTitle())) {
                                            if (newStatus.equals(Status.EXCHANGE_AUTHORIZED) || newStatus.equals(Status.RETURN_AUTHORIZED) || newStatus.equals(Status.CANCELLED)) {
                                                out.print("<div class=\"col-sm-3 pull-right\"><button type=\"button\" class=\"btn btn-primary label pull-right\" id=\"accept" + item.getId() + "\" onclick=\"acceptRequest(" + item.getId() + ")\">Aceitar</button> </div>");
                                                out.print("<div class=\"col-sm-offset-8\"><button type=\"button\" class=\"btn btn-primary label pull-right m-t-10 m-r-10\" id=\"reject" + item.getId() + "\" onclick=\"rejectItem(" + item.getId() + ")\">Rejeitar</button></div>");
                                            } else if (item.getQuantity() <= item.getBook().getInStock())
                                                out.print("<div class=\"col-sm-3 pull-right\"><button type=\"button\" class=\"btn btn-primary label pull-right\" id=\"update" + item.getId() + "\" onclick=\"updateItem(" + item.getId() + ")\">" + newStatus.getTitle() + "</button></div>");
                                        } else {
                                            out.print("<div class=\"col-sm-3 pull-right\"><div type=\"button\" class=\"btn btn-warning label pull-right\"> Estoque insuficiente! </button></div>");
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }
                            out.print("<input type=\"hidden\" name=\"orderId\" value=\"" + order.getId() + "\"/>");
                        %>
                        <script>
                            function updateItem(id) {
                                document.getElementById('updatedItemsList').innerHTML = document.getElementById('updatedItemsList').innerHTML + '<input type="hidden" name="updatedItems[]" value="' + id + '"/>';
                                document.getElementById('update' + id).disabled = true;
                            }

                            function rejectItem(id) {
                                document.getElementById('rejectedItemsList').innerHTML = document.getElementById('rejectedItemsList').innerHTML + '<input type="hidden" name="rejectedItems[]" value="' + id + '"/>';
                                document.getElementById('accept' + id).disabled = true;
                                document.getElementById('reject' + id).disabled = true;
                            }

                            function acceptRequest(id) {
                                document.getElementById('updatedItemsList').innerHTML = document.getElementById('updatedItemsList').innerHTML + '<input type="hidden" name="updatedItems[]" value="' + id + '"/>';
                                document.getElementById('accept' + id).disabled = true;
                                document.getElementById('reject' + id).disabled = true;
                            }
                        </script>
                    </div>
                </div>
                <div id="updatedItemsList"></div>
                <div id="rejectedItemsList"></div>
                <div class="col-sm-offset-8">
                    <button type="submit" class="btn label pull-right m-t-10 m-r-10">Salvar</button>
                </div>
            </div>
        </form>
    </div>
</div>
</div>
<footer>
    <div class="footer-bottom">
        <div id="bottom-footer">
            <div class="copyright"> Copyright - <a class="yourstore" href="http://www.lionode.com/"> Created by Lionode &copy; 2017 </a></div>
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