<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.*" %>
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
</head>
<body class="col-2 left-col">
<div class="preloader loader" style="display: block;">
    <img src="${pageContext.request.contextPath}/resources/image/loader-circle.gif" alt="#"/>
</div>
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
    <div class="row">
        <div class="container" style="height:40px;"></div>
        <div class="center-block m-l-40 m-r-40" id="content">
            <%
                Result result = (Result) request.getAttribute("result");
                Book book = new Book();
                if (result != null) {
                    if (result.hasMsg("error")) {
                        String[] msgs = result.getMsg("error").split("\n");
                        out.print("<p style=\"color:red; font-weight: bold;\"><strong>");
                        for (String s : msgs) {
                            out.print(s + "<br/>");
                        }
                        out.print("</strong></p><br/>");
                    }

                    ArrayList<DomainObject> books = new ArrayList<>();
                    if (result.hasObject(Book.class.getSimpleName()))
                        books = result.getObject(Book.class.getSimpleName());
                    if (books != null && books.size() > 0)
                        book = (Book) books.get(0);
                }
                String operation;
                if (null == request.getAttribute("operation"))
                    operation = request.getParameter("operation");
                else
                    operation = request.getAttribute("operation").toString();
                if (operation == null)
                    operation = "new";
            %>
            <h2 class="text-center">
                <%
                    if ((operation.equals("new")) || (operation.equals("create")))
                        out.print("Cadastrar Produto");
                    else
                        out.print("Editar Produto");
                %>
            </h2>
            <form class="form-horizontal" method="post">
                <p>* Campos obrigat&oacute;rios</p>
                <fieldset>
                    <legend>Produto</legend>
                    <div class="form-group required">
                        <label for="bookTitle" class="col-sm-2 control-label">T&iacute;tulo*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookTitle" name="bookTitle"
                                   placeholder="A informa&ccedil;&atilde;o importante da capa que n&atilde;o &eacute; o autor"
                                   value="<% if(book.getTitle() != null) out.print(book.getTitle()); else out.print(""); %>">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookAuthor" class="col-sm-2 control-label">Autor*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookAuthor"
                                   placeholder="A outra informa&ccedil;&atilde;o importante da capa ou da lombada, separados por ponto-e-v&iacute;rgula"
                                   value="<% if(book.getAuthors() != null && book.getAuthors().size() > 0){
                                       String authors = "";
                                   for (Author a : book.getAuthors()){
                                       authors += a.getName();
                                       authors += "; ";
                                   }
                                   if(authors.length() > 2) authors = authors.substring(0, authors.length()-2);
                                   out.print(authors);
                                   } else out.print("");%>" name="bookAuthor">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookPublisher" class="col-sm-2 control-label">Editora*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookPublisher" name="bookPublisher"
                                   placeholder="Quem comprou os direitos autorais e vai ganhar dinheiro"
                                   value="<%if (book.getPublisher() != null && book.getPublisher().getName() != null) out.print(book.getPublisher().getName()); else out.print("");%>">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookYear" class="col-sm-2 control-label">Ano*</label>
                        <div class="col-sm-2">
                            <input type="number" class="form-control" id="bookYear" placeholder="ex. 1995" name="bookYear"
                                   value="<%if(book.getPubYear() != null) out.print(book.getPubYear()); else out.print("");%>">
                        </div>
                        <label for="bookEdition" class="col-sm-1 control-label">Edi&ccedil;&atilde;o*</label>
                        <div class="col-sm-3">
                            <input type="number" class="form-control" id="bookEdition" placeholder="ex. 1" name="bookEdition"
                                   value="<%if(book.getPubEdition() != null) out.print(book.getPubEdition()); else out.print("");%>">
                        </div>
                        <label for="bookLanguage" class="col-sm-1 control-label">Idioma*</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="bookLanguage" placeholder="ex. Ingl&ecirc;s" name="bookLanguage"
                                   value="<%if(book.getLanguage() != null) out.print(book.getLanguage()); else out.print("");%>">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookISBN" class="col-sm-2 control-label">ISBN*</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" id="bookISBN" placeholder="ex. 978-1338306125" name="bookISBN"
                                   value="<%if(book.getIsbn() != null) out.print(book.getIsbn()); else out.print("");%>">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookGenres" class="col-sm-2 control-label">Categorias*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookGenres"
                                   placeholder="Separadas por ponto-e-v&iacute;rgula: romance; aventura; fantasia"
                                   value="<% if(book.getCategories() != null && book.getCategories().size() > 0){
                                       String categories = "";
                                   for (Category c : book.getCategories()){
                                       categories += c.getName();
                                       categories += "; ";
                                   }
                                   if(categories.length() > 2) categories = categories.substring(0, categories.length()-2);
                                   out.print(categories);
                                   } else out.print("");%>" name="bookGenres">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookSummary" class="col-sm-2 control-label">Sinopse*</label>
                        <div class="col-sm-10">
                            <textarea rows="10" id="bookSummary" class="form-control" name="bookSummary">
                                <%
                                    if (book.getSummary() != null) out.print(book.getSummary());
                                    else out.print("");
                                %>
                            </textarea>
                        </div>
                    </div>
                </fieldset>
                <fieldset id="images" class="m-t-10">
                    <legend>Imagens</legend>
                    <%
                        if (book.getImages() != null && book.getImages().size() > 0) {
                            for (Image i : book.getImages()) {
                                out.print("<div class=\"form-group\">");
                                out.print("<label for=\"bookImage\" class=\"col-sm-2 control-label\">Caminho da Imagem:</label>");
                                out.print("<div class=\"col-sm-10\">");
                                out.print("<input type=\"text\" id=\"bookImage\" class=\"form-control\" name=\"bookImage[]\" value=\"" + i.getPath() + "\">");
                                out.print("</div>");
                                out.print("</div>");
                            }
                        }
                    %>
                    <div class="form-group">
                        <label for="bookImage" class="col-sm-2 control-label">Caminho da Imagem:</label>
                        <div class="col-sm-10">
                            <input type="text" id="bookImage" class="form-control" name="bookImage[]">
                        </div>
                    </div>
                    <div id="bookExtraImages"></div>
                    <a class="btn btn-primary pull-right " id="addImage">Adicionar Mais Imagens</a>
                </fieldset>
                <fieldset id="dimensions" class="m-t-20">
                    <legend>Dimens&otilde;es</legend>
                    <div class="form-group">
                        <label for="bookHeight" class="col-sm-2 control-label">Altura (cm)*</label>
                        <div class="col-sm-2">
                            <input type="number" class="form-control" id="bookHeight" step="0.01" placeholder="ex. 21,6"
                                   value="<%if(book.getHeight() != null) out.print(book.getHeight()); else out.print("");%>"
                                   name="bookHeight">
                        </div>
                        <label for="bookWidth" class="col-sm-2 control-label">Largura (cm)*</label>
                        <div class="col-sm-2">
                            <input type="number" class="form-control" id="bookWidth" step="0.01" placeholder="ex. 14,6"
                                   value="<%if(book.getWidth() != null) out.print(book.getWidth()); else out.print("");%>"
                                   name="bookWidth">
                        </div>
                        <label for="bookDepth" class="col-sm-2 control-label">Profundidade (cm)*</label>
                        <div class="col-sm-2">
                            <input type="number" class="form-control" id="bookDepth" step="0.01" placeholder="ex. 2,5"
                                   value="<%if(book.getDepth() != null) out.print(book.getDepth()); else out.print("");%>"
                                   name="bookDepth">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookWeight" class="col-sm-2 control-label">Peso (g)*</label>
                        <div class="col-sm-2">
                            <input type="number" class="form-control" id="bookWeight" step="0.01"
                                   placeholder="ex. 340"
                                   value="<%if(book.getWeight() != null) out.print(book.getWeight()); else out.print("");%>"
                                   name="bookWeight">
                        </div>
                        <label for="bookPages" class="col-sm-2 control-label">P&aacute;ginas*</label>
                        <div class="col-sm-2">
                            <input type="number" class="form-control" id="bookPages" placeholder="ex. 248"
                                   value="<%if(book.getPages() != null) out.print(book.getPages()); else out.print("");%>"
                                   name="bookPages">
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Comercial</legend>
                    <p>Se nenhum pre&ccedil;o novo for informado, o sistema considerar&aacute; o valor existente como correto.</p>
                    <div class="form-group required">
                        <label for="bookPrice" class="col-sm-2 control-label">Pre&ccedil;o Atual</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-right p-r-10" id="bookPrice"
                                   value="<%if(book.getPrice() != null) out.print(book.getPrice());
                                   else out.print(0.00);%>" disabled>
                            <input type="hidden" name="bookPrice" value="<%if(book.getPrice() != null) out.print(book.getPrice());
                                   else out.print(0.00);%>">
                        </div>
                        <label for="bookNewPrice" class="col-sm-2 control-label">Novo Pre&ccedil;o</label>
                        <div class="col-sm-2">
                            <input type="number" class="form-control" id="bookNewPrice" name="bookNewPrice" step="0.01"
                                   placeholder="ex. 24.48" value="">
                        </div>
                    </div>
                    <p>O valor informado ser&aacute; acrescido &agrave;s unidades existentes em estoque.</p>
                    <div class="form-group required">
                        <label for="booksInStock" class="col-sm-2 control-label">Estoque Atual</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-right p-r-10" id="booksInStock"
                                   value="<%if(book.getInStock() != null) out.print(book.getInStock());
                                   else out.print(0);%>" disabled>
                            <input type="hidden" name="booksInStock" value="<%if(book.getInStock() != null) out.print(book.getInStock());
                                   else out.print(0);%>">
                        </div>
                        <label for="bookNewUnits" class="col-sm-2 control-label">Novas Unidades</label>
                        <div class="col-sm-2">
                            <input type="number" class="form-control" id="bookNewUnits" name="bookNewUnits"
                                   placeholder="ex. 19" value="">
                        </div>
                    </div>
                </fieldset>
                <div class="m-t-40"></div>
                <div class="buttons">
                    <div class="pull-right">
                        <%
                            if ("new".equals(operation) || "create".equals(operation)) {
                                out.print("<input class=\"btn btn-primary\" value=\"Cadastrar\" name=\"operation\" type=\"submit\" formaction=\"create\"/>");
                            } else {
                                out.print("<button class=\"btn btn-primary\" value=\"update\" name=\"operation\" type=\"submit\" formaction=\"update\">Salvar</button>");
                                out.print("<input type=\"hidden\" name=\"bookId\" value=\"" + book.getId() + "\">");
                            }
                        %>
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
<script src="resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        var addButton = $('#addImage');
        var wrapper = $('#bookExtraImages');
        var fieldHTML = '<div class="form-group">\n' +
            '                        <label for="bookImage" class="col-sm-2 control-label">Caminho da Imagem:</label>\n' +
            '                        <div class="col-sm-10">\n' +
            '                            <input type="text" id="bookImage" class="form-control" name="bookImage[]">\n' +
            '                        </div>\n' +
            '                    </div>';
        $(addButton).click(function () {
            $(wrapper).append(fieldHTML);
        })
    });
</script>
</body>
</html>