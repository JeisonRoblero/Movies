package com.proyecto.moviesplay;

import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "CircularServlet", value = "/CircularServlet")
public class CircularServlet extends HttpServlet {

    public static int cantidad = 0;
    public static ListaCircularSimple lc =  new ListaCircularSimple();


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if(request.getParameter("op").equals("add")){

            String idCircular = request.getParameter("idcircular");
            String nombrePelicula = request.getParameter("nombre_pelicula");
            String nombreOriginal = request.getParameter("nombre_original");
            String resenia = request.getParameter("resenia");
            String sinopsis = request.getParameter("sinopsis");
            String imagen = request.getParameter("imagen");
            String trailer = request.getParameter("video");
            String video = request.getParameter("pelicula");

            lc.agregarCircular(idCircular, nombrePelicula, nombreOriginal, resenia, sinopsis, imagen, trailer, video);

            cantidad ++;

            //request.getSession().setAttribute("lc", lc);
            //request.getSession().setAttribute("cantidad", cantidad);
            //request.getRequestDispatcher("index.jsp").forward(request, response);

            response.sendRedirect("./");

        }else if(request.getParameter("op").equals("edit")){

            String idCircular = request.getParameter("idcircular");
            String nombrePeliculaN = request.getParameter("nombre_pelicula_n");
            String nombreOriginalN = request.getParameter("nombre_original_n");
            String reseniaN = request.getParameter("resenia_n");
            String sinopsisN = request.getParameter("sinopsis_n");
            String imagenN = request.getParameter("imagen_n");
            String trailerN = request.getParameter("video_n");
            String videoN = request.getParameter("pelicula_n");

            int cont3 = 0;

            lc.setActual(lc.getPrimero());

            while (cont3 < lc.getCantidad() && lc.getActual()!=null){

                if(idCircular.equals(lc.getActual().getId())){
                    lc.getActual().setNombrePelicula(nombrePeliculaN);
                    lc.getActual().setNombreOriginal(nombreOriginalN);
                    lc.getActual().setResenia(reseniaN);
                    lc.getActual().setSinopsis(sinopsisN);
                    lc.getActual().setImagen(imagenN);
                    lc.getActual().setTrailer(trailerN);
                    lc.getActual().setVideo(videoN);

                    if(request.getParameter("from")!=null && request.getParameter("from").equals("desc")){
                        response.sendRedirect("descripcion.jsp?idc="+lc.getActual().getId());
                    }else {
                        response.sendRedirect("./");
                    }
                }

                //3. Identificar su siguiente nodo
                lc.setActual(lc.getActual().getSiguiente());
                cont3++;
            }

        }

    }


    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String idCircular = request.getParameter("idcircular");

        lc.eliminarCirular(idCircular);

    }

    public void destroy() {
    }
}