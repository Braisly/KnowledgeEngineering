/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package buscalocal;
import java.io.*;
import java.util.*;
import java.lang.*;

/**
 *
 * @author Brais
 */
public class archivo {
  
   public void leerArchivo() {
      File archivo = null;
      FileReader fr = null;
      BufferedReader br = null;
      String linea = null;
      int i=0,j=0;
      //Scanner entrada=null;// se declara e inicializa una instancia  de la clase Scanner.
   
      try {
         // Apertura del fichero y creacion de BufferedReader para poder
         // hacer una lectura comoda (disponer del metodo readLine()).
         archivo = new File ("distancias_10.txt");
         fr = new FileReader (archivo);
         br = new BufferedReader(fr);
 
         // Lectura del fichero
        //new Scanner(System.in)
      
       while((linea=br.readLine())!=null)
       {//Variables columnas
        j++;
        StringTokenizer st = new StringTokenizer(linea);
        for(i=0;i<j;i++)
        {
         if(st.hasMoreTokens()){
          // matriz[i][j]=5;
        BuscaLocal.matriz[i][j]= Integer.parseInt(st.nextToken());
        BuscaLocal.matriz[j][i]= BuscaLocal.matriz[i][j];
        //System.out.println(matriz[i][j]);
        //System.in.read(); 
        }
         //System.out.println(linea);
         
        }

            
        //System.out.println(linea);
       }
      }
      catch(Exception e){
         e.printStackTrace();
      }finally{
         // En el finally cerramos el fichero, para asegurarnos
         // que se cierra tanto si todo va bien como si salta 
         // una excepcion.
         try{                    
            if( null != fr ){   
               fr.close();     
            }                  
         }catch (Exception e2){ 
            e2.printStackTrace();
         }
      }
   }
}
   
