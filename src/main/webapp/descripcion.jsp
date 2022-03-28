<%@ page import="static com.proyecto.moviesplay.CircularServlet.lc" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="static com.proyecto.moviesplay.DoblementeEnlazadaServlet.lde" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
    <title>Descripción | Movies </title>

    <!--=== Color de barra superior ====-->
    <meta name="theme-color" content="#131313"/>

    <!-- Inicio Meta Etiquetas para Redes Sociales y SEO -->
    <meta property="og:image" itemprop="image" content="images/favicon.png"/>
    <meta property="og:site_name" content="Movies | Peliculas y Series"/>
    <meta property="og:title" content="Movies | Peliculas y Series"/>
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


    <style>
      .back {
        font-size: 35px;
      }

      @media screen and (max-width: 768px){
        .back {
          font-size: 30px;
        }
      }
    </style>
</head>
<body>

    <header>
        <nav style="background-color: transparent; box-shadow: none">
            <div><span><a href="javascript:history.back()" class="btn waves-effect" style="background: transparent;"><i class="bi bi-arrow-left back"></i></a></span></div>
        </nav>
    </header>

    <main>

        <!-- ------------ -->
        <!-- De Cartelera -->
        <!-- ------------ -->

        <%

            Boolean encontrado = false;
            if(request.getParameter("idc")!=null){
        %>
                <section class="cartelera">
                    <%
                        int cont = 0;
                        String videoTrailer = "";

                        if(lc.getCantidad() > 0){

                            //1. ubicar el ultimo elemento de la lista
                            lc.setActual(lc.getUltimo());

                            while (cont < lc.getCantidad() && lc.getActual()!=null){

                                if(lc.getActual().getId().equals(request.getParameter("idc"))){

                                    encontrado = true;
                                    if(lc.getActual().getTrailer()!=null) {

                                        if (lc.getActual().getTrailer().contains("watch?v=")) {
                                            String separador = Pattern.quote("watch?v=");
                                            String[] videoParts = lc.getActual().getTrailer().split(separador);
                                            videoTrailer = videoParts[0] + "embed/" + videoParts[1] + "?playlist=" + videoParts[1] + "&autoplay=1&mute=1&loop=1&controls=0&rel=0";
                                        } else if(lc.getActual().getTrailer().contains("embed/")) {
                                            String separador2 = Pattern.quote("embed/");
                                            String[] videoParts2 = lc.getActual().getTrailer().split(separador2);
                                            videoTrailer = videoParts2[0] + "embed/" + videoParts2[1] + "?playlist=" + videoParts2[1] + "&autoplay=1&mute=1&loop=1&controls=0&rel=0";
                                        }

                                    }else{
                                        videoTrailer = lc.getActual().getImagen();
                                    }

                    %>

                    <!--trailer video-->
                    <div class="desktop-pelicula-fondo trailer-desc">
                        <iframe class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(3.1)" src="<%= videoTrailer %>">
                        </iframe>
                    </div>

                    <div class="movil-pelicula-fondo">
                        <img class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(1.1)" src="<%= lc.getActual().getImagen() %>"/>
                    </div>

                    <div class="capa-sombra-desc wrap-break-word">
                        <h4 style="font-weight:700; margin-bottom: -20px; font-size: 2rem; padding: 20px"><%= lc.getActual().getNombrePelicula() %></h4>
                    </div>

                    <section class="descripcion-pelicula">
                        <div class="contenedor-portada-titulos">
                            <div class="img-portada">
                                <img src="<%= lc.getActual().getImagen() %>" alt="Imagen de <%= lc.getActual().getNombrePelicula() %>">
                            </div>

                            <div class="contenedor-titulos wrap-break-word">
                                  <span class="nombre_pelicula">
                                    <%= lc.getActual().getNombrePelicula() %>
                                  </span>

                                <span class="nombre_original">
                                    <%= lc.getActual().getNombreOriginal() %>
                                  </span>

                                <span class="resenia">
                                    <i class="bi bi-star"></i> <%= lc.getActual().getResenia() %>
                                  </span>
                            </div>
                        </div>

                        <div class="contenedor-sinopsis">
                            <p style="display: block"><%= lc.getActual().getSinopsis() %></p><br>
                        </div>

                        <%
                            if(lc.getActual().getVideo()!=null){
                        %>

                        <div class="contenedor-pelicula" >
                            <IFRAME SRC="<%= lc.getActual().getVideo() %>" class="contenedor-pelicula" FRAMEBORDER=0 MARGINWIDTH=0 MARGINHEIGHT=0 SCROLLING=NO WIDTH=100% allowfullscreen></IFRAME>
                        </div><br>

                        <%
                            }

                            if(session.getAttribute("idadmin")!=null){
                        %>

                        <div class="botones-admin2">

                            <!-- Modal Trigger -->
                            <a class="waves-effect waves-light btn modal-trigger" title="Editar Película" href="#modificar<%= lc.getActual().getId() %>">
                                <i class="bi bi-pencil-square"></i>
                            </a>

                            <a class="btn waves-effect waves-light eliminar-btn modal-trigger" title="Eliminar" href="#eliminar<%= lc.getActual().getId() %>" style="background: red">
                                <i class="bi bi-trash3-fill"></i>
                            </a>

                            <!-- Modal Structure Edit -->
                            <div id="modificar<%= lc.getActual().getId() %>" class="modal bottom-sheet" style="background: #131313">
                                <div class="modal-content">
                                    <h4 class="titulo-form" style="background: linear-gradient(90deg, #1CB5E0 0%, #000851 100%); padding: 15px; border-radius: 1rem; text-align: center">
                                        Modificar Detalles de la Película
                                    </h4><br>
                                    <p>Puedes editar a continuación todos los detalles de la película.</p><br>

                                    <div class="row">
                                        <form class="col s12" action="CircularServlet" method="post">
                                            <div class="row">

                                                <input type="hidden" name="op" value="edit" />
                                                <input type="hidden" name="from" value="desc" />
                                                <input type="hidden" name="idcircular" value="<%= lc.getActual().getId() %>" />

                                                <div class="input-field col s6">
                                                    <input id="nombre_pelicula" name="nombre_pelicula_n" type="text" class="validate" required value="<%= lc.getActual().getNombrePelicula() %>"/>
                                                    <label for="nombre_pelicula">Nombre</label>
                                                </div>

                                                <div class="input-field col s6">
                                                    <input id="nombre_original" name="nombre_original_n" type="text" class="validate" required value="<%= lc.getActual().getNombreOriginal() %>"/>
                                                    <label for="nombre_original">Nombre original</label>
                                                </div>

                                                <div class="input-field col s12" style="display: flex; justify-content:center;">
                                                    <p class="range-field">
                                                        <label for="resenia">Indique la reseña. De 1 a 5 estrellas</label>
                                                        <input type="range" id="resenia" name="resenia_n" min="0" max="5" step="0.5" required value="<%= lc.getActual().getResenia() %>"/>
                                                    </p>
                                                </div>

                                                <div class="input-field col s12">
                                                    <textarea id="sinopsis" name="sinopsis_n" class="materialize-textarea" style="color:#fff" required><%= lc.getActual().getSinopsis() %></textarea>
                                                    <label for="sinopsis">Sinopsis (Descripción)</label>
                                                </div>

                                                <div class="input-field col s6">
                                                    <input id="imagen" name="imagen_n" type="text" class="validate" title="Enlace de imagen" required value="<%= lc.getActual().getImagen() %>"/>
                                                    <label for="imagen" title="Enlace de imagen">Imagen</label>
                                                </div>

                                                <div class="input-field col s6">
                                                    <input id="video" name="video_n" type="text" class="validate" title="Enlace de video" value="<%= lc.getActual().getTrailer() %>"/>
                                                    <label for="video" title="Enlace de video">Video trailer</label>
                                                </div>

                                                <div class="input-field col s12">
                                                    <input id="pelicula" name="pelicula_n" type="text" class="validate" title="Enlace de la película completa" value="<%= lc.getActual().getVideo() %>"/>
                                                    <label for="pelicula" title="Enlace de la película completa">Película completa</label>
                                                </div>

                                            </div>

                                            <div class="input-field col s12" style="display: flex; justify-content:center;">
                                                <button class="btn waves-effect waves-light" type="submit" style="background: #E50914;">
                                                    Modificar Película
                                                </button>
                                            </div>

                                        </form>


                                    </div>
                                </div>
                            </div>

                            <!-- Modal Structure Delete -->
                            <div id="eliminar<%= lc.getActual().getId() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                                <div class="modal-content">
                                    <h4 style="text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Película <%= lc.getActual().getNombrePelicula() %> de la Cartelera </h4> <br>
                                    <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar la película <%= lc.getActual().getNombreOriginal() %> de la cartelera?</h6>
                                </div>
                                <div class="modal-footer" style="background: #131313">
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                                    <a href="#!" class="waves-effect waves-green btn-flat" onclick="eliminarDeCircular(<%= lc.getActual().getId() %>)" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                                </div>
                            </div>

                        </div>

                        <%
                            }
                        %>

                    </section>

                    <%
                                }

                                //3. Identificar su siguiente nodo
                                lc.setActual(lc.getActual().getSiguiente());
                                cont++;

                            }

                        }

                    %>
                </section>

        <%
            }
        %>

        <!-- ------------ -->
        <!-- De Populares -->
        <!-- ------------ -->

        <%
            if(request.getParameter("idlde")!=null){
        %>

                <section class="populares">

                    <%
                        String videoTrailer2 = "";

                        if(lde.getCantidad() > 0){

                            //1. ubicar el primer elemento de la lista
                            lde.setActual(lde.getPrimero());

                            while (lde.getActual()!=null){

                                if(lde.getActual().getId().equals(request.getParameter("idlde"))){

                                    encontrado = true;
                                    if(lde.getActual().getTrailer()!=null) {

                                        if (lde.getActual().getTrailer().contains("watch?v=")) {
                                            String separador = Pattern.quote("watch?v=");
                                            String[] videoParts = lde.getActual().getTrailer().split(separador);
                                            videoTrailer2 = videoParts[0] + "embed/" + videoParts[1] + "?playlist=" + videoParts[1] + "&autoplay=1&mute=1&loop=1&controls=0&rel=0";
                                        } else if(lde.getActual().getTrailer().contains("embed/")) {
                                            String separador2 = Pattern.quote("embed/");
                                            String[] videoParts2 = lde.getActual().getTrailer().split(separador2);
                                            videoTrailer2 = videoParts2[0] + "embed/" + videoParts2[1] + "?playlist=" + videoParts2[1] + "&autoplay=1&mute=1&loop=1&controls=0&rel=0";
                                        }

                                    }else{
                                        videoTrailer2 = lde.getActual().getImagen();
                                    }

                    %>

                    <!--trailer video-->
                    <div class="desktop-pelicula-fondo trailer-desc">
                        <iframe class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(3.1)" src="<%= videoTrailer2 %>">
                        </iframe>
                    </div>

                    <div class="movil-pelicula-fondo">
                        <img class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(1.1)" src="<%= lde.getActual().getImagen() %>"/>
                    </div>

                    <div class="capa-sombra-desc">
                        <h4 style="font-weight:700; margin-bottom: -20px; font-size: 2rem; padding: 20px"><%= lde.getActual().getNombrePelicula() %></h4>
                    </div>

                    <section class="descripcion-pelicula">
                        <div class="contenedor-portada-titulos">
                            <div class="img-portada">
                                <img src="<%= lde.getActual().getImagen() %>" alt="Imagen de <%= lde.getActual().getNombrePelicula() %>">
                            </div>

                            <div class="contenedor-titulos">
                                 <span class="nombre_pelicula">
                                    <%= lde.getActual().getNombrePelicula() %>
                                 </span>

                                <span class="nombre_original">
                                    <%= lde.getActual().getNombreOriginal() %>
                                </span>

                                <span class="resenia">
                                    <i class="bi bi-star"></i> <%= lde.getActual().getResenia() %>
                                  </span>
                            </div>
                        </div>

                        <div class="contenedor-sinopsis">
                            <p><%= lde.getActual().getSinopsis() %></p><br>
                        </div>

                        <%
                            if(lde.getActual().getVideo()!=null){
                        %>

                        <div class="contenedor-pelicula" >
                            <IFRAME SRC="<%= lde.getActual().getVideo() %>" class="contenedor-pelicula" FRAMEBORDER=0 MARGINWIDTH=0 MARGINHEIGHT=0 SCROLLING=NO WIDTH=100% allowfullscreen></IFRAME>
                        </div><br>

                        <%
                            }

                            if(session.getAttribute("idadmin")!=null){
                        %>

                        <div class="botones-admin2">

                            <!-- Modal Trigger -->
                            <a class="waves-effect waves-light btn modal-trigger" title="Editar Película" href="#modificar<%= lde.getActual().getId() %>">
                                <i class="bi bi-pencil-square"></i>
                            </a>

                            <a class="btn waves-effect waves-light eliminar-btn modal-trigger" title="Eliminar" href="#eliminar<%= lde.getActual().getId() %>" style="background: red">
                                <i class="bi bi-trash3-fill"></i>
                            </a>

                            <!-- Modal Structure Edit -->
                            <div id="modificar<%= lde.getActual().getId() %>" class="modal bottom-sheet" style="background: #131313">
                                <div class="modal-content">
                                    <h4 class="titulo-form" style="background: linear-gradient(90deg, #1CB5E0 0%, #000851 100%); padding: 15px; border-radius: 1rem; text-align: center">
                                        Modificar Detalles de la Película
                                    </h4><br>
                                    <p>Puedes editar a continuación todos los detalles de la película.</p><br>

                                    <div class="row">
                                        <form class="col s12" action="DoblementeEnlazadaServlet" method="post">
                                            <div class="row">

                                                <input type="hidden" name="op" value="edit" />
                                                <input type="hidden" name="from" value="desc" />
                                                <input type="hidden" name="idlde" value="<%= lde.getActual().getId() %>" />

                                                <div class="input-field col s6">
                                                    <input id="nombre_pelicula" name="nombre_pelicula_n" type="text" class="validate" required value="<%= lde.getActual().getNombrePelicula() %>"/>
                                                    <label for="nombre_pelicula">Nombre</label>
                                                </div>

                                                <div class="input-field col s6">
                                                    <input id="nombre_original" name="nombre_original_n" type="text" class="validate" required value="<%= lde.getActual().getNombreOriginal() %>"/>
                                                    <label for="nombre_original">Nombre original</label>
                                                </div>

                                                <div class="input-field col s12" style="display: flex; justify-content:center;">
                                                    <p class="range-field">
                                                        <label for="resenia">Indique la reseña. De 1 a 5 estrellas</label>
                                                        <input type="range" id="resenia" name="resenia_n" min="0" max="5" step="0.5" required value="<%= lde.getActual().getResenia() %>"/>
                                                    </p>
                                                </div>

                                                <div class="input-field col s12">
                                                    <textarea id="sinopsis" name="sinopsis_n" class="materialize-textarea" style="color:#fff" required><%= lde.getActual().getSinopsis() %></textarea>
                                                    <label for="sinopsis">Sinopsis (Descripción)</label>
                                                </div>

                                                <div class="input-field col s6">
                                                    <input id="imagen" name="imagen_n" type="text" class="validate" title="Enlace de imagen" required value="<%= lde.getActual().getImagen() %>"/>
                                                    <label for="imagen" title="Enlace de imagen">Imagen</label>
                                                </div>

                                                <div class="input-field col s6">
                                                    <input id="video" name="video_n" type="text" class="validate" title="Enlace de video" value="<%= lde.getActual().getTrailer() %>"/>
                                                    <label for="video" title="Enlace de video">Video trailer</label>
                                                </div>

                                                <div class="input-field col s12">
                                                    <input id="pelicula" name="pelicula_n" type="text" class="validate" title="Enlace de la película completa" value="<%= lde.getActual().getVideo() %>"/>
                                                    <label for="pelicula" title="Enlace de la película completa">Película completa</label>
                                                </div>

                                            </div>

                                            <div class="input-field col s12" style="display: flex; justify-content:center;">
                                                <button class="btn waves-effect waves-light" type="submit" style="background: #E50914;">
                                                    Modificar Película
                                                </button>
                                            </div>

                                        </form>


                                    </div>
                                </div>
                            </div>

                            <!-- Modal Structure Delete -->
                            <div id="eliminar<%= lde.getActual().getId() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                                <div class="modal-content">
                                    <h4 style="text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Película <%= lde.getActual().getNombrePelicula() %> de la Cartelera </h4> <br>
                                    <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar la película <%= lde.getActual().getNombreOriginal() %> de la cartelera?</h6>
                                </div>
                                <div class="modal-footer" style="background: #131313">
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                                    <a href="#!" class="waves-effect waves-green btn-flat" onclick="eliminarDeLde(<%= lde.getActual().getId() %>)" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                                </div>
                            </div>

                        </div>

                        <%
                            }
                        %>

                    </section>

                    <%
                                }

                                //3. Identificar su siguiente nodo
                                lde.setActual(lde.getActual().getSiguiente());

                            }

                        }

                    %>

                </section>

        <%
            }
        %>

        <%
            if(encontrado == false){
                response.sendRedirect("./");
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
                <h5 class="white-text">Desarrolladores</h5>
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