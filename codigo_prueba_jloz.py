# pip install biopython en terminal

from Bio import Entrez, SeqIO
from collections import Counter

# Configuración obligatoria para NCBI
Entrez.email = "joseluisospinazapata@gmail.com"

def analizar_hbv():
 print("Genotipos de Hepatitis B Virus (HBV) - Análisis de secuencias")

# 1. Buscar y descargar 10 IDs de HBV (genotipos) con secuencias completas
search_handle = Entrez.esearch(db="nucleotide", term="Hepatitis B virus[Organism] AND Genotypes", retmax=10)
search_results = Entrez.read(search_handle)
ids = search_results["IdList"]

# Descargar las secuencias completas
fetch_handle = Entrez.efetch(db="nucleotide", id=ids, rettype="fasta", retmode="text")
sequences = list(SeqIO.parse(fetch_handle, "fasta"))

# Colores ANSI para la terminal
colores = {
'A': '\033[92mA\033[0m', # Verde
'C': '\033[94mC\033[0m', # Azul
'G': '\033[93mG\033[0m', # Amarillo
'T': '\033[91mT\033[0m' # Rojo
}

base_seqs = []

for i, record in enumerate(sequences):
 seq_str = str(record.seq).upper()
 base_seqs.append(seq_str)
 print(f"\n>>> Genotipo {i+1}: {record.id} ({len(seq_str)} bp)")
 # 3. Asignar color (muestra las primeras 100 bases de cada secuencia)
 colored_sample = "".join([colores.get(b, b) for b in seq_str[:100]])
 print(f"secuencia: {colored_sample}...")
 # 2. Calcular porcentaje de cada base en la secuencia completa
 counts = Counter(seq_str)
 print("Composición nucleotídica:")
 for base in "ACGT":
  pct = (counts[base] / len(seq_str)) * 100
  print(f" {base}: {pct:.1f}%")

# 4. Establecer segmentos que las diferencian (comparación de posiciones)
print("\n--- Identificación de sitios polimórficos (primeras 100 bp) ---")
diferencias = []
for pos in range(100):
# Extraer la base en la misma posición para todas las secuencias
 columna = [s[pos] for s in base_seqs if pos < len(s)]
 if len(set(columna)) > 1: # Si hay más de una base diferente en esa posición
   diferencias.append(pos)

if diferencias:
 print(f"Se detectaron variaciones en las posiciones: {diferencias}")
else:
 print("No se encontraron diferencias en el segmento analizado")

if __name__ == "__main__":
 analizar_hbv()