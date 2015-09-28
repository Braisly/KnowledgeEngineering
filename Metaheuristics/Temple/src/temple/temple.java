/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package temple;

import java.io.*;
import java.lang.*;
import java.util.*;

/**
 *
 * @author Brais
 */
public class temple {


    static int N = 100, band = 0, cont = 0;
    static int[][] matriz = new int[N][N];
    static float[] lectura = new float[30103];
    //static ArrayList<int[]> v = new ArrayList<int[]>(); 
    static ArrayList<ArrayList<Integer>> listaTabu = new ArrayList<ArrayList<Integer>>();
    static ArrayList<Integer> posicionesConsideradas = new ArrayList<Integer>();
    static Random aleatorio = new Random(System.currentTimeMillis());

    /**
     * @param args the command line arguments
     *
     */
    
    
    public static int randInt(int min, int max) {

        // NOTE: Usually this should be a field rather than a method
        // variable so that it is not re-seeded every call.
        Random rand = new Random();

        // nextInt is normally exclusive of the top value,
        // so add 1 to make it inclusive
        int randomNum = rand.nextInt((max - min) + 1) + min;

        return randomNum;
    }

    public static int distanciaTotal(int[] cities) {
        int i = 0, total = 0, aux = 0, aux2 = 0;
        for (i = 0; i < N - 1; i++) {
            aux = cities[i];
            if (i == 0) {
                total = total + matriz[0][aux];
            } else {
                aux2 = cities[i - 1];
                total = total + (matriz[aux2][aux]);
            }
            //System.out.println("\nCity: " + cities[i]);
            //System.out.println("\nEl total es: " + total);

        }
        total = total + (matriz[0][aux]);
        return total;
    }


    public static int voraz(int ciudad, int[] repetidas) {
        int i = 1, j = 0, aux = 0, city = 0, bander = 0;
        float distancia = 0, distanciaMinima = 0;
        do {
            bander = 0;
            if (i == ciudad) {
                if (ciudad != 99) {
                    distanciaMinima = matriz[ciudad][i + 1];
                    city = i + 1;
                } else {
                    distanciaMinima = matriz[ciudad][i - 1];
                    city = i - 1;
                }
            } else {
                distanciaMinima = matriz[ciudad][i];
                city = i;
            }
            for (j = 0; j < N - 1; j++) {
                if (repetidas[j] == city) {
                    bander = 1;
                }
            }
            i++;
        } while (bander == 1);



        for (i = 1; i < N; i++) {
            distancia = matriz[ciudad][i];
            aux = i;
            if (distancia < distanciaMinima) {
                if (!((i == ciudad))) {
                    for (j = 0; j < N - 1; j++) {
                        if (repetidas[j] == aux) {
                            bander = 1;
                        }
                    }
                    if (bander == 0) {
                        city = aux;
                        distanciaMinima = distancia;
                    }
                    bander = 0;
                }
            }
        }
        //System.out.println(matriz[40][82]);
        return city;

    }

    public static int[] generacionInicial() {
        int[] cities = new int[N - 1];
        int i = 0, aux = 0, j = 0;
        //cities[0]=0;
        for (i = 0; i < N - 1; i++) {
            aux = voraz(aux, cities);
            cities[i] = aux;
            //System.out.println(cities[i]);
        }
        return cities;
    }

