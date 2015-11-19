

package es.almerimatik.comerciales;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Date;

/**
 *  Clase que representa a un usuario de la aplicacion comerciales.
 * @author Jose Ucles
 * @version  1.0
 * @since  09/07/2012
 */
public class Usuarios implements es.almerimatik.datos.dao{
    private int _id;
    private String _userName;
    public String nombre;
    public String apellidos;
    private Calendar _fechaNacimiento;
    private Date _ultimoAcceso;
    private String _pass;

    /**
     * @return the _id
     */
    public int getId() {
        return _id;
    }

    /**
     * @return the _userName
     */
    public String getUserName() {
        return _userName;
    }

    /**
     * @return Una <strong>copia</strong> del objeto fecha de nacimiento.
     */
    public Calendar getFechaNacimiento() {
        Calendar nuevo;
        
        if ( this._fechaNacimiento == null ) return null;
        nuevo = Calendar.getInstance();        
        nuevo.setTimeInMillis( this._fechaNacimiento.getTimeInMillis() );
        return nuevo; 
    }

    /**
     * @param fechaNacimiento the _fechaNacimiento to set
     */
    public void setFechaNacimiento(Calendar fechaNacimiento) {
        this._fechaNacimiento = fechaNacimiento;
    }

    /**
     * @return the _ultimoAcceso
     */
    public String getUltimoAcceso() {
        String ulac;
        
        if ( this._ultimoAcceso == null ) return "";
        if ( this._ultimoAcceso.getDate() <= 9 )
            ulac = "0" + this._ultimoAcceso.getDate() + "/";
        else 
            ulac = this._ultimoAcceso.getDate() + "/";
        
        if ( this._ultimoAcceso.getMonth()+1 <=9 )
            ulac += "0" + (this._ultimoAcceso.getMonth()+1) + "/";
        else
            ulac += (this._ultimoAcceso.getMonth()+1) + "/";
        
        ulac += (this._ultimoAcceso.getYear() + 1900);
        
        return ulac;
        
    }
    /**
     * 
     * @return la contraseña codificada con md5.
     */
    public String getPassword(){
        
        return this._pass;
    }
    /**
     * Cambia la contraseña del usuario por otra contraseña en formato md5
     * @param newPass nueva contraseña del usuario.
     */
    public  void setPassword(String newPass){
        MessageDigest md ;
        try {
            md =  MessageDigest.getInstance("MD5");            
            byte[] cPass = md.digest(newPass.getBytes("UTF-8"));
            this._pass = this.toHex(cPass);            
        }
        catch ( Exception e){
            System.err.println("METODO DE CIFRADO NO ENCONTRADO");
            System.exit(1);            
        }        
        
    }
    private String toHex( byte[] datos){
        String res = "";
        char[] car = new String(datos).toCharArray() ;
        
        for(char letra: car){
            res += Integer.toHexString(letra);
        }
        return res;
    }
            
    public boolean validar(String pass){
        MessageDigest md;
        try{
            md = MessageDigest.getInstance("MD5");
            byte[] cPass = md.digest(pass.getBytes("UTF-8"));
            return this.toHex(cPass).equals(this._pass);
        }
        catch (Exception e){
            System.err.println("METODO DE CIFRADO NO ENCONTRADO");
            System.exit(1);
        }
        return false;
    }
    
    public Usuarios( String username , String pass){
        this._id = -1;
        this._userName = username;
        this.setPassword(pass);
        this.nombre = username;
        this.apellidos = username;
        this._fechaNacimiento = null;
        this._ultimoAcceso = null;
    }
    @Override
    public String toString(){
        
        return this._userName;
    }
    @Override
    public boolean equals(Object obj){
        
        if ( obj == null ) return false;
        if ( obj == this ) return true;
        if ( !(obj instanceof Usuarios)) return false;
        Usuarios u = (Usuarios) obj;
        
        return u._userName.equalsIgnoreCase(this._userName);
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 59 * hash + (this._userName != null ? this._userName.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean guardar(Connection cnt) {
        String sql; 
        try {
            if ( cnt.isClosed() ) return false;
        }
        catch(Exception e){ return false;}
        
        if ( this._id == -1){
            sql  = "INSERT INTO usuarios(username,nombre,apellidos,fnac,fu,pass) VALUES (?,?,?,?,?,?)";                         
        } // if this.id == -1
        else{
            sql = "UPDATE usuarios SET username=?,nombre=?,apellidos=?,"
                    + "fnac=?,fu=?,pass=? WHERE id= " + this._id ;                              
        }
        try {
            PreparedStatement pst = cnt.prepareStatement(sql);
            pst.setString(1, this._userName);
            pst.setString(2, this.nombre);
            pst.setString(3, this.apellidos);
            if (this._fechaNacimiento != null) {
                pst.setDate(4, new java.sql.Date(this._fechaNacimiento.getTimeInMillis()));
            } else {
                pst.setNull(4, java.sql.Types.DATE);
            }
            if (this._ultimoAcceso != null) {
                pst.setDate(5, new java.sql.Date(this._ultimoAcceso.getTime()));
            } else {
                pst.setNull(5, java.sql.Types.DATE);
            }

            pst.setString(6, this._pass);

            int numero = pst.executeUpdate();
            return numero == 1;
        } catch (Exception e) {
            return false;
        }
        
    }

    @Override
    public boolean leer(Connection cnt, long clave) {
        
        try{
            if ( cnt.isClosed() ) return false;
            String sql = "SELECT * FROM usuarios WHERE id=" + clave ;
            Statement st = cnt.createStatement();
            ResultSet rs = st.executeQuery(sql);            
            if ( rs.next() ){
                this._id = rs.getInt("id");
                this._userName = rs.getString("username");
                this.nombre = rs.getString("nombre");
                this.apellidos = rs.getString("apellidos");
                this._pass = rs.getString("pass");
                if ( rs.getDate("fnac") != null){
                    this._fechaNacimiento = Calendar.getInstance();
                    this._fechaNacimiento.setTimeInMillis(rs.getDate("fnac").getTime());
                }
                if ( rs.getDate("fu") != null ){
                    this._ultimoAcceso = new Date(rs.getDate("fu").getTime());
                }
                return true;
            }
            return false;
        }
        catch(Exception e){
            return false;
        }
    }
    
    public static Usuarios load(long id, Connection cnt){
        Usuarios usr = new Usuarios("usr", "usr");
        
        if ( usr.leer(cnt,id) )
            return usr;
        else
            return null ;              
    }
    public static Usuarios load(String username, Connection cnt){
    Usuarios usr;
        try{            
            String sql = "SELECT * FROM usuarios WHERE username='" + username +"'" ;
            Statement st = cnt.createStatement();
            ResultSet rs = st.executeQuery(sql);            
            if ( rs.next() ){
                usr = Usuarios.load(rs.getInt("id"), cnt);
                return usr;
            }
            return null;
        }
        catch(Exception e){
            return null;
        }        
    }
    
}
