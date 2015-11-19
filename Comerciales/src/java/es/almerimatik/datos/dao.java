
package es.almerimatik.datos;

/**
 *
 * @author programacion
 */
public interface dao {
    
    public boolean guardar(java.sql.Connection cnt);
    public boolean leer(java.sql.Connection cnt , long clave);
}
