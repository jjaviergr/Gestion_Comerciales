

package es.almerimatik.datos;

import java.sql.Connection;
import java.sql.DriverManager;

public class Configuracion {
    private final String bd = "comercial";
    private final String user = "comercial";
    private final String pass = "aaa111...";

    public Configuracion() {
    }
    
    
    public Connection conectar() throws Exception{
        Connection cnt;
        
            Class.forName("com.mysql.jdbc.Driver");
            cnt = DriverManager.getConnection("jdbc:mysql://localhost/" + this.bd, 
                this.user, this.pass);
            return cnt;
    }
}
