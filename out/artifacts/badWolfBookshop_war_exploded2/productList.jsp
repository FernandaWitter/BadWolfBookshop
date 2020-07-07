<%@ page import="domain.Result" %>
<%@ page import="domain.Book" %>
<%@ page import="domain.DomainObject" %>
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
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.css" type="text/css"
          rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.transitions.css"
          type="text/css" rel="stylesheet" media="screen"/>
    <link href="https://cdn.datatables.net/1.10.18/css/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body class="col-2 left-col">
<div class="preloader loader" style="display: block;"><img
        src="${pageContext.request.contextPath}/resources/image/loader-circle.gif" alt="#"/></div>
<header>
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="top-left pull-left">
                        <div class="wel-come-msg" style="font-size: 24px">
                            <a href="${pageContext.request.contextPath}/index.jsp">
                                <img src="${pageContext.request.contextPath}/resources/image/logo_black_small.jpg"
                                     title="Bad Wolf Bookshop" alt="Bad Wolf Bookshop Logo" class="img-responsive"/>
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
                <li><a href="${pageContext.request.contextPath}/dashboard.jsp" class="active parent">Dashboard</a>
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
<%
    Result result = (Result) request.getAttribute("result");
%>
<div class="container">
    <div class="container" style="height:40px;"></div>
    <div class="center-block" id="content">
        <%
            if (request.getSession().getAttribute("success") != null) {
                out.print(request.getSession().getAttribute("success") + "<br/>");
                request.getSession().removeAttribute("success");
            }
        %>
        <h2 class="text-center m-b-20">Listagem de Produtos</h2>
    </div>
    <div class="table-responsive">
        <table class="table table-bordered" id="dataTable">
            <thead>
            <tr>
                <td class="text-center">Produto</td>
                <td class="text-left">Nome</td>
                <td class="text-left">Estoque</td>
                <td class="text-right">Valor Unit&aacute;rio</td>
                <td class="text-center">Status</td>
                <td class="text-center">Editar</td>
                <td class="text-center">Excluir</td>
            </tr>
            </thead>
            <tbody>
            <%
                if (result.getObject(Book.class.getSimpleName()) != null) {
                    for (DomainObject d : result.getObject(Book.class.getSimpleName())) {
                        Book b = (Book) d;
            %>
            <tr>
                <form action="${pageContext.request.contextPath}/admin/edit" method="post">
                    <td class="text-center">
                        <img class="img-thumbnail" title="Produto" style="height: 50px;" alt="Imagem do Produto"
                             src="<%if(b.getImages() != null && b.getImages().size() > 0) out.print(b.getImages().get(0).getPath());%>">
                    </td>
                    <td class="text-left"><%out.print(b.getTitle());%></td>
                    <td class="text-left"><%out.print(b.getInStock());%></td>
                    <td class="text-right">$<%out.print(String.format("%.2f", b.getPrice()));%></td>
                    <%if (b.getInStock() == 0) {%>
                    <td class="text-center"><span class="label label-danger m-r-20 ">Em Falta</span></td>
                    <%} else if (b.getInStock() < 10) {%>
                    <td class="text-center"><span class="label label-warning m-r-20 ">Estoque Baixo</span></td>
                    <%} else {%>
                    <td class="text-center"><span class="label label-primary m-r-20 ">Em Estoque</span></td>
                    <%}%>
                    <td class="text-center">
                        <button type="submit" name="operation" value="update" class="fa fa-edit"></button>
                        <input type="hidden" name="bookId" value="<%out.print(b.getId());%>">
                    </td>
                    <td class="text-center">
                        <button type="submit" class="fa fa-trash" formaction="delete"></button>
                        <input type="hidden" name="bookId" value="<%out.print(b.getId());%>">
                    </td>
                </form>
            </tr>
            <%}%>
            </tbody>
        </table>
    </div>
    <%}%>
</div>
<footer>
    <div class="footer-bottom">
        <div id="bottom-footer">
            <div class="copyright"> Copyright - <a class="yourstore" href="http://www.lionode.com/"> Created by
                Lionode &copy; 2017 </a>
            </div>
        </div>
    </div>
</footer>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/javascript/jquery-2.1.1.min.js"></script>
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
<script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.18/js/dataTables.bootstrap4.min.js"></script>
<script>
    $(document).ready(function () {
        $('#dataTable').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json"
            }
        });
    });
</script>
</body>
</html>