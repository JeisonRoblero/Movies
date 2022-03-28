<%@ page import="static com.proyecto.moviesplay.CircularServlet.lc" %>
<%@ page import="static com.proyecto.moviesplay.DoblementeEnlazadaServlet.lde" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
    <title>Buscar <%= request.getParameter("b") %> | Movies </title>

    <!--=== Color de barra superior ====-->
    <meta name="theme-color" content="#131313"/>

    <!-- Inicio Meta Etiquetas para Redes Sociales y SEO -->
    <meta property="og:image" itemprop="image" content="images/favicon.png"/>
    <meta property="og:site_name" content="Movies | Peliculas y Series"/>
    <meta property="og:title" content="<%= request.getParameter("b") %> | Movies | Peliculas y Series"/>
    <meta property="og:description" content="Disfruta de una gran variedad de películas, series, documentales y mucho más."/>
    <meta property="og:url" content="https://movies.ga/"/>
    <meta property="og:type" content="website"/>
    <meta name="description" content="Disfruta de una gran variedad de películas, series, documentales y mucho más.">
    <!-- Fin Meta Etiquetas para Redes Sociales y SEO -->

    <%-- Estilos --%>
    <link rel="stylesheet" href="css/style.css">

    <%-- Fuente de letras --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap" rel="stylesheet">

    <%-- Iconos --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

    <%-- Deslizador Principal --%>
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>

    <!-- Materialize Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <%-- Estilos extras implementados como prioridad --%>
    <style>
        :root{
            --tamanio-buscador: 400px;
        }

        .search-btn1 {
            transition: 0.5s ease;
        }

        .toggle-search-btn1 {
            transform: translateX(-400px);
        }

        .buscador-container {
            background: rgba(0, 0, 0, 0.88);
            backdrop-filter: blur(30px);
            border-radius: 0.5rem;
            padding: 0;
            height: 3.5rem;
            position: absolute;
            width: var(--tamanio-buscador);
            right: 11rem;
            top: 3.8px;
            display: flex;
            align-items: center;
            transform: translateX(150%);
            transition: 0.3s ease;
        }

        .toggle-search {
            transform: translateX(0%);
        }

        .buscador {
            display:flex;
        }

        .back-search {
            margin-top: -3.5px;
            color: #fff;
            cursor: pointer;
        }

        .clean-input {
            position: absolute;
            margin-top: -3.5px;
            right: -32px;
            color: #fff;
            cursor: pointer;
        }

        #search {
            background: transparent;
            height: 3.5rem;
            color: #fff;
            border-radius: 0.5rem;
            width: calc(var(--tamanio-buscador) - 110px);
            transition: 0.5s ease;
        }

        @media screen and (max-width: 768px){

            :root{
                --tamanio-buscador: 100%;
            }

            .buscador-container {
                right: 0;
                width: var(--tamanio-buscador);
                z-index: 110;
                height: 4.5rem;
                top: 0;
                border-radius: 0;
            }

            #search {
                height: 4.5rem;
                width: 73vw;
            }

            .back-search {
                margin-top: 4.5px;
            }

            .clean-input {
                margin-top: 4.5px;
            }


        }
    </style>

</head>
<body>

    <header>
        <nav style="background-color: rgba(0,0,0,0.97); backdrop-filter: blur(20px); box-shadow: none">
            <div class="logo"><span><a href="./">Movies</a></span></div>
            <div class="menu">

                <ul class="menu-izquierdo">
                    <li><a href="./">Inicio</a></li>
                    <li><a href="./">Series de TV</a></li>
                    <li><a href="./">Peliculas</a></li>
                </ul>

                <ul class="menu-derecho" style="margin-top: 25px;">

                    <%
                        if(session.getAttribute("idadmin")!=null || session.getAttribute("idusuario")!=null){
                    %>
                    <li><a href="./" title="Notificaciones"><i class="bi bi-bell-fill"></i></a></li>
                    <%
                    }else{
                    %>
                    <li><a href="login.jsp" title="Notificaciones"><i class="bi bi-bell-slash-fill"></i></a></li>
                    <%
                        }
                    %>

                    <%
                        if(session.getAttribute("idadmin")==null && session.getAttribute("idusuario")==null){
                    %>
                    <li><a href="login.jsp" title="Iniciar Sesión"><i class="bi bi-person-circle"></i></a></li>
                    <%
                        }
                    %>


                    <%
                        if(session.getAttribute("idadmin")!=null || session.getAttribute("idusuario")!=null){
                    %>
                    <li><a href="logout.jsp" title="Cerrar Sesión"><i class="bi bi-box-arrow-right"></i></a></li>
                    <%
                        }
                    %>

                </ul>

            </div>


            <div class="buscador-derecho" style="margin-top: 25px;">
                <ul>
                    <li><a href="#search" title="Buscar" class="search-btn1"><i class="bi bi-search"></i></a>
                    </li>
                </ul>
            </div>

            <div>

                <nav class="buscador-container">
                    <div class="nav-wrapper">
                        <form action="./busqueda.jsp" method="get" autocomplete="off">
                            <div class="input-field buscador">
                                <input id="search" type="search" name="b" value="<%= request.getParameter("b") %>" required placeholder="Películas, Series, TV ¿Qué deseas buscar?">
                                <label class="label-icon" for="search"><i class="bi bi-arrow-left-short back-search" style="font-size:2.4rem; margin-top: 13px"></i></label>
                                <i class="bi bi-x-lg clean-input" style="margin-top: 15px;"></i>
                            </div>
                        </form>
                    </div>
                </nav>

                <ul id="box-search">

                    <!-- ------------ -->
                    <!-- De Cartelera -->
                    <!-- ------------ -->
                    <%
                        int cont5 = 0;
                        String star = "";
                        String nombrePeliculaC = "";
                        String nombreOriginalC = "";

                        if(lc.getCantidad() > 0){

                            //1. ubicar el ultimo elemento de la lista
                            //ListaCircularSimple lc = (ListaCircularSimple) request.getSession().getAttribute("lc");

                            lc.setActual(lc.getUltimo());

                            while (cont5 < lc.getCantidad() && lc.getActual()!=null){

                                //Estrellas
                                if(lc.getActual().getResenia().equals("1")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("1.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("2")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("2.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("3")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("3.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("4")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("4.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i>";
                                }else if(lc.getActual().getResenia().equals("5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i>";
                                }else if(lc.getActual().getResenia().equals("0")){
                                    star = "<i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("0.5")){
                                    star = "<i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }

                                if(lc.getActual().getNombrePelicula().length()>21){
                                    nombrePeliculaC = lc.getActual().getNombrePelicula().substring(0,21);
                                }else {
                                    nombrePeliculaC = lc.getActual().getNombrePelicula();
                                }

                                if(lc.getActual().getNombreOriginal().length()>14){
                                    nombreOriginalC = lc.getActual().getNombreOriginal().substring(0, 14);
                                }else {
                                    nombreOriginalC = lc.getActual().getNombreOriginal();
                                }


                    %>

                    <li><a href="descripcion.jsp?idc=<%= lc.getActual().getId() %>"><img src="<%= lc.getActual().getImagen() %>" loading="lazy" class="img-box-search"><%= nombrePeliculaC %> <small><%= nombreOriginalC %> | <%= lc.getActual().getResenia() %> ⭐ </small></a></li>

                    <%
                                //3. Identificar su siguiente nodo
                                lc.setActual(lc.getActual().getSiguiente());
                                cont5++;

                            }

                        }

                    %>

                    <!-- ------------ -->
                    <!-- De Populares -->
                    <!-- ------------ -->

                    <%
                        String star2 = "";
                        String nombrePeliculaC2 = "";
                        String nombreOriginalC2 = "";

                        if(lde.getCantidad() > 0){

                            //1. ubicar el primer elemento de la lista
                            lde.setActual(lde.getPrimero());

                            while (lde.getActual()!=null){

                                //Estrellas
                                if(lde.getActual().getResenia().equals("1")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("1.5")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("2")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("2.5")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("3")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("3.5")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("4")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("4.5")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i>";
                                }else if(lde.getActual().getResenia().equals("5")){
                                    star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i>";
                                }else if(lde.getActual().getResenia().equals("0")){
                                    star2 = "<i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("0.5")){
                                    star2 = "<i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }

                                if(lde.getActual().getNombrePelicula().length()>21){
                                    nombrePeliculaC2 = lde.getActual().getNombrePelicula().substring(0,21);
                                }else {
                                    nombrePeliculaC2 = lde.getActual().getNombrePelicula();
                                }

                                if(lde.getActual().getNombreOriginal().length()>14){
                                    nombreOriginalC2 = lde.getActual().getNombreOriginal().substring(0, 14);
                                }else {
                                    nombreOriginalC2 = lde.getActual().getNombreOriginal();
                                }


                    %>

                    <li><a href="descripcion.jsp?idlde=<%= lde.getActual().getId() %>"><img src="<%= lde.getActual().getImagen() %>" loading="lazy" class="img-box-search"><%= nombrePeliculaC2 %> <small><%= nombreOriginalC2 %> | <%= lde.getActual().getResenia() %> ⭐ </small></a></li>

                    <%
                                //3. Identificar su siguiente nodo
                                lde.setActual(lde.getActual().getSiguiente());

                            }

                        }

                    %>

                </ul>

            </div>

            <div class="burger">
                <div class="linea1"></div>
                <div class="linea2"></div>
                <div class="linea3"></div>
            </div>
        </nav>
    </header>

    <main>

        <section class="texto-encontrado">
            <p>Resultados encontrados para: <%= request.getParameter("b") %> </p>
        </section>
        <br>

        <!-- ------------ -->
        <!-- De Cartelera -->
        <!-- ------------ -->

        <%

            Boolean encontrado = false;

        %>

            <section class="cartelera-busqueda">

                <div class="row">
                    <div class="col s12 m7 card-container1" style="width: unset">

                <%
                    int cont = 0;
                    String nombrePelicula1 = "";
                    String nombreOriginal1 = "";
                    String sinopsis1 = "";

                    if(lc.getCantidad() > 0){

                        //1. ubicar el ultimo elemento de la lista
                        //ListaCircularSimple lc = (ListaCircularSimple) request.getSession().getAttribute("lc");

                        lc.setActual(lc.getUltimo());

                        while (cont < lc.getCantidad() && lc.getActual()!=null){

                            nombrePelicula1 = lc.getActual().getNombrePelicula().toLowerCase();
                            nombreOriginal1 = lc.getActual().getNombreOriginal().toLowerCase();
                            sinopsis1 = lc.getActual().getSinopsis().toLowerCase();

                            if(nombrePelicula1.contains(request.getParameter("b").toLowerCase()) || nombreOriginal1.contains(request.getParameter("b").toLowerCase()) || sinopsis1.contains(request.getParameter("b").toLowerCase())){

                                encontrado = true;

                                //Estrellas
                                if(lc.getActual().getResenia().equals("1")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("1.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("2")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("2.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("3")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("3.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("4")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("4.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i>";
                                }else if(lc.getActual().getResenia().equals("5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i>";
                                }else if(lc.getActual().getResenia().equals("0")){
                                    star = "<i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lc.getActual().getResenia().equals("0.5")){
                                    star = "<i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }

                %>

                                        <div class="card card-pelicula-b" style="background: #131313; margin: 20px; width: 100%; max-width: 20rem;">

                                            <div class="card-image" style="background: #131313; width: 100%; max-width: 20rem;">
                                                <img src="<%= lc.getActual().getImagen() %>" style=" width: 100%; max-width: 20rem; height: 20rem; object-fit: cover; overflow: hidden; background-position: center">
                                                <span class="card-title"><%= lc.getActual().getNombrePelicula() %></span>
                                            </div>
                                            <div class="card-content" style="background: #131313; width: 100%; max-width: 20rem;">
                                                <p><%= lc.getActual().getNombreOriginal() %> | <%= lc.getActual().getResenia() %> <span style="color: #FCD53F"> <%= star %> </span> </p>
                                            </div>
                                            <div class="card-action" style="background: #131313; width: 100%; max-width: 20rem;">
                                                <a href="descripcion.jsp?idc=<%= lc.getActual().getId() %>"><i class="bi bi-play-fill"></i> Ver Película</a>
                                            </div>

                                        </div>



                <%

                            }

                            //3. Identificar su siguiente nodo
                            lc.setActual(lc.getActual().getSiguiente());
                            cont++;

                        }

                    }

                %>

                    </div>
                </div>

            </section>

        <br>


        <!-- ------------ -->
        <!-- De Populares -->
        <!-- ------------ -->

            <section class="populares-busqueda">

                <div class="row">
                    <div class="col s12 m7 card-container1" style="width: unset">

                <%
                    String nombrePelicula2 = "";
                    String nombreOriginal2 = "";
                    String sinopsis2 = "";

                    if(lde.getCantidad() > 0){

                        //1. ubicar el primer elemento de la lista
                        lde.setActual(lde.getPrimero());

                        while (lde.getActual()!=null){

                            nombrePelicula2 = lde.getActual().getNombrePelicula().toLowerCase();
                            nombreOriginal2 = lde.getActual().getNombreOriginal().toLowerCase();
                            sinopsis2 = lde.getActual().getSinopsis().toLowerCase();

                            if(nombrePelicula2.contains(request.getParameter("b").toLowerCase()) || nombreOriginal2.contains(request.getParameter("b").toLowerCase()) || sinopsis2.contains(request.getParameter("b").toLowerCase())){

                                encontrado = true;

                                //Estrellas
                                if(lde.getActual().getResenia().equals("1")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("1.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("2")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("2.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("3")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("3.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("4")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("4.5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i>";
                                }else if(lde.getActual().getResenia().equals("5")){
                                    star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i>";
                                }else if(lde.getActual().getResenia().equals("0")){
                                    star = "<i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }else if(lde.getActual().getResenia().equals("0.5")){
                                    star = "<i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                                }

                %>

                                <div class="card card-pelicula-b" style="background: #131313; margin: 20px; width: 100%; max-width: 20rem;">

                                    <div class="card-image" style="background: #131313; width: 100%; max-width: 20rem;">
                                        <img src="<%= lde.getActual().getImagen() %>" style="width: 100%; max-width: 20rem; height: 20rem; object-fit: cover; overflow: hidden; background-position: center">
                                        <span class="card-title"><%= lde.getActual().getNombrePelicula() %></span>
                                    </div>
                                    <div class="card-content" style="background: #131313; width: 100%; max-width: 20rem;">
                                        <p><%= lde.getActual().getNombreOriginal() %> | <%= lde.getActual().getResenia() %> <span style="color: #FCD53F"> <%= star %> </span> </p>
                                    </div>
                                    <div class="card-action" style="background: #131313; width: 100%; max-width: 20rem;">
                                        <a href="descripcion.jsp?idlde=<%= lde.getActual().getId() %>"><i class="bi bi-play-fill"></i> Ver Película</a>
                                    </div>

                                </div>

                <%

                            }

                            //3. Identificar su siguiente nodo
                            lde.setActual(lde.getActual().getSiguiente());

                        }

                    }

                %>

                    </div>
                </div>

            </section>



        <%

            if(encontrado == false){

        %>

            <section class="texto-no-encontrado" style="width: 100%">
                <br><p style="font-size: 1.5rem; text-align: center">Lo sentimos no encontramos la película "<%= request.getParameter("b") %>" <a href="./">Ir al Inicio</a> </p>
            </section>

        <%
            }
        %>

    </main>


    <footer class="page-footer wrap-break-word" style="background: #131313">
        <div class="container">
            <div class="row">
                <div class="col l6 s12">
                    <h5 class="white-text">Movies</h5>
                    <p class="grey-text text-lighten-4">Peliculas y series. Plataforma de consulta de películas.</p>
                </div>
                <div class="col l4 offset-l2 s12">
                    <h5 class="white-text footer-dev">Desarrolladores</h5>
                    <ul>
                        <li><a class="grey-text text-lighten-3" href="#!">7690-20-14576 Jeison Roblero</a></li>
                        <li><a class="grey-text text-lighten-3" href="#!">7690-20-26003 Pablo Garcia</a></li>

                    </ul>
                </div>
            </div>
        </div>
        <div class="footer-copyright">
            <div class="container">
                © 2022 Copyright Movies
                <a class="grey-text text-lighten-4 right" href="#!">Más información</a>
            </div>
        </div>
    </footer>

    <!-- Initialize Swiper -->
    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script src="./js/app.js"></script>

    <!-- Materialize Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    <script>
        //Modal agregar peliculas
        document.addEventListener('DOMContentLoaded', function() {
            var elems = document.querySelectorAll('.modal');
            var instances = M.Modal.init(elems);
        });
    </script>
</body>
</html>
