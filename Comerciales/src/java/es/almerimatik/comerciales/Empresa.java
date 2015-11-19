

package es.almerimatik.comerciales;

import es.almerimatik.datos.Configuracion;
import es.almerimatik.datos.dao;
import es.almerimatik.errores.CifRepetidoException;
import es.almerimatik.errores.cifNoExisteException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;


public class Empresa implements dao {
     private int _id;
     private String _cif;
     private String _nombre;
     private String _direccion;
     private String _provincia;
     private String _poblacion;
     private String _cp;
     private int _tlf;
     private Calendar _fechaAlta;
     private String _contacto;
     private Usuarios _comercial;

    /**
     * @return the _id
     */
    public int getId() {
        return _id;
    }

    /**
     * @return the _cif
     */
    public String getCif() {
        return _cif;
    }

    /**
     * @param cif the _cif to set
     */
    public void setCif(String cif) {
        this._cif = cif;
    }

    /**
     * @return the _nombre
     */
    public String getNombre() {
        return _nombre;
    }

    /**
     * @param nombre the _nombre to set
     */
    public void setNombre(String nombre) {
        this._nombre = nombre;
    }

    /**
     * @return the _direccion
     */
    public String getDireccion() {
        return _direccion;
    }

    /**
     * @param direccion the _direccion to set
     */
    public void setDireccion(String direccion) {
        this._direccion = direccion;
    }

    /**
     * @return the _provincia
     */
    public String getProvincia() {
        return _provincia;
    }

    /**
     * @param provincia the _provincia to set
     */
    public void setProvincia(String provincia) {
        this._provincia = provincia;
    }

    /**
     * @return the _poblacion
     */
    public String getPoblacion() {
        return _poblacion;
    }

    /**
     * @param poblacion the _poblacion to set
     */
    public void setPoblacion(String poblacion) {
        this._poblacion = poblacion;
    }

    /**
     * @return the _cp
     */
    public String getCp() {
        return _cp;
    }

    /**
     * @param cp the _cp to set
     */
    public void setCp(String cp) {
        this._cp = cp;
    }

    /**
     * @return the _tlf
     */
    public int getTlf() {
        return _tlf;
    }

    /**
     * @param tlf the _tlf to set
     */
    public void setTlf(int tlf) {
        this._tlf = tlf;
    }

    /**
     * @return the _fechaAlta
     */
    public Calendar getFechaAlta() {
        return _fechaAlta;
    }

    /**
     * @param fechaAlta the _fechaAlta to set
     */
    public void setFechaAlta(Calendar fechaAlta) {
        this._fechaAlta = fechaAlta;
    }

    /**
     * @return the _contacto
     */
    public String getContacto() {
        return _contacto;
    }

    /**
     * @param contacto the _contacto to set
     */
    public void setContacto(String contacto) {
        this._contacto = contacto;
    }

    /**
     * @return the _comercial
     */
    public Usuarios getComercial() {
        return _comercial;
    }

