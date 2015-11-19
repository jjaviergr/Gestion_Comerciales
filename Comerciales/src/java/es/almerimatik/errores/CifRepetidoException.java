    
package es.almerimatik.errores;

import es.almerimatik.comerciales.Empresa;


public class CifRepetidoException extends Exception {

    private Empresa repetido;
    /**
     * Creates a new instance of
     * <code>CifRepetidoException</code> without detail message.
     */
    public CifRepetidoException(String cif) {
        super("El CIF se encuentra utilizado por otra empresa.");
        this.repetido = new Empresa();
        try{
            this.repetido.leer(cif);
        }
        catch (Exception e){
            this.repetido = null;
        }
    }

    /**
     * @return the repetido
     */
    public Empresa getRepetido() {
        return repetido;
    }


}
