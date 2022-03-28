package com.proyecto.moviesplay;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DoblementeEnlazadaServlet", value = "/DoblementeEnlazadaServlet")
public class DoblementeEnlazadaServlet extends HttpServlet {

    public static ListaDoblementeEnlazada lde = new ListaDoblementeEnlazada();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if(request.getParameter("op").equals("add")){

            String id = request.getParameter("idlde");
            String nombrePelicula = request.getParameter("nombre_pelicula");
            String nombreOriginal = request.getParameter("nombre_original");
            String resenia = request.getParameter("resenia");
            String sinopsis = request.getParameter("sinopsis");
            String imagen = request.getParameter("imagen");
            String trailer = request.getParameter("video");
            String video = request.getParameter("pelicula");

            lde.agregarDoblementeEnlazada(id, nombrePelicula, nombreOriginal, resenia, sinopsis, imagen, trailer, video);

            response.sendRedirect("./");

        }else if(request.getParameter("op").equals("edit")){

            String id = request.getParameter("idlde");
            String nombrePeliculaN = request.getParameter("nombre_pelicula_n");
            String nombreOriginalN = request.getParameter("nombre_original_n");
            String reseniaN = request.getParameter("resenia_n");
            String sinopsisN = request.getParameter("sinopsis_n");
            String imagenN = request.getParameter("imagen_n");
            String trailerN = request.getParameter("video_n");
            String videoN = request.getParameter("pelicula_n");

            lde.setActual(lde.getPrimero());

            while (lde.getActual()!=null){

                if(id.equals(lde.getActual().getId())){
                    lde.getActual().setNombrePelicula(nombrePeliculaN);
                    lde.getActual().setNombreOriginal(nombreOriginalN);
                    lde.getActual().setResenia(reseniaN);
                    lde.getActual().setSinopsis(sinopsisN);
                    lde.getActual().setImagen(imagenN);
                    lde.getActual().setTrailer(trailerN);
                    lde.getActual().setVideo(videoN);

                    if(request.getParameter("from")!=null && request.getParameter("from").equals("desc")){
                        response.sendRedirect("descripcion.jsp?idlde="+lde.getActual().getId());
                    }else {
                        response.sendRedirect("./");
                    }
                }

                //3. Identificar su siguiente nodo
                lde.setActual(lde.getActual().getSiguiente());
            }
        }
    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("idlde");

        lde.eliminarDoblementeEnlazado(id);

    }

    public void destroy() {
    }
}
