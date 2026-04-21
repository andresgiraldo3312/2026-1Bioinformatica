# Script para descargar una secuencia de GenBank y contar bases en R

# Instalar paquetes si no están disponibles
if (!requireNamespace("ape", quietly = TRUE)) {
  install.packages("ape")
}
library(ape)

# Función para contar bases
count_bases <- function(sequence) {
  # Convertir a mayúsculas
  seq_upper <- toupper(sequence)

  # Contar cada base
  a_count <- sum(strsplit(seq_upper, "")[[1]] == "A")
  c_count <- sum(strsplit(seq_upper, "")[[1]] == "C")
  g_count <- sum(strsplit(seq_upper, "")[[1]] == "G")
  t_count <- sum(strsplit(seq_upper, "")[[1]] == "T")
  n_count <- sum(strsplit(seq_upper, "")[[1]] == "N")
  other_count <- nchar(seq_upper) - a_count - c_count - g_count - t_count - n_count

  # Imprimir resultados
  cat("Conteo de bases:\n")
  cat("A:", a_count, "\n")
  cat("C:", c_count, "\n")
  cat("G:", g_count, "\n")
  cat("T:", t_count, "\n")
  cat("N:", n_count, "\n")
  cat("Otros:", other_count, "\n")
  cat("Total de bases:", nchar(seq_upper), "\n")
}

# Función principal
main <- function() {
  # Pedir número de acceso
  accession <- readline(prompt = "Ingresa el número de acceso de GenBank (ej: NM_001301717): ")

  # Descargar secuencia
  cat("Descargando secuencia...\n")
  tryCatch({
    seq_data <- (accession)
    sequence <- as.character(seq_data)
    cat("Secuencia descargada exitosamente.\n")
    count_bases(sequence)
  }, error = function(e) {
    cat("Error al descargar la secuencia:", e$message, "\n")
  })
}

# Ejecutar
main()