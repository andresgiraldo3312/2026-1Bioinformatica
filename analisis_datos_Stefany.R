
# Actividad funciones en R

# Función que analiza datos
analisis_datos <- function(datos) {
  
  media <- mean(datos)
  maximo <- max(datos)
  minimo <- min(datos)
  
  return(list(
    Media = media,
    Maximo = maximo,
    Minimo = minimo
  ))
}

# Datos de ejemplo
datos <- c(10, 15, 20, 25, 30)

# Usar función
resultado <- analisis_datos(datos)

print(resultado)