    //Comproba si xa está na lista Tabú
    public static int siTabu(int aux, int[] cities) {

        int[] vecinos = cities.clone();
        ArrayList<Integer> auxTerna = new ArrayList<Integer>();
        int i = 0;
        if (aux == 0) {
            auxTerna.add(0);
            auxTerna.add(vecinos[(aux)]);
            auxTerna.add(vecinos[(aux + 1)]);
        } else {//Si a posicion e a 99, a terna de atributos finaliza pola cidade 0
            if (aux == N - 2) {
                auxTerna.add(vecinos[(aux - 1)]);
                auxTerna.add(vecinos[(aux)]);
                auxTerna.add(0);
            } else {
                auxTerna.add(vecinos[(aux - 1)]);
                auxTerna.add(vecinos[(aux)]);
                auxTerna.add(vecinos[aux + 1]);
            }
        }

        if (listaTabu.contains(auxTerna) == true) {
            i = 1;
        }

        return i;
    }

    
    public static int [] probarVecino(int [] sA, int cidade, int posCity, int posRandom)
    {
        
        int vecinos[] = sA.clone();
        int cidadeCambio=0,novaCity=0;
                
 
        for(posCity=posCity;posCity<N-2;posCity++)  
                vecinos[posCity]=vecinos[posCity+1];
        
        cidadeCambio=vecinos[posRandom];
        vecinos[posRandom]=cidade;
        posCity=posRandom + 1;
        
        for(posCity=posCity;posCity<N-1;posCity++)
        {
            novaCity=vecinos[posCity];
            vecinos[posCity]=cidadeCambio;
            cidadeCambio=novaCity;
        }
        
        return vecinos;
    }
    
    
    
    public static void devolverSolucion(int[] sA, int iteracionMejor,PrintWriter wr) {
        //float distancia=0;
        int i = 0;
        wr.write("\nMEJOR SOLUCION: \n" + Arrays.toString(sA));
        //for(i=0;i<N-1;i++)
        //  System.out.println(sA[i]);

        wr.write("\nFUNCION OBJETIVO: " + distanciaTotal(sA));
        wr.write("\nITERACION: " + iteracionMejor);

    }

    public static void insertarTabu(int aux, int[] sA_aux) {
        //int auxTerna[]= new int[3];
        int[] vecinos = sA_aux.clone();
        ArrayList<Integer> auxTerna = new ArrayList();
        int i = 0, a = 0, b = 0, c = 0;
        c = aux + 1;
        /* a=vecinos[(aux-1)];
         b=vecinos[aux];
         c=vecinos[(aux+1)];*/
        //Si a posicion e 0, a terna de atributos comeza pola cidade 0
        if (aux == 0) {
            auxTerna.add(0);
            auxTerna.add(vecinos[aux]);
            auxTerna.add(vecinos[(aux + 1)]);
        } else {//Si a posicion e a 99, a terna de atributos finaliza pola cidade 0
            if (aux == N - 2) {
                auxTerna.add(vecinos[(aux - 1)]);
                auxTerna.add(vecinos[aux]);
                auxTerna.add(0);
            } else {
                auxTerna.add(vecinos[(aux - 1)]);
                auxTerna.add(vecinos[aux]);
                /* System.out.println("---------------------------------------------");
                 for(i=0;i<N-1;i++)
                 System.out.println(vecinos[i] + "   " + sA_aux[i]);*/
                auxTerna.add(vecinos[aux + 1]);
                //vecinos[aux+1];
            }
        }

        if (posicionesConsideradas.size() == 100) {
            listaTabu.add(auxTerna);
            listaTabu.remove(0);
        } else {
            listaTabu.add(auxTerna);
        }

    }

