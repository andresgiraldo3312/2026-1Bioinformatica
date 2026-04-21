listaDeSecuencias = list("A1A4S6","A1L190","A6NGG8")


for(i in listaDeSecuencias){

    if(i != "A1L190"){
        linea = paste("la secuencia de analisis es: ",i, sep="")
        print(linea)
    }else{
        print("secuencia encontrada")
    }
}
