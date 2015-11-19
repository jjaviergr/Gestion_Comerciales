
package es.almerimatik.errores;

public class cifNoExisteException extends Exception {
    
    private String cif;
    
    public cifNoExisteException(String cif) {
        super("El CIF NO EXISTE EN LA BASE DE DATOS.");
        this.cif = cif;
    }

    /**
     * @return the cif
     */
    public String getCif() {
        return cif;
    }
    
}