    public static void main(String[] args) throws IOException {
        // TODO code application logic here

            //File salidaImpresa;
        File salidaImpresa = new File("traza.txt");
        FileWriter w = new FileWriter(salidaImpresa);
        BufferedWriter bw = new BufferedWriter(w);
        PrintWriter wr = new PrintWriter(bw);  
        int i=1, posRandom=0, j=0, cidade = 0, pos=0,solAceptadas=0, solCandidatas=0,k=0,iMejor=0,solAceptadasTotales=0;
        double mu=0.03, phi=0.99,iniT=0, actualT=0,U=0;
        double delta=0;
        int[] sA = new int[N - 1];
        int[] mejorSolucion = new int[N - 1];
        int[] sA_aux = new int[N - 1];
        archivo a = new archivo();

        do {
            Scanner leer = new Scanner(System.in);
            System.out.println("\n-----------------------------");
            System.out.println("\n\tMENU");
            System.out.println("\n-----------------------------");
            System.out.println("\n1 - Generacion automatica");
            System.out.println("\n2 - Generacion fichero");

            System.out.println("\nItroduzca la opcion deseada: ");
            band = leer.nextInt();
        } while (band != 1 && band != 2);



        if (band == 2) {
            a.leerArchivo2();
        }

        a.leerArchivo1();

        //Algoritmo Voraz para a generacion das 99 cidades
        sA = generacionInicial().clone();
        mejorSolucion = sA.clone();
        iniT=(mu/-Math.log(phi))*distanciaTotal(sA);//Poñer temperatura pouca
        actualT=iniT;        
        wr.write("RECORRIDO INICIAL\n");
        wr.write(Arrays.toString(sA));
        wr.write("\nFUNCION OBJETIVO: " + distanciaTotal(sA));
        wr.write("\nTEMPERATURA: " + actualT +"\n");
        do{
            if(solAceptadas==20 || solCandidatas==80)
            {
             wr.write("\n********************************VELOCIDAD DE ENFRIAMIENTO ALCANZADA***********************************");   
             k++;//
             actualT=iniT/(1+k);
             //T=T.0.99;

             wr.write("\n============================");
             wr.write("\nENFRIAMIENTO: " + k);
             wr.write("\n============================");
             solAceptadas=0;
             solCandidatas=0;
             wr.write("\nCANDIDATAS " + solCandidatas + " | ACEPTADAS " + solAceptadas);
             wr.write("\nTEMPERATURA: " + actualT);
            }
            wr.write("\nITERACION: " + i);
            
            if(band==1)
                cidade=randInt(1, N - 1);
            else
            {    
                cidade = (int) (1 + Math.floor(lectura[cont] * 99));
                cont++;
            }
            
            for (j=0;j<N-1;j++)
                if (sA[j]==cidade)
                    pos=j;
            
            if(band==1)
                posRandom=randInt(0, N - 2);
            else
            {
                posRandom = (int) (Math.floor(lectura[cont] * 99));
                cont++;
            }
            while(pos==posRandom)
            {
             if(band==1)
                posRandom=randInt(0, N - 2);
             else
             {
                posRandom = (int) (Math.floor(lectura[cont] * 99));
                cont++;
             }
            }
            wr.write("\nRANDOM CIUDAD: " + cidade + " | RANDOM INDICE INSERCION: " + posRandom);
            sA_aux=probarVecino(sA,cidade,pos,posRandom);
            wr.write("\n" + Arrays.toString(sA_aux));

            
            solCandidatas++;
            wr.write("\nFUNCION OBJETIVO: " + distanciaTotal(sA_aux));
            if(distanciaTotal(sA_aux)<distanciaTotal(mejorSolucion))
            {
                mejorSolucion=sA_aux.clone();
                iMejor=i;
            }
            delta=distanciaTotal(sA_aux)-distanciaTotal(sA);
            wr.write("\nDELTA: " + delta);
            if(band==1)
                U= (double) aleatorio.nextDouble();
            else
            {
                U = (double) ((lectura[cont]));
                cont++;
            }
            wr.write("\nRANDOM U[0, 1): " + U + "\n");
            if(U<(double) Math.pow(Math.E,(-delta/actualT)) || (delta<0))
            {
                solAceptadas++;
                sA=sA_aux.clone();
                wr.write("SOLUCION CANDIDATA ACEPTADA\n");
                solAceptadasTotales++;
            }
         i++;
        }while (i <= 10000);

        devolverSolucion(mejorSolucion,iMejor,wr);
        System.out.println("\nSOLUCIONS ACEPTADAS: " + solAceptadasTotales);
        wr.write("\nSOLUCIONS ACEPTADAS: " + solAceptadasTotales);
        wr.close();
        bw.close();

    }
}