    /**
     * @param comercial the _comercial to set
     */
    public void setComercial(Usuarios comercial) {
        this._comercial = comercial;
    }
    public Empresa(){
        this._id = -1;
        this._nombre = "Nueva Empresa";
        this._cif = "" ;
        this._contacto = "";
        this._cp = "" ;
        this._direccion = "" ;
        this._fechaAlta = Calendar.getInstance();
        this._tlf = 0;
        this._provincia = "" ;
        this._poblacion = "" ;
        this._comercial = null ;
    }
    public Empresa(String nombre, String cif, String direccion ,String provincia,
                   String poblacion, String contacto, String cp, 
                   int tlf, Usuarios com ){
        this._id = -1;
        this._nombre = nombre;
        this._cif = cif ;
        this._contacto = contacto;
        this._cp = cp ;
        this._direccion = direccion ;
        this._fechaAlta = Calendar.getInstance();
        this._tlf = tlf;
        this._provincia = provincia ;
        this._poblacion = poblacion ;
        this._comercial = com  ;    
    }
    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if ( obj == this ) return true;
        
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Empresa other = (Empresa) obj;
        if ((this._cif == null) ? (other._cif != null) : !this._cif.equals(other._cif)) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 29 * hash + (this._cif != null ? this._cif.hashCode() : 0);
        return hash;
    }
    @Override
    public String toString() {
        return "Empresa{" + "_cif=" + _cif + '}';
    }
    /**
     * 
     * @param cnt Conexión abierta con la base de datos.
     * @return  false si el cif escrito en el objeto se puede utilizar(no esta 
     * repetido) antes de guadar en la base de datos.
     * Si el cif no se puede utilizar(esta repetido) devolverá true.
     */
    private boolean existeCIF(Connection cnt){
        
        if ( this._cif == null || this._cif.isEmpty() ) return false;
        String sql = "SELECT * FROM empresas WHERE cif='" + this._cif + "'";
        try{
            Statement st = cnt.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if ( rs.next() == false ) return false;
            if ( this._id == rs.getInt("id")) return false;
            return true;
        }
        catch(Exception e){
            return false;
        }

        
    }
    public void guardar(Configuracion conf) throws Exception, CifRepetidoException{
        
        Connection cnt = conf.conectar();
        String sql ;
        if ( this._id == -1 ){
            sql = "INSERT INTO empresas (cif,nombre,direccion,provincia,poblacion,cp," +
                   "tlf,comercial,falta,contacto) VALUES (?,?,?,?,?,?,?,?,?,?)";
        }
        else{
            sql = "UPDATE empresas SET cif=?,nombre=?,direccion=?,provincia=?,poblacion=?," +
                    "cp=?,tlf=?,comercial=?,falta=?,contacto=? WHERE id=" + this._id;
        }
        if ( this.existeCIF(cnt) ) throw new CifRepetidoException(this._cif);
        
        PreparedStatement pst = cnt.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);        
        pst.setString(1, this._cif);
        pst.setString(2, this._nombre);
        pst.setString(3, this._direccion);
        pst.setString(4, this._provincia);
        pst.setString(5, this._poblacion);
        pst.setString(6, this._cp);
        pst.setInt(7, this._tlf);
        pst.setInt(8, this._comercial.getId());
        if ( this._fechaAlta != null)
            pst.setDate(9, new java.sql.Date(this._fechaAlta.getTimeInMillis()));
        else {
            Date fecha = new Date();
            pst.setDate(9, new java.sql.Date(fecha.getTime()));
        }
        pst.setString(10, this._contacto);        
        pst.executeUpdate();
        if ( this._id == -1 ){
            ResultSet rs = pst.getGeneratedKeys();
            if ( rs.next()){
                this._id = rs.getInt(1);
            }
        }
        pst.close();                
    }
    @Override
    public boolean guardar(Connection cnt) {
        
        
        try{
            if ( cnt.isClosed() ) return false ;
            this.guardar(new Configuracion() );
            return true;
        }
        catch(Exception e){
            return false;
        }
    }

    public void leer(String cif) throws Exception{
                
        Configuracion conf = new Configuracion();
        Connection cnt = conf.conectar();
        Statement st = cnt.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM empresas WHERE cif='" + cif +"'");
        if ( rs.next() == false ){
            throw new cifNoExisteException(cif);
        }
        this.leer(cnt, rs.getInt("id"));
    }
    @Override
    public boolean leer(Connection cnt, long clave) {
        try{
            if ( cnt.isClosed() ) return false;
            String sql = "SELECT * FROM empresas WHERE id=" + clave;
            Statement st = cnt.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if ( rs.next() == false ) return false;
            this._id = rs.getInt("id");
            this._cif = rs.getString("cif");
            this._contacto = rs.getString("contacto");
            this._cp = rs.getString("cp");
            this._direccion = rs.getString("direccion");
            this._nombre = rs.getString("nombre");
            this._poblacion = rs.getString("poblacion");
            this._provincia = rs.getString("provincia");
            this._tlf = rs.getInt("tlf");
            
            this._fechaAlta = Calendar.getInstance();
            this._fechaAlta.setTimeInMillis(rs.getDate("falta").getTime());
            
            this._comercial = new Usuarios("", "");
            this._comercial.leer(cnt, rs.getInt("comercial"));
            
            return true;
        }
        catch (Exception e){
            return false;
        }
    }
    
    public static ArrayList<Empresa> listado(int pagina, int tamanio) throws Exception {
        ArrayList<Empresa> lista = new ArrayList();
        String sql = "SELECT * FROM empresas LIMIT " + pagina*tamanio + ", " + tamanio ;
        
        Connection cnt = (new Configuracion()).conectar() ;
        Statement st = cnt.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while ( rs.next()){
            Empresa e = new Empresa();
            e.leer(cnt, rs.getInt("id"));
            lista.add(e);            
        }
        
        return lista;
    }
    public boolean borrar( Configuracion conf){
        
        try {
            Connection cnt = conf.conectar();
            if ( this._id == -1 ) return false;
            Statement st = cnt.createStatement();
            st.executeUpdate("DELETE FROM empresas WHERE id=" + this._id );
            return true;
        }
        catch(Exception e){ return false;}
        
    }
    
     
}
