/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package buscaTabu;
import java.io.*;
import java.util.*;
import java.lang.*;

/**
 *
 * @author Brais
 */
public class archivo {
  
   public void leerArchivo1() {
      File archivo = null;
      FileReader fr = null;
      BufferedReader br = null;
      String linea = null;
      String [] separacion = null;
      int i=0,j=1;
      //Scanner entrada=null;// se declara e inicializa una instancia  de la clase Scanner.
   
      
      int band=0;

      
      try {
         // Apertura del fichero y creacion de BufferedReader para poder
         // hacer una lectura comoda (disponer del metodo readLine()).
         archivo = new File ("distancias_100ciudades.txt");
         fr = new FileReader (archivo);
         br = new BufferedReader(fr);
 

       while((linea=br.readLine())!=null)
       {//Variables columnas
           
             separacion = linea.split("\t");
            
            for(i=0;i< separacion.length;i++)
            {
                  //System.out.println(separacion[i]);
        BuscaTabu.matriz[i][j]= Integer.parseInt(separacion[i]);
       // System.out.println(BuscaTabu.matriz[i][j]);
        BuscaTabu.matriz[j][i]= BuscaTabu.matriz[i][j];   
                
                
            }
            j++;
           
       }
      }
      catch(Exception e){
         e.printStackTrace();
      }finally{
         try{                    
            if( null != fr ){   
               fr.close();     
            }                  
         }catch (Exception e2){ 
            e2.printStackTrace();
         }
      }
   }
   
   
   
   
      public void leerArchivo2() {
      File archivo = null;
      FileReader fr = null;
      BufferedReader br = null;
      String linea = null;
      int i=0,j=0;
      //Scanner entrada=null;// se declara e inicializa una instancia  de la clase Scanner.
   
      try {
         // Apertura del fichero y creacion de BufferedReader para poder
         // hacer una lectura comoda (disponer del metodo readLine()).
         archivo = new File ("ALEATORIOS_TS.txt");
         fr = new FileReader (archivo);
         br = new BufferedReader(fr);
 
         // Lectura del fichero
        //new Scanner(System.in)
      
       while((linea=br.readLine())!=null)
       {//Variables columnas
        //StringTokenizer st = new StringTokenizer(linea);
        BuscaTabu.lectura[i]= Float.parseFloat(linea);
               // System.out.println(linea);

        //System.out.println("\n Numero" + BuscaLocal.lectura[i]);
        i++;
       }
      }
      catch(Exception e){
         e.printStackTrace();
      }finally{
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
   
