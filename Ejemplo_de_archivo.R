import requests
from IPython.display import HTML

def descargar_fasta_uniprot(uniprot_id):
    """Descarga la secuencia FASTA de una proteína desde UniProt."""
    url = f"https://www.uniprot.org/uniprot/{uniprot_id}.fasta"
    print(f"Intentando descargar {url}...")
    response = requests.get(url)

    if response.status_code == 200:
        print("Descarga exitosa!")
        return response.text
    else:
        print(f"Error al descargar la secuencia. Código de estado: {response.status_code}")
        return None

# Definir un esquema de colores para los aminoácidos
amino_acid_colors = {
    # No polares alifáticos
    'G': '#A0A0A0', 'A': '#808080', 'V': '#606060', 'L': '#404040', 'I': '#202020', 'M': '#000000',
    # Aromáticos
    'F': '#8B0000', 'W': '#A52A2A', 'Y': '#CD5C5C',
    # Polares sin carga
    'S': '#00BFFF', 'T': '#00CED1', 'C': '#20B2AA', 'P': '#4682B4', 'N': '#6495ED', 'Q': '#ADD8E6',
    # Cargados positivamente (Básicos)
    'K': '#FF0000', 'R': '#B22222', 'H': '#DC143C',
    # Cargados negativamente (Ácidos)
    'D': '#00FF00', 'E': '#008000',
    # Aminoácidos especiales / no clasificados
    '*': '#FFD700', # Carácter de terminación
    'X': '#800080' # Aminoácido desconocido
}

def colorize_sequence(seq, colors):
    """Colorea una secuencia de aminoácidos usando un mapa de colores."""
    html_output = []
    for aa in seq:
        color = colors.get(aa.upper(), '#D3D3D3') # Color por defecto si no está en el mapa
        html_output.append(f'<span style="color:{color}; font-weight: bold;">{aa}</span>')
    return ''.join(html_output)

# Definimos los UniProt IDs para dos proteínas de ejemplo
uniprot_id_1 = 'P69905' # Hemoglobina Alfa (humana)
uniprot_id_2 = 'P68133' # Actina Alfa de Músculo Esquelético (humana)

# --- Procesar Primera Proteína ---
print(f"--- Procesando {uniprot_id_1} ---")
fasta_sequence_1 = descargar_fasta_uniprot(uniprot_id_1)

protein_sequence_1 = ""
if fasta_sequence_1:
    lines_1 = fasta_sequence_1.split('\n')
    protein_sequence_1 = ''.join(lines_1[1:]).replace(' ', '').strip()
    print(f"Secuencia de proteína {uniprot_id_1} extraída (longitud: {len(protein_sequence_1)}).")
    
    # Colorear los primeros 50 aminoácidos
    first_50_aa_1 = protein_sequence_1[:50]
    colored_html_1 = colorize_sequence(first_50_aa_1, amino_acid_colors)
    display(HTML(f"<h3>Primeros 50 Aminoácidos Coloreados para {uniprot_id_1} (Hemoglobina Alfa):</h3><pre>{colored_html_1}</pre>"))
else:
    print(f"No se pudo obtener la secuencia FASTA para {uniprot_id_1}.")

print("\n" + "-"*50 + "\n") # Separador para claridad

# --- Procesar Segunda Proteína ---
print(f"--- Procesando {uniprot_id_2} ---")
fasta_sequence_2 = descargar_fasta_uniprot(uniprot_id_2)

protein_sequence_2 = ""
if fasta_sequence_2:
    lines_2 = fasta_sequence_2.split('\n')
    protein_sequence_2 = ''.join(lines_2[1:]).replace(' ', '').strip()
    print(f"Secuencia de proteína {uniprot_id_2} extraída (longitud: {len(protein_sequence_2)}).")

    # Colorear los primeros 50 aminoácidos
    first_50_aa_2 = protein_sequence_2[:50]
    colored_html_2 = colorize_sequence(first_50_aa_2, amino_acid_colors)
    display(HTML(f"<h3>Primeros 50 Aminoácidos Coloreados para {uniprot_id_2} (Actina Alfa):</h3><pre>{colored_html_2}</pre>"))
else:
    print(f"No se pudo obtener la secuencia FASTA para {uniprot_id_2}.")
