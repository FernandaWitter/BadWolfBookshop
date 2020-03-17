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
    <%--    <link href="resources/image/favicon.png" rel="icon" type="image/png" >--%>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/resources/css/googleFonts.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/stylesheet.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.css" type="text/css" rel="stylesheet" media="screen"/>
    <link href="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.transitions.css" type="text/css" rel="stylesheet" media="screen"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/template_js/jstree.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/template_js/template.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/global.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/javascript/owl-carousel/owl.carousel.min.js"></script>
</head>
<body class="col-2 left-col">
<div class="preloader loader" style="display: block;"><img src="${pageContext.request.contextPath}/resources/image/loader-circle.gif" alt="#"/></div>
<header>
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="top-left pull-left">
                        <div class="wel-come-msg" style="font-size: 24px"><a href="#"><img
                                src="${pageContext.request.contextPath}/resources/image/logo_black_small.jpg" title="Bad Wolf Bookshop"
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
                        <li><a href="list">Listagem de Produtos</a></li>
                        <li><a href="new">Cadastrar Produto</a></li>
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
        <div class="center-block m-l-40 m-r-40" id="content">
            <%
                Result result = (Result) request.getAttribute("resultado");
                Book book = new Book();
                if(result != null){
                    if(result.hasMsg("error")){
                        String [] msgs = result.getMsg("error").split("\n");
                        out.print("<p>");
                        for(String s : msgs){
                            out.print(s+"<br/>");
                        }
                        out.print("</p>");
                    }
                }
                ArrayList<DomainObject> books = result.getObject(Book.class.getSimpleName());
                if(books != null && books.size() > 0)
                    book = (Book)books.get(0);

                String operation;
                if(null == request.getAttribute("operation"))
                    operation = request.getParameter("operation");
                else
                    operation = request.getAttribute("operation").toString();
            %>
            <h2 class="text-center"><%if(operation.equals("create"))
                out.print("Cadastrar Produto");
            else
                out.print("Editar Produto");
            %></h2>
            <form class="form-horizontal" enctype="multipart/form-data" method="post" action="productList.jsp">
                <p>* Campos obrigat&oacute;rios</p>
                <fieldset>
                    <legend>Produto</legend>
                    <div class="form-group required">
                        <label for="bookTitle" class="col-sm-2 control-label">T&iacute;tulo*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookTitle"
                                   placeholder="A informa&ccedil;&atilde;o importante da capa que n&atilde;o &eacute; o autor"
                                   value="<% if(book.getTitle() != null) out.print(book.getTitle()); %>" name="bookTitle">
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
                                       if(!authors.equals("")) authors += "; ";
                                       authors += a.getName();
                                   }
                                   if(authors.length() > 2) authors = authors.substring(0, authors.length()-2);
                                   out.print(authors);
                                   }%>" name="bookAuthor">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookPublisher" class="col-sm-2 control-label">Editora*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookPublisher"
                                   placeholder="Quem comprou os direitos autorais e vai ganhar dinheiro" value="<%if (book.getPublisher() != null && book.getPublisher().getName() != null) out.print(book.getPublisher().getName())%>"
                                   name="confirm">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookYear" class="col-sm-2 control-label">Ano*</label>
                        <div class="col-sm-2">
                            <input type="numeric" class="form-control" id="bookYear"
                                   placeholder="ex. 1995" value="<%if(book.getPubYear() != null) out.print(book.getPubYear());%>" name="bookYear">
                        </div>
                        <label for="bookEdition" class="col-sm-1 control-label">Edi&ccedil;&atilde;o*</label>
                        <div class="col-sm-3">
                            <input type="numeric" class="form-control" id="bookEdition"
                                   placeholder="ex. 1" value="<%if(book.getPubEdition() != null) out.print(book.getPubEdition());%>" name="bookEdition">
                        </div>
                        <label for="bookLanguage" class="col-sm-1 control-label">Idioma*</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="bookLanguage"
                                   placeholder="ex. Ingl&ecirc;s" value="<%if(book.getLanguage() != null) out.print(book.getLanguage());%>" name="bookLanguage">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookISBN" class="col-sm-2 control-label">ISBN*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookISBN"
                                   placeholder="ex. 978-1338306125" value="<%if(book.getIsbn() != null) out.print(book.getIsbn());%>" name="bookISBN">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookGenres" class="col-sm-2 control-label">Categorias*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookGenres"
                                   placeholder="Separadas por ponto-e-v&iacute;rgula: romance; aventura; fantasia" value="<% if(book.getAuthors() != null && book.getAuthors().size() > 0){
                                       String categories = "";
                                   for (Category c : book.getCategories()){
                                       if(!categories.equals("")) categories += "; ";
                                       categories += c.getName();
                                   }
                                   if(categories.length() > 2) categories = categories.substring(0, categories.length()-2);
                                   out.print(categories);
                                   }%>" name="bookGenres">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookSummary" class="col-sm-2 control-label">Sinopse*</label>
                        <div class="col-sm-10">
                            <textarea rows="10" id="bookSummary" class="form-control" name="bookSummary"></textarea>
                        </div>
                    </div>
                </fieldset>
                <fieldset id="images" class="m-t-10">
                    <legend>Imagens</legend>
                    <div class="form-group">
                    <%if(book.getImages() != null && book.getImages().size() > 0){
                        for(Image i : book.getImages()){
                            out.print("<label for=\"bookImage\" class=\"col-sm-2 control-label\">Imagem do livro</label>");
                            out.print("<div class=\"col-sm-10\">");
                            out.print("<input type=\"text\" id=\"bookImage\" class=\"form-control\" name=\"bookImage[]\" value=\"" + i.getPath() + "\">");
                            out.print("</div>");
                            out.print("</div>");
                        }
                    }%>
                        <label for="bookImage" class="col-sm-2 control-label">Capa</label>
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
                            <input type="text" class="form-control" id="bookHeight"
                                   placeholder="ex. 21,6" value="<%if(book.getHeight() != null) out.print(book.getHeight());%>" name="bookHeight">
                        </div>
                        <label for="bookWidth" class="col-sm-2 control-label">Largura (cm)*</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="bookWidth"
                                   placeholder="ex. 14,6" value="<%if(book.getWidth() != null) out.print(book.getWidth());%>" name="bookWidth">
                        </div>
                        <label for="bookDepth" class="col-sm-2 control-label">Profundidade (cm)*</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="bookDepth"
                                   placeholder="ex. 2,5" value="<%if(book.getDepth() != null) out.print(book.getDepth());%>" name="bookDepth">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="bookWeight" class="col-sm-2 control-label">Peso (g)*</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="bookWeight"
                                   placeholder="ex. 340" value="<%if(book.getWeight() != null) out.print(book.getWeight());%>" name="bookWeight">
                        </div>
                        <label for="bookPages" class="col-sm-2 control-label">P&aacute;ginas*</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="bookPages"
                                   placeholder="ex. 248" value="<%if(book.getPages() != null) out.print(book.getPages());%>" name="bookPages">
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Comercial</legend>
                    <p>Se nenhum pre&ccedil;o novo for informado,
                    o sistema considerar&aacute; o valor existente como correto.</p>
                    <div class="form-group required">
                        <label for="bookPrice" class="col-sm-2 control-label">Pre&ccedil;o Atual</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-right p-r-10" id="bookPrice"
                                   value="<%if(book.getPrice() != null) out.print(book.getPrice());
                                   else out.print(0.00);%>" name="bookPrice" disabled>
                        </div>
                        <label for="bookNewPrice" class="col-sm-2 control-label">Novo Pre&ccedil;o</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="bookNewPrice"
                                   placeholder="ex. 24.48" value="" name="bookNewPrice">
                        </div>
                    </div>
                    <p>O valor informado ser&aacute; acrescido &agrave;s unidades existentes em estoque.</p>
                    <div class="form-group required">
                        <label for="booksInStock" class="col-sm-2 control-label">Estoque Atual</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-right p-r-10" id="booksInStock"
                                   value="<%if(book.getInStock() != null) out.print(book.getInStock());
                                   else out.print(0);%>" name="booksInStock" disabled>
                        </div>
                        <label for="bookNewUnits" class="col-sm-2 control-label">Novas Unidades</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="bookNewUnits"
                                   placeholder="ex. 19" value="" name="bookNewUnits">
                        </div>
                    </div>
                </fieldset>
                <div class="m-t-40"></div>
                <div class="buttons">
                    <div class="pull-right">
                        <%
                            if("create".equals(operation)){
                                out.print("<button class=\"btn btn-primary\" value=\"create\" name=\"operation\" type=\"submit\">Cadastrar</button>");
                            } else {
                                out.print("<button class=\"btn btn-primary\" value=\"update\" name=\"operation\" type=\"submit\">Salvar</button>");
                            }
                        %>
<%--                        <input type="submit" class="btn btn-primary" value="Salvar">--%>
<%--                        <a class="btn btn-primary" href="productList.jsp">Salvar</a>--%>
                    </div>
                </div>
            </form>
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

<script src="resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        var addButton = $('#addImage');
        var wrapper = $('#bookExtraImages');
        var fieldHTML = '<div class="form-group">\n' +
                '                        <label for="bookImage" class="col-sm-2 control-label">Imagem Extra</label>\n' +
                '                        <div class="col-sm-10">\n' +
                '                            <input type="text" id="bookImage" class="form-control" name="bookImage[]">\n' +
                '                        </div>\n' +
                '                    </div>';
        $(addButton).click(function(){
            $(wrapper).append(fieldHTML);
        })
    });
</script>
</body>
</html>