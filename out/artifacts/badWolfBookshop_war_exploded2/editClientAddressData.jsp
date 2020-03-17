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
                                        <li><a href="registration.jsp">Cadastrar</a></li>
                                        <li><a href="login.jsp">Entrar</a></li>
                                        <li><a href="orderHistory.jsp">Hist&oacute;rico de Compras</a></li>
                                        <li><a href="vouchers.jsp">Cupons Dispon&iacute;veis</a> </li>
                                        <li><a href="editClientPersonalData.jsp">Configura&ccedil;&otilde;es</a></li>
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
                <div id="logo"><a href="index.jsp"><img src="resources/image/logo.jpg" title="E-Commerce"
                                                        alt="E-Commerce" class="img-responsive"/></a></div>
            </div>
            <div class="col-sm-9 col-xs-9 header-right">
                <div id="search" class="input-group">
                    <label hidden for="searchbox">Caixa de busca</label>
                    <input type="text" name="search" id="searchbox" value="" class="form-control input-lg"/>
                    <span class="input-group-btn">
          <button type="button" class="btn btn-default btn-lg"><span>Buscar</span></button>
          </span></div>
                <div id="cart" class="btn-group btn-block">
                    <a type="button" class="btn btn-inverse btn-block btn-lg cart-dropdown-button" href="cart.jsp"><span
                            id="cart-total"><i class="fa fa-shopping-cart" style="color: #189b79;"></i>
          <span>Carrinho</span><br>
          0 item(s) - $0.00</span></a>
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
<%--    <h1>Register Account</h1>--%>
<%--    <ul>--%>
<%--        <li><a href="index.html">Home</a></li>--%>
<%--        <li><a href="#">Account</a></li>--%>
<%--        <li><a href="register.html">Register</a></li>--%>
<%--    </ul>--%>
<%--</div>--%>
<div class="container">
    <div class="row">
        <div class="col-sm-3 hidden-xs column-left m-t-40" id="column-left">
            <div class="Categories left-sidebar-widget">
                <div class="columnblock-title">Dados do Usu&aacute;rio</div>
                <div class="category_block">
                    <ul class="box-category">
                        <li><a href="editClientPersonalData.jsp">Dados Pessoais</a></li>
                        <li><a href="#">Endere&ccedil;os</a></li>
                        <li><a href="editClientBillingData.jsp">Formas de Pagamento</a></li>
                        <li><a href="forgetPassword.jsp">Alterar Senha</a></li>
                        <li><a href="removeAccount.jsp">Excluir Conta</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="container" style="height:40px;"></div>
        <div class="center-block m-l-40 m-r-40" id="content">
            <h2 class="text-center">Endere&ccedil;os</h2>
            <form class="form-horizontal" enctype="multipart/form-data" method="post" action="index.jsp">
                <p>&Eacute; necess&aacute;rio cadastrar pelo menos um endere&ccedil;o para entrega e cobran&ccedil;a. Se
                    desejar, insira endere&ccedil;os adicionais, e poder&aacute; selecion&aacute;-los ao concluir a
                    compra.</p>
                <p>* Campos obrigat&oacute;rios</p>
                <fieldset id="address">
                    <legend>Principal
                        <button class="btn btn-danger pull-right" style="height:30px;"><i class="fa fa-remove m-b-20"></i> </button>
                    </legend>
                    <div class="form-group required">
                        <label for="addressPlace0" class="col-sm-2 control-label">Logradouro*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="addressPlace0"
                                   placeholder="ex. Rua, Avenida, Travessa..." value="Rua Principal" name="addressPlace0">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="addressNumber0" class="col-sm-2 control-label">N&uacute;mero*</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="addressNumber0" placeholder="ex. 51" value="13"
                                   name="addressNumber0">
                        </div>
                        <label for="addressNeighborhood0" class="col-sm-2 control-label">Bairro</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="addressNeighborhood0" placeholder="ex. Centro"
                                   value="Centro" name="addressNeighborhood0">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="addressZipCode0" class="col-sm-2 control-label">CEP*</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="addressZipCode0" placeholder="ex. 99999-999"
                                   value="12345-678" name="addressZipCode0">
                        </div>
                        <label for="addressCompl0" class="col-sm-2 control-label">Complemento</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="addressCompl0" placeholder="ex. Apto 10"
                                   value=" " name="addressCompl0">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="addressCity0" class="col-sm-2 control-label">Cidade*</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="addressCity0" placeholder="ex. S&atilde;o Paulo"
                                   value="Minha Cidade" name="addressCity0">
                        </div>
                    </div>
                    <div class="form-group required">
                        <label for="input-zone" class="col-sm-2 control-label">Estado*</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="input-zone" name="zone_id">
                                <option value=""> --- Selecione ---</option>
                                <option value="12">Acre / AC</option>
                                <option value="27">Alagoas / AL</option>
                                <option value="16">Amap&aacute; / AM</option>
                                <option value="13">Amazonas / AM</option>
                                <option value="29">Bahia / BA</option>
                                <option value="23">Cear&aacute; / CE</option>
                                <option value="53">Distrito Federal DF</option>
                                <option value="32">Esp&iacute;rito Santo / ES</option>
                                <option value="52">Goi&aacute;s / GO</option>
                                <option value="21">Maranh&atilde;o / MA</option>
                                <option value="51">Mato Grosso / MT</option>
                                <option value="50">Mato Grosso do Sul / MS</option>
                                <option value="31">Minas Gerais / MG</option>
                                <option value="15">Par&aacute; / PA</option>
                                <option value="25">Para&iacute;ba / PB</option>
                                <option value="41">Paran&aacute; / PR</option>
                                <option value="26">Pernambuco / PE</option>
                                <option value="22">Piau&iacute; / PI</option>
                                <option value="33">Rio de Janeiro / RJ</option>
                                <option value="24">Rio Grande do Norte / RN</option>
                                <option value="43">Rio Grande do Sul / RS</option>
                                <option value="11">Rond&ocirc;nia / RO</option>
                                <option value="14">Roraima / RR</option>
                                <option value="42">Santa Catarina / SC</option>
                                <option value="35" selected>S&atilde;o Paulo / SP</option>
                                <option value="28">Sergipe / SE</option>
                                <option value="17">Tocantins / TO</option>
                                <option value="99">Exterior</option>
                            </select>
                        </div>
                        <label for="addressCountry0" class="col-sm-2 control-label">Pa&iacute;s*</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="addressCountry0" name="addressCountry0">
                                <option value=""> --- Selecione ---</option>
                                <option value="244">Aaland Islands</option>
                                <option value="1">Afghanistan</option>
                                <option value="2">Albania</option>
                                <option value="3">Algeria</option>
                                <option value="4">American Samoa</option>
                                <option value="5">Andorra</option>
                                <option value="6">Angola</option>
                                <option value="7">Anguilla</option>
                                <option value="8">Antarctica</option>
                                <option value="9">Antigua and Barbuda</option>
                                <option value="10">Argentina</option>
                                <option value="11">Armenia</option>
                                <option value="12">Aruba</option>
                                <option value="252">Ascension Island (British)</option>
                                <option value="13">Australia</option>
                                <option value="14">Austria</option>
                                <option value="15">Azerbaijan</option>
                                <option value="16">Bahamas</option>
                                <option value="17">Bahrain</option>
                                <option value="18">Bangladesh</option>
                                <option value="19">Barbados</option>
                                <option value="20">Belarus</option>
                                <option value="21">Belgium</option>
                                <option value="22">Belize</option>
                                <option value="23">Benin</option>
                                <option value="24">Bermuda</option>
                                <option value="25">Bhutan</option>
                                <option value="26">Bolivia</option>
                                <option value="245">Bonaire, Sint Eustatius and Saba</option>
                                <option value="27">Bosnia and Herzegovina</option>
                                <option value="28">Botswana</option>
                                <option value="29">Bouvet Island</option>
                                <option value="30" selected>Brazil</option>
                                <option value="31">British Indian Ocean Territory</option>
                                <option value="32">Brunei Darussalam</option>
                                <option value="33">Bulgaria</option>
                                <option value="34">Burkina Faso</option>
                                <option value="35">Burundi</option>
                                <option value="36">Cambodia</option>
                                <option value="37">Cameroon</option>
                                <option value="38">Canada</option>
                                <option value="251">Canary Islands</option>
                                <option value="39">Cape Verde</option>
                                <option value="40">Cayman Islands</option>
                                <option value="41">Central African Republic</option>
                                <option value="42">Chad</option>
                                <option value="43">Chile</option>
                                <option value="44">China</option>
                                <option value="45">Christmas Island</option>
                                <option value="46">Cocos (Keeling) Islands</option>
                                <option value="47">Colombia</option>
                                <option value="48">Comoros</option>
                                <option value="49">Congo</option>
                                <option value="50">Cook Islands</option>
                                <option value="51">Costa Rica</option>
                                <option value="52">Cote D'Ivoire</option>
                                <option value="53">Croatia</option>
                                <option value="54">Cuba</option>
                                <option value="246">Curacao</option>
                                <option value="55">Cyprus</option>
                                <option value="56">Czech Republic</option>
                                <option value="237">Democratic Republic of Congo</option>
                                <option value="57">Denmark</option>
                                <option value="58">Djibouti</option>
                                <option value="59">Dominica</option>
                                <option value="60">Dominican Republic</option>
                                <option value="61">East Timor</option>
                                <option value="62">Ecuador</option>
                                <option value="63">Egypt</option>
                                <option value="64">El Salvador</option>
                                <option value="65">Equatorial Guinea</option>
                                <option value="66">Eritrea</option>
                                <option value="67">Estonia</option>
                                <option value="68">Ethiopia</option>
                                <option value="69">Falkland Islands (Malvinas)</option>
                                <option value="70">Faroe Islands</option>
                                <option value="71">Fiji</option>
                                <option value="72">Finland</option>
                                <option value="74">France, Metropolitan</option>
                                <option value="75">French Guiana</option>
                                <option value="76">French Polynesia</option>
                                <option value="77">French Southern Territories</option>
                                <option value="126">FYROM</option>
                                <option value="78">Gabon</option>
                                <option value="79">Gambia</option>
                                <option value="80">Georgia</option>
                                <option value="81">Germany</option>
                                <option value="82">Ghana</option>
                                <option value="83">Gibraltar</option>
                                <option value="84">Greece</option>
                                <option value="85">Greenland</option>
                                <option value="86">Grenada</option>
                                <option value="87">Guadeloupe</option>
                                <option value="88">Guam</option>
                                <option value="89">Guatemala</option>
                                <option value="256">Guernsey</option>
                                <option value="90">Guinea</option>
                                <option value="91">Guinea-Bissau</option>
                                <option value="92">Guyana</option>
                                <option value="93">Haiti</option>
                                <option value="94">Heard and Mc Donald Islands</option>
                                <option value="95">Honduras</option>
                                <option value="96">Hong Kong</option>
                                <option value="97">Hungary</option>
                                <option value="98">Iceland</option>
                                <option value="99">India</option>
                                <option value="100">Indonesia</option>
                                <option value="101">Iran (Islamic Republic of)</option>
                                <option value="102">Iraq</option>
                                <option value="103">Ireland</option>
                                <option value="254">Isle of Man</option>
                                <option value="104">Israel</option>
                                <option value="105">Italy</option>
                                <option value="106">Jamaica</option>
                                <option value="107">Japan</option>
                                <option value="257">Jersey</option>
                                <option value="108">Jordan</option>
                                <option value="109">Kazakhstan</option>
                                <option value="110">Kenya</option>
                                <option value="111">Kiribati</option>
                                <option value="113">Korea, Republic of</option>
                                <option value="253">Kosovo, Republic of</option>
                                <option value="114">Kuwait</option>
                                <option value="115">Kyrgyzstan</option>
                                <option value="116">Lao People's Democratic Republic</option>
                                <option value="117">Latvia</option>
                                <option value="118">Lebanon</option>
                                <option value="119">Lesotho</option>
                                <option value="120">Liberia</option>
                                <option value="121">Libyan Arab Jamahiriya</option>
                                <option value="122">Liechtenstein</option>
                                <option value="123">Lithuania</option>
                                <option value="124">Luxembourg</option>
                                <option value="125">Macau</option>
                                <option value="127">Madagascar</option>
                                <option value="128">Malawi</option>
                                <option value="129">Malaysia</option>
                                <option value="130">Maldives</option>
                                <option value="131">Mali</option>
                                <option value="132">Malta</option>
                                <option value="133">Marshall Islands</option>
                                <option value="134">Martinique</option>
                                <option value="135">Mauritania</option>
                                <option value="136">Mauritius</option>
                                <option value="137">Mayotte</option>
                                <option value="138">Mexico</option>
                                <option value="139">Micronesia, Federated States of</option>
                                <option value="140">Moldova, Republic of</option>
                                <option value="141">Monaco</option>
                                <option value="142">Mongolia</option>
                                <option value="242">Montenegro</option>
                                <option value="143">Montserrat</option>
                                <option value="144">Morocco</option>
                                <option value="145">Mozambique</option>
                                <option value="146">Myanmar</option>
                                <option value="147">Namibia</option>
                                <option value="148">Nauru</option>
                                <option value="149">Nepal</option>
                                <option value="150">Netherlands</option>
                                <option value="151">Netherlands Antilles</option>
                                <option value="152">New Caledonia</option>
                                <option value="153">New Zealand</option>
                                <option value="154">Nicaragua</option>
                                <option value="155">Niger</option>
                                <option value="156">Nigeria</option>
                                <option value="157">Niue</option>
                                <option value="158">Norfolk Island</option>
                                <option value="112">North Korea</option>
                                <option value="159">Northern Mariana Islands</option>
                                <option value="160">Norway</option>
                                <option value="161">Oman</option>
                                <option value="162">Pakistan</option>
                                <option value="163">Palau</option>
                                <option value="247">Palestinian Territory, Occupied</option>
                                <option value="164">Panama</option>
                                <option value="165">Papua New Guinea</option>
                                <option value="166">Paraguay</option>
                                <option value="167">Peru</option>
                                <option value="168">Philippines</option>
                                <option value="169">Pitcairn</option>
                                <option value="170">Poland</option>
                                <option value="171">Portugal</option>
                                <option value="172">Puerto Rico</option>
                                <option value="173">Qatar</option>
                                <option value="174">Reunion</option>
                                <option value="175">Romania</option>
                                <option value="176">Russian Federation</option>
                                <option value="177">Rwanda</option>
                                <option value="178">Saint Kitts and Nevis</option>
                                <option value="179">Saint Lucia</option>
                                <option value="180">Saint Vincent and the Grenadines</option>
                                <option value="181">Samoa</option>
                                <option value="182">San Marino</option>
                                <option value="183">Sao Tome and Principe</option>
                                <option value="184">Saudi Arabia</option>
                                <option value="185">Senegal</option>
                                <option value="243">Serbia</option>
                                <option value="186">Seychelles</option>
                                <option value="187">Sierra Leone</option>
                                <option value="188">Singapore</option>
                                <option value="189">Slovak Republic</option>
                                <option value="190">Slovenia</option>
                                <option value="191">Solomon Islands</option>
                                <option value="192">Somalia</option>
                                <option value="193">South Africa</option>
                                <option value="194">South Georgia &amp; South Sandwich Islands</option>
                                <option value="248">South Sudan</option>
                                <option value="195">Spain</option>
                                <option value="196">Sri Lanka</option>
                                <option value="249">St. Barthelemy</option>
                                <option value="197">St. Helena</option>
                                <option value="250">St. Martin (French part)</option>
                                <option value="198">St. Pierre and Miquelon</option>
                                <option value="199">Sudan</option>
                                <option value="200">Suriname</option>
                                <option value="201">Svalbard and Jan Mayen Islands</option>
                                <option value="202">Swaziland</option>
                                <option value="203">Sweden</option>
                                <option value="204">Switzerland</option>
                                <option value="205">Syrian Arab Republic</option>
                                <option value="206">Taiwan</option>
                                <option value="207">Tajikistan</option>
                                <option value="208">Tanzania, United Republic of</option>
                                <option value="209">Thailand</option>
                                <option value="210">Togo</option>
                                <option value="211">Tokelau</option>
                                <option value="212">Tonga</option>
                                <option value="213">Trinidad and Tobago</option>
                                <option value="255">Tristan da Cunha</option>
                                <option value="214">Tunisia</option>
                                <option value="215">Turkey</option>
                                <option value="216">Turkmenistan</option>
                                <option value="217">Turks and Caicos Islands</option>
                                <option value="218">Tuvalu</option>
                                <option value="219">Uganda</option>
                                <option value="220">Ukraine</option>
                                <option value="221">United Arab Emirates</option>
                                <option value="222">United Kingdom</option>
                                <option value="223">United States</option>
                                <option value="224">United States Minor Outlying Islands</option>
                                <option value="225">Uruguay</option>
                                <option value="226">Uzbekistan</option>
                                <option value="227">Vanuatu</option>
                                <option value="228">Vatican City State (Holy See)</option>
                                <option value="229">Venezuela</option>
                                <option value="230">Viet Nam</option>
                                <option value="231">Virgin Islands (British)</option>
                                <option value="232">Virgin Islands (U.S.)</option>
                                <option value="233">Wallis and Futuna Islands</option>
                                <option value="234">Western Sahara</option>
                                <option value="235">Yemen</option>
                                <option value="238">Zambia</option>
                                <option value="239">Zimbabwe</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="isDelivery0">Entrega?</label>
                        <input type="checkbox" class="col-sm-2" id="isDelivery0" name="isDelivery0" checked>
                        <label class="col-sm-2 control-label text-right" for="isBilling0">Cobran&ccedil;a?</label>
                        <input type="checkbox" class="col-sm-2 text-right" id="isBilling0" name="isBilling0" checked>
                        <label class="col-sm-2 control-label text-right" for="isMain0">Principal?</label>
                        <input type="checkbox" class="col-sm-2" id="isMain0" name="isMain0" checked>
                    </div>
                    <div id="new-address-wrapper"></div>
                    <div class="form-group text-right m-t-40">
                        <a class="btn btn-primary" id="addAddress">Adicionar Endere&ccedil;o</a>
                    </div>

                    <div class="m-t-40"></div>
                    <div class="buttons clearfix">
                        <div class="pull-left"><a href="index.jsp" class="btn btn-default">Cancelar</a></div>
                        <div class="pull-right">
                            <input type="submit" value="Salvar" class="btn btn-primary"/>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>
<div class="footer-top-cms parallax-container">
    <div class="parallax"><img src="resources/image/parallax1.jpg" alt="#"></div>
    <div class="container">
        <div class="row">
            <div class="newslatter">
                <form>
                    <h5>FIQUE POR DENTRO!</h5>
                    <h4 class="title-subline text-white">Receba todas as novidades, promo&ccedil;&otilde;es, e eventos diretamente
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
                        <li class="mastero"><a href="#"><img alt="" src="resources/image/payment/mastero.jpg"></a></li>
                        <li class="visa"><a href="#"><img alt="" src="resources/image/payment/visa.jpg"></a></li>
                        <li class="currus"><a href="#"><img alt="" src="resources/image/payment/currus.jpg"></a></li>
                        <li class="discover"><a href="#"><img alt="" src="resources/image/payment/discover.jpg"></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <a id="scrollup">Scroll</a>
</footer>

<script src="resources/javascript/jquery.parallax.js"></script>
<script>
    jQuery(document).ready(function ($) {
        $('.parallax').parallax();
        var addButton = $('#addAddress');
        var wrapper = $('#new-address-wrapper');
        var fieldHTML = '<hr/><div class="form-group">' +
            '<label for="addressId0" class="col-sm-2 control-label">Identificador</label>' +
            '<div class="col-sm-10">' +
            '<input type="text" class="form-control" id="addressId0" placeholder="Escolha um nome para identificar esse endere&ccedil;o" value="" name="addressId0">' +
            '</div>' +
            '</div>' +
            '<div class="form-group required">' +
            '<label for="addressPlace0" class="col-sm-2 control-label">Logradouro*</label>' +
            '<div class="col-sm-10">' +
            '<input type="text" class="form-control" id="addressPlace0" placeholder="ex. Rua, Avenida, Travessa..." value="" name="addressPlace0">' +
            '</div>' +
            '</div>' +
            '<div class="form-group">' +
            '<label for="addressNumber0" class="col-sm-2 control-label">N&uacute;mero*</label>' +
            '<div class="col-sm-2">' +
            '<input type="text" class="form-control" id="addressNumber0" placeholder="ex. 51" value="" name="addressNumber0">' +
            '</div>' +
            '<label for="addressNeighborhood0" class="col-sm-2 control-label">Bairro</label>' +
            '<div class="col-sm-6">' +
            '<input type="text" class="form-control" id="addressNeighborhood0" placeholder="ex. Centro" value="" name="addressNeighborhood0">' +
            '</div>' +
            '</div>' +
            '<div class="form-group">' +
            '<label for="addressZipCode0" class="col-sm-2 control-label">CEP*</label>' +
            '<div class="col-sm-2">' +
            '<input type="text" class="form-control" id="addressZipCode0" placeholder="ex. 99999-999" value="" name="addressZipCode0">' +
            '</div>' +
            '<label for="addressCompl0" class="col-sm-2 control-label">Complemento</label>' +
            '<div class="col-sm-6">' +
            '<input type="text" class="form-control" id="addressCompl0" placeholder="ex. Apto 10" value="" name="addressCompl0">' +
            '</div>' +
            '</div>' +
            '<div class="form-group required">' +
            '<label for="addressCity0" class="col-sm-2 control-label">Cidade*</label>' +
            '<div class="col-sm-10">' +
            '<input type="text" class="form-control" id="addressCity0" placeholder="ex. S&atilde;o Paulo" value="" name="addressCity0">' +
            '</div>' +
            '</div>' +
            '<div class="form-group required">' +
            '<label for="input-zone" class="col-sm-2 control-label">Estado*</label>' +
            '<div class="col-sm-4">' +
            '<select class="form-control" id="input-zone" name="zone_id">' +
            '<option value=""> --- Selecione --- </option>' +
            '<option value="12">Acre / AC</option>' +
            '<option value="27">Alagoas / AL</option>' +
            '<option value="16">Amap&aacute; / AM</option>' +
            '<option value="13">Amazonas / AM</option>' +
            '<option value="29">Bahia / BA</option>' +
            '<option value="23">Cear&aacute; / CE</option>' +
            '<option value="53">Distrito Federal DF</option>' +
            '<option value="32">Esp&iacute;rito Santo / ES</option>' +
            '<option value="52">Goi&aacute;s / GO</option>' +
            '<option value="21">Maranh&atilde;o / MA</option>' +
            '<option value="51">Mato Grosso / MT</option>' +
            '<option value="50">Mato Grosso do Sul / MS</option>' +
            '<option value="31">Minas Gerais / MG</option>' +
            '<option value="15">Par&aacute; / PA</option>' +
            '<option value="25">Para&iacute;ba / PB</option>' +
            '<option value="41">Paran&aacute; / PR</option>' +
            '<option value="26">Pernambuco / PE</option>' +
            '<option value="22">Piau&iacute; / PI</option>' +
            '<option value="33">Rio de Janeiro / RJ</option>' +
            '<option value="24">Rio Grande do Norte / RN</option>' +
            '<option value="43">Rio Grande do Sul / RS</option>' +
            '<option value="11">Rond&ocirc;nia / RO</option>' +
            '<option value="14">Roraima / RR</option>' +
            '<option value="42">Santa Catarina / SC</option>' +
            '<option value="35">S&atilde;o Paulo / SP</option>' +
            '<option value="28">Sergipe / SE</option>' +
            '<option value="17">Tocantins / TO</option>' +
            '<option value="99">Exterior</option>' +
            '</select>' +
            '</div>' +
            '<label for="addressCountry0" class="col-sm-2 control-label">Pa&iacute;s*</label>' +
            '<div class="col-sm-4">' +
            '<select class="form-control" id="addressCountry0" name="addressCountry0">' +
            '<option value=""> --- Selecione --- </option>' +
            '<option value="244">Aaland Islands</option>' +
            '<option value="1">Afghanistan</option>' +
            '<option value="2">Albania</option>' +
            '<option value="3">Algeria</option>' +
            '<option value="4">American Samoa</option>' +
            '<option value="5">Andorra</option>' +
            '<option value="6">Angola</option>' +
            '<option value="7">Anguilla</option>' +
            '<option value="8">Antarctica</option>' +
            '<option value="9">Antigua and Barbuda</option>' +
            '<option value="10">Argentina</option>' +
            '<option value="11">Armenia</option>' +
            '<option value="12">Aruba</option>' +
            '<option value="252">Ascension Island (British)</option>' +
            '<option value="13">Australia</option>' +
            '<option value="14">Austria</option>' +
            '<option value="15">Azerbaijan</option>' +
            '<option value="16">Bahamas</option>' +
            '<option value="17">Bahrain</option>' +
            '<option value="18">Bangladesh</option>' +
            '<option value="19">Barbados</option>' +
            '<option value="20">Belarus</option>' +
            '<option value="21">Belgium</option>' +
            '<option value="22">Belize</option>' +
            '<option value="23">Benin</option>' +
            '<option value="24">Bermuda</option>' +
            '<option value="25">Bhutan</option>' +
            '<option value="26">Bolivia</option>' +
            '<option value="245">Bonaire, Sint Eustatius and Saba</option>' +
            '<option value="27">Bosnia and Herzegovina</option>' +
            '<option value="28">Botswana</option>' +
            '<option value="29">Bouvet Island</option>' +
            '<option value="30">Brazil</option>' +
            '<option value="31">British Indian Ocean Territory</option>' +
            '<option value="32">Brunei Darussalam</option>' +
            '<option value="33">Bulgaria</option>' +
            '<option value="34">Burkina Faso</option>' +
            '<option value="35">Burundi</option>' +
            '<option value="36">Cambodia</option>' +
            '<option value="37">Cameroon</option>' +
            '<option value="38">Canada</option>' +
            '<option value="251">Canary Islands</option>' +
            '<option value="39">Cape Verde</option>' +
            '<option value="40">Cayman Islands</option>' +
            '<option value="41">Central African Republic</option>' +
            '<option value="42">Chad</option>' +
            '<option value="43">Chile</option>' +
            '<option value="44">China</option>' +
            '<option value="45">Christmas Island</option>' +
            '<option value="46">Cocos (Keeling) Islands</option>' +
            '<option value="47">Colombia</option>' +
            '<option value="48">Comoros</option>' +
            '<option value="49">Congo</option>' +
            '<option value="50">Cook Islands</option>' +
            '<option value="51">Costa Rica</option>' +
            '<option value="52">Cote D' +
            'Ivoire < /option>' +
            '<option value="53">Croatia</option>' +
            '<option value="54">Cuba</option>' +
            '<option value="246">Curacao</option>' +
            '<option value="55">Cyprus</option>' +
            '<option value="56">Czech Republic</option>' +
            '<option value="237">Democratic Republic of Congo</option>' +
            '<option value="57">Denmark</option>' +
            '<option value="58">Djibouti</option>' +
            '<option value="59">Dominica</option>' +
            '<option value="60">Dominican Republic</option>' +
            '<option value="61">East Timor</option>' +
            '<option value="62">Ecuador</option>' +
            '<option value="63">Egypt</option>' +
            '<option value="64">El Salvador</option>' +
            '<option value="65">Equatorial Guinea</option>' +
            '<option value="66">Eritrea</option>' +
            '<option value="67">Estonia</option>' +
            '<option value="68">Ethiopia</option>' +
            '<option value="69">Falkland Islands (Malvinas)</option>' +
            '<option value="70">Faroe Islands</option>' +
            '<option value="71">Fiji</option>' +
            '<option value="72">Finland</option>' +
            '<option value="74">France, Metropolitan</option>' +
            '<option value="75">French Guiana</option>' +
            '<option value="76">French Polynesia</option>' +
            '<option value="77">French Southern Territories</option>' +
            '<option value="126">FYROM</option>' +
            '<option value="78">Gabon</option>' +
            '<option value="79">Gambia</option>' +
            '<option value="80">Georgia</option>' +
            '<option value="81">Germany</option>' +
            '<option value="82">Ghana</option>' +
            '<option value="83">Gibraltar</option>' +
            '<option value="84">Greece</option>' +
            '<option value="85">Greenland</option>' +
            '<option value="86">Grenada</option>' +
            '<option value="87">Guadeloupe</option>' +
            '<option value="88">Guam</option>' +
            '<option value="89">Guatemala</option>' +
            '<option value="256">Guernsey</option>' +
            '<option value="90">Guinea</option>' +
            '<option value="91">Guinea-Bissau</option>' +
            '<option value="92">Guyana</option>' +
            '<option value="93">Haiti</option>' +
            '<option value="94">Heard and Mc Donald Islands</option>' +
            '<option value="95">Honduras</option>' +
            '<option value="96">Hong Kong</option>' +
            '<option value="97">Hungary</option>' +
            '<option value="98">Iceland</option>' +
            '<option value="99">India</option>' +
            '<option value="100">Indonesia</option>' +
            '<option value="101">Iran (Islamic Republic of)</option>' +
            '<option value="102">Iraq</option>' +
            '<option value="103">Ireland</option>' +
            '<option value="254">Isle of Man</option>' +
            '<option value="104">Israel</option>' +
            '<option value="105">Italy</option>' +
            '<option value="106">Jamaica</option>' +
            '<option value="107">Japan</option>' +
            '<option value="257">Jersey</option>' +
            '<option value="108">Jordan</option>' +
            '<option value="109">Kazakhstan</option>' +
            '<option value="110">Kenya</option>' +
            '<option value="111">Kiribati</option>' +
            '<option value="113">Korea, Republic of</option>' +
            '<option value="253">Kosovo, Republic of</option>' +
            '<option value="114">Kuwait</option>' +
            '<option value="115">Kyrgyzstan</option>' +
            '<option value="116">Lao People\'s Democratic Republic < /option>' +
            '<option value="117">Latvia</option>' +
            '<option value="118">Lebanon</option>' +
            '<option value="119">Lesotho</option>' +
            '<option value="120">Liberia</option>' +
            '<option value="121">Libyan Arab Jamahiriya</option>' +
            '<option value="122">Liechtenstein</option>' +
            '<option value="123">Lithuania</option>' +
            '<option value="124">Luxembourg</option>' +
            '<option value="125">Macau</option>' +
            '<option value="127">Madagascar</option>' +
            '<option value="128">Malawi</option>' +
            '<option value="129">Malaysia</option>' +
            '<option value="130">Maldives</option>' +
            '<option value="131">Mali</option>' +
            '<option value="132">Malta</option>' +
            '<option value="133">Marshall Islands</option>' +
            '<option value="134">Martinique</option>' +
            '<option value="135">Mauritania</option>' +
            '<option value="136">Mauritius</option>' +
            '<option value="137">Mayotte</option>' +
            '<option value="138">Mexico</option>' +
            '<option value="139">Micronesia, Federated States of</option>' +
            '<option value="140">Moldova, Republic of</option>' +
            '<option value="141">Monaco</option>' +
            '<option value="142">Mongolia</option>' +
            '<option value="242">Montenegro</option>' +
            '<option value="143">Montserrat</option>' +
            '<option value="144">Morocco</option>' +
            '<option value="145">Mozambique</option>' +
            '<option value="146">Myanmar</option>' +
            '<option value="147">Namibia</option>' +
            '<option value="148">Nauru</option>' +
            '<option value="149">Nepal</option>' +
            '<option value="150">Netherlands</option>' +
            '<option value="151">Netherlands Antilles</option>' +
            '<option value="152">New Caledonia</option>' +
            '<option value="153">New Zealand</option>' +
            '<option value="154">Nicaragua</option>' +
            '<option value="155">Niger</option>' +
            '<option value="156">Nigeria</option>' +
            '<option value="157">Niue</option>' +
            '<option value="158">Norfolk Island</option>' +
            '<option value="112">North Korea</option>' +
            '<option value="159">Northern Mariana Islands</option>' +
            '<option value="160">Norway</option>' +
            '<option value="161">Oman</option>' +
            '<option value="162">Pakistan</option>' +
            '<option value="163">Palau</option>' +
            '<option value="247">Palestinian Territory, Occupied</option>' +
            '<option value="164">Panama</option>' +
            '<option value="165">Papua New Guinea</option>' +
            '<option value="166">Paraguay</option>' +
            '<option value="167">Peru</option>' +
            '<option value="168">Philippines</option>' +
            '<option value="169">Pitcairn</option>' +
            '<option value="170">Poland</option>' +
            '<option value="171">Portugal</option>' +
            '<option value="172">Puerto Rico</option>' +
            '<option value="173">Qatar</option>' +
            '<option value="174">Reunion</option>' +
            '<option value="175">Romania</option>' +
            '<option value="176">Russian Federation</option>' +
            '<option value="177">Rwanda</option>' +
            '<option value="178">Saint Kitts and Nevis</option>' +
            '<option value="179">Saint Lucia</option>' +
            '<option value="180">Saint Vincent and the Grenadines</option>' +
            '<option value="181">Samoa</option>' +
            '<option value="182">San Marino</option>' +
            '<option value="183">Sao Tome and Principe</option>' +
            '<option value="184">Saudi Arabia</option>' +
            '<option value="185">Senegal</option>' +
            '<option value="243">Serbia</option>' +
            '<option value="186">Seychelles</option>' +
            '<option value="187">Sierra Leone</option>' +
            '<option value="188">Singapore</option>' +
            '<option value="189">Slovak Republic</option>' +
            '<option value="190">Slovenia</option>' +
            '<option value="191">Solomon Islands</option>' +
            '<option value="192">Somalia</option>' +
            '<option value="193">South Africa</option>' +
            '<option value="194">South Georgia &amp; South Sandwich Islands</option>' +
            '<option value="248">South Sudan</option>' +
            '<option value="195">Spain</option>' +
            '<option value="196">Sri Lanka</option>' +
            '<option value="249">St. Barthelemy</option>' +
            '<option value="197">St. Helena</option>' +
            '<option value="250">St. Martin (French part)</option>' +
            '<option value="198">St. Pierre and Miquelon</option>' +
            '<option value="199">Sudan</option>' +
            '<option value="200">Suriname</option>' +
            '<option value="201">Svalbard and Jan Mayen Islands</option>' +
            '<option value="202">Swaziland</option>' +
            '<option value="203">Sweden</option>' +
            '<option value="204">Switzerland</option>' +
            '<option value="205">Syrian Arab Republic</option>' +
            '<option value="206">Taiwan</option>' +
            '<option value="207">Tajikistan</option>' +
            '<option value="208">Tanzania, United Republic of</option>' +
            '<option value="209">Thailand</option>' +
            '<option value="210">Togo</option>' +
            '<option value="211">Tokelau</option>' +
            '<option value="212">Tonga</option>' +
            '<option value="213">Trinidad and Tobago</option>' +
            '<option value="255">Tristan da Cunha</option>' +
            '<option value="214">Tunisia</option>' +
            '<option value="215">Turkey</option>' +
            '<option value="216">Turkmenistan</option>' +
            '<option value="217">Turks and Caicos Islands</option>' +
            '<option value="218">Tuvalu</option>' +
            '<option value="219">Uganda</option>' +
            '<option value="220">Ukraine</option>' +
            '<option value="221">United Arab Emirates</option>' +
            '<option value="222">United Kingdom</option>' +
            '<option value="223">United States</option>' +
            '<option value="224">United States Minor Outlying Islands</option>' +
            '<option value="225">Uruguay</option>' +
            '<option value="226">Uzbekistan</option>' +
            '<option value="227">Vanuatu</option>' +
            '<option value="228">Vatican City State (Holy See)</option>' +
            '<option value="229">Venezuela</option>' +
            '<option value="230">Viet Nam</option>' +
            '<option value="231">Virgin Islands (British)</option>' +
            '<option value="232">Virgin Islands (U.S.)</option>' +
            '<option value="233">Wallis and Futuna Islands</option>' +
            '<option value="234">Western Sahara</option>' +
            '<option value="235">Yemen</option>' +
            '<option value="238">Zambia</option>' +
            '<option value="239">Zimbabwe</option>' +
            '</select>' +
            '</div>' +
            '</div>' +
            '<div class="form-group">' +
            '<label class="col-sm-2 control-label" for="isDelivery0">Entrega?</label>' +
            '<input type="checkbox" class="col-sm-2" id="isDelivery0" name="isDelivery0" checked>' +
            '<label class="col-sm-2 control-label text-right" for="isBilling0">Cobran&ccedil;a?</label>' +
            '<input type="checkbox" class="col-sm-2 text-right" id="isBilling0" name="isBilling0" checked>' +
            '<label class="col-sm-2 control-label text-right" for="isMain0">Principal?</label>' +
            '<input type="checkbox" class="col-sm-2" id="isMain0" name="isMain0" checked>' +
            '</div>';

        $(addButton).click(function () {
            $(wrapper).append(fieldHTML);
        })
    });
</script>
</body>
</html>