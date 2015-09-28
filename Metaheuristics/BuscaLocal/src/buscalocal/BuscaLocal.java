/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package buscalocal;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.security.*;



/**
 *
 * @author Brais
 */
public class BuscaLocal {
   
    static int N=10, factorial=0;
    static int [][] matriz= new int [N] [N];
    //static int [] cities= new int [N-1];
    //static int [] vecinos=new int[N-1];
    //static int [] mejorVecino=new int[N-1];
    static ArrayList<int[]> v = new ArrayList<int[]>(); 
    //static int [] cities_aux= new int [N-1];
    /**
     * @param args the command line arguments
     * */
  public static int calcularFactorial() {
        int resultado = 1;
        for (int i = 1; i <= N-1; i++) {
            resultado *= i;
        }
        //System.out.println(resultado);
        return resultado;
    }
    
  public static int randInt(int min, int max) {

    // NOTE: Usually this should be a field rather than a method
    // variable so that it is not re-seeded every call.
    Random rand = new Random();

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
}
   public static int distanciaTotal(int [] cities){
       int i=0,total=0,aux=0,aux2=0;
       for(i=0;i<N-1;i++)
       {
        aux=cities[i];
        if(i==0) {
               total=total+matriz[0][aux];
           }
        else {
            aux2=cities[i-1];
            total=total+(matriz[aux2][aux]);
           }
        //System.out.println("\nCity: " + cities[i]);
        //System.out.println("\nEl total es: " + total);
           
       }
       total=total+(matriz[0][aux]);
       return total;
   } 
   
    
   
    public static int [] generacionInicial(){
        int [] cities= new int [N-1];
        //Random rnd = new Random();
        int i=0,aux=0,j=0,band;
        for(i=0;i<N-1;i++)
        {//RANDOM JAVA
         //cities[i]=(int) Math.random();
         band=0;
         while(band==0)
         {
            band=1; 
            aux = (int) randInt(1,N-1);
            for(j=0;j<N-1;j++)
                if(aux==cities[j])
                    band=0;
         }      
         cities[i]=aux;
         //System.out.println(cities[i]);
        }
        return cities;        
    }
    
     public static int [] generacionVecinos(int [] sA){
         int [] vecinos= sA.clone();
        //Random rnd = new Random();
        int pos1=0,pos2=0,i=0;
        //Gardamos as cidades en vecino, despois permutamos
       
        //Genero aliatoriamente 2 numeros do 0-8
        pos1=randInt(0,N-2);
        pos2=randInt(0,N-2);
        while(pos1==pos2)
            pos1=randInt(0,N-2);
        //Intercambiamos
        vecinos[pos1]=sA[pos2];
        vecinos[pos2]=sA[pos1];
        
        /*System.out.println("-------------");
        System.out.println(vecinos[pos1]);
        System.out.println(sA[pos2]);*/
        //Gardamos en vecino intercambiado        
        if(!v.contains(vecinos) && factorial!=calcularFactorial()){//Comprobamos si esta o veciño
             v.add(vecinos);
             factorial=v.size();
             //return distanciaTotal2();
        }
                return vecinos;
    }
    
    public static void devolverSolucion(int [] sA)
    {
     //float distancia=0;
     int i=0;   
     System.out.println("\nLa solucion es: " + Arrays.toString(sA));
     //for(i=0;i<N-1;i++)
       //  System.out.println(sA[i]);
     
     System.out.println("\nLa distancia total es: " + distanciaTotal(sA));  
    }
    
    
     
    public static void main(String[] args) {
        // TODO code application logic here
        
         //Scanner scaner = new Scanner(System.in);
         int i=0;
         int [] sA= new int [N-1];
         int [] mejorVecino=new int[N-1];
         int [] sA_aux=new int[N-1];
         
         
         archivo a = new archivo();
         a.leerArchivo();
         
        
          
         sA=generacionInicial();
         do
         {
           mejorVecino=sA;
           do{
                sA_aux=generacionVecinos(sA);
            }while(!((distanciaTotal(sA_aux)<distanciaTotal(mejorVecino)) || factorial==calcularFactorial()));   
            if(distanciaTotal(sA_aux)<distanciaTotal(sA))
                sA=sA_aux;
            
            System.out.println("Camino SOLUCION ACTUAL:   " + Arrays.toString(sA) + " distancia: " + distanciaTotal(sA));
            System.out.println("Camino SOLUCION AUXILIAR: " + Arrays.toString(sA_aux) + " distancia: " + distanciaTotal(sA_aux));
            System.out.println("Camino SOLUCION MEJOR:    " + Arrays.toString(mejorVecino) + " distancia: " + distanciaTotal(mejorVecino));
            System.out.println("------------------------------------------------------------------------------------------------------------");
         }while(!(distanciaTotal(sA_aux)>=distanciaTotal(mejorVecino)));
         devolverSolucion(sA);
    }
    
    
}
