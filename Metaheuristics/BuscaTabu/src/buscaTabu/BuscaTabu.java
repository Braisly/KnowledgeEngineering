/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package buscaTabu;

import java.io.*;
import java.util.*;
import java.lang.*;
import java.security.*;

/**
 *
 * @author Brais
 */
public class BuscaTabu {

    static int N = 100, band = 0, cont = 0;
    static int[][] matriz = new int[N][N];
    static float[] lectura = new float[10000];
    //static ArrayList<int[]> v = new ArrayList<int[]>(); 
    static ArrayList<ArrayList<Integer>> listaTabu = new ArrayList<ArrayList<Integer>>();
    static ArrayList<Integer> posicionesConsideradas = new ArrayList<Integer>();
    //static int [] cities_aux= new int [N-1];

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

 
    private static int [] probarVecino(int [] sA, int cidade, int posCity, int posRandom)
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
    
    
    
    public static int[] generacionVecinos(int[] sA)
    {
        int[] vecinos = sA.clone();
        int[] mejorPosicion = new int[N - 1];
        int pos1 = 0, aux = 0, i = 0, cidade=0;
        boolean sw = true;


        //Genero aliatoriamente 1 posicions do 0-98 En total son 99 numeros
        //Pos: Ciudad
        if(band==1)
            cidade = randInt(1, N - 1);
        else
        {
            cidade = (int) (1 + Math.floor(lectura[cont] * 99));
            cont++;
        }
        System.out.println("RANDOM CIUDAD PARA EL OPERADOR DE INSERCION: " + cidade);
        //ciudad = pos1;
        for (i = 0; i < N - 1; i++) {
            if (vecinos[i] == cidade) {
                pos1 = i;
            }
        }


        if (pos1 != 0) {
            vecinos = probarVecino(sA, cidade,pos1, 0);
            posicionesConsideradas.add(0);

        } else {
            vecinos = probarVecino(sA, cidade,pos1, 1);
            posicionesConsideradas.add(1);

        }

        mejorPosicion = vecinos.clone();

        do { 
    
            if (aux != pos1)//Si e diferente da posicion da cidade random
            {//Donde hai un oco metemos a cidade
                vecinos = probarVecino(sA, cidade,pos1, aux);

                if (distanciaTotal(vecinos) < distanciaTotal(mejorPosicion)) {   //Comprobamos si esta na lista tabu a posicion da cidade aleatoria

                    if (siTabu(aux, vecinos) != 1) {
                        mejorPosicion = vecinos.clone();
                        //Gardamos a posicion pola que se mellora
                    }
                    posicionesConsideradas.add(aux);
                }
            }


            aux++;
        } while (aux < N - 1);
        // System.out.println(Arrays.toString(vecinos));
        return mejorPosicion;
    }

    public static void devolverSolucion(int[] sA, int reinicio, int iteracionMejor) {
        //float distancia=0;
        int i = 0;
        System.out.println("\nMEJOR SOLUCION: \n" + Arrays.toString(sA));
        //for(i=0;i<N-1;i++)
        //  System.out.println(sA[i]);

        System.out.println("FUNCION OBJETIVO: " + distanciaTotal(sA));
        System.out.println("ITERACION: " + iteracionMejor);
        System.out.println("N. DE REINICIOS: " + reinicio);

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

    public static void main(String[] args) {
        // TODO code application logic here

        //Scanner scaner = new Scanner(System.in);
        int i = 1, aux = 0, j = 0, contador = 0, reinicio = 0,iteracionMejor=0;
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
        System.out.println("RECORRIDO INICIAL");
        System.out.println(Arrays.toString(sA));
        System.out.println("FUNCION OBJETIVO: " + distanciaTotal(sA));
        do {
            //mejorVecino=sA;
            System.out.println("\nITERACION: " + i);

            
            sA_aux = generacionVecinos(sA).clone();
            
            sA = sA_aux.clone();
            System.out.println("POSICIONES CONSIDERADAS (INDICE ARRAY 0..98): " + posicionesConsideradas.toString());
            System.out.println(Arrays.toString(sA_aux));
            System.out.println("FUNCION OBJETIVO: " + distanciaTotal(sA_aux));
            System.out.println("LISTA TABU");
            //Añadir a LISTA TABU
            aux = posicionesConsideradas.size();
            insertarTabu(posicionesConsideradas.get(aux - 1), sA_aux);
            posicionesConsideradas.clear();
            //IMPRIMIR LISTA TABU
            for (j = 0; j < listaTabu.size(); j++) {
                System.out.println(listaTabu.get(j));
            }


            //Si la lista tabu contiene + de 100 ternasAtributos eliminamos a 1º
            if (distanciaTotal(sA_aux) < distanciaTotal(mejorSolucion)) {
                contador = 0;//ata o 99
                iteracionMejor=i;
                System.out.println("*****RECORRIDO MEJOR SOLUCIÓN GLOBAL****");
                mejorSolucion = sA_aux.clone();
            } else {

            if (contador == 99) {
                reinicio++;
                System.out.println("******* REINICIO " + reinicio + " ********");
                contador = 0;
                sA = mejorSolucion.clone();
                listaTabu.clear();
             }
            else
                 contador++;
            }


            i++;
        } while (i <= 10000);

        devolverSolucion(mejorSolucion,reinicio,iteracionMejor);
    }
}
