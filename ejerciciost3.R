
################# Parte 1 ####################

#encuentra las opciones de las funcion ggmsa(), explica que hace cada una de ellas y modifica las opciones
#ggmsa se utiliza para la alineación de secuencias múltiples con colores y en colaboracion con ggplot2

#Los argumentos que puedes manipular en msa son: 
  

library(ggmsa) #consultare los argumentos enn bioconductor ya que adjuntan una guia de comandos y lo que hacen 

start = NULL... #marca el inicio del vector
  
end = NULL... #marca el final del vector 
  
font = ""... #tipos de letra disponibles
  
color = ""... #Gama de colores disponibles 
  
char_width = 000... # rango del caracter numerico 
  
none_bg = FALSE... #si esconde o no el fondo
  
by_conservation = FALSE... #regiones conservadas con colores especiales 
  
position_highlight = NULL... #resalta una posicion
  
seq_name = NULL... #Indica si se deben mostrar los nombres de secuencia.
  
border = NULL... #si quieres bordes
  
consensus_views = FALSE... # si quieres puntos de vista consensuados 
  
use_dot = FALSE... #por si quieres mostrar los caracteres con puntitos
  
disagreement = TRUE... #Muestra caracteres que no están de acuerdo con el consenso (valor logico).
  
ignore_gaps = FALSE... #pone o no espacios de los gaps 
  
ref = NULL... #solo si consensus views es TRUE para la secuencia 
  
show.legend = FALSE... #si quieres capa de leyendas incluidas o no 

#visualiza el mismo alineamiento con otra región... basado en el tutorial
protein_sequences <- system.file("extdata", "sample.fasta", 
                                 package = "ggmsa")
protein_sequences
ggmsaprotein<- ggmsa(protein_sequences, 300, 350, color = "Clustal", 
                     font = "DroidSansMono", char_width = 0.5, seq_name = TRUE )
ggmsaprotein

#Ahora con otra región, para esto se tiene que cambiar start y end
ggmsaprotein<- ggmsa(protein_sequences, 150, 300, color = "Clustal", 
                     font = "DroidSansMono", char_width = 0.5, seq_name = TRUE )
ggmsaprotein


#Visualiza el alineamiento anterior en todos los aminoácidos.
ggmsaprotein<- ggmsa(protein_sequences, color = "Clustal", 
                     font = "DroidSansMono", char_width = 0.5, seq_name = TRUE )
ggmsaprotein


#Visualiza el alineaminento de las otras dos conjuntos de secuencias
miRNA_sequences <- system.file("extdata", "seedSample.fa", 
                               package = "ggmsa")
nt_sequences <- system.file("extdata", "LeaderRepeat_All.fa", 
                            package = "ggmsa")




################# parte 2 ####################

#tutorial


#Cuál es el default de esta gráfica para la opción char_width?
#es de 0.9
msapro<- ggmsa(protein_sequences, start = 320, end = 360)
msapro


#¿Modiifca este default para números pequeños, mayores que uno?¿Es posible poner números negativos?


#para numeros pequeños si
msapro<- ggmsa(protein_sequences, start = 320, end = 360, char_width = 0.1)
msapro

#Para mayores que uno sale extraño pero aun siendo el limite 1 si imprime la fig y no es muy util 
msapro<- ggmsa(protein_sequences, start = 320, end = 360, char_width = 1.2)
msapro

#En numeros neg el render está al reves 
msapro<- ggmsa(protein_sequences, start = 320, end = 360, char_width = -1.5)
msapro




###############Parte 3#####################

install.packages("viridisLite")#me da varios errores de actualizar paquetes, los actualizo y me vuelve a pedir actualizar paquetes
library(viridisLite)
library(msa)
library(ggmsa)
library(ggtree)

#Descarga las secuencias en formato fasta de insulina.
insu<-readAAStringSet("insulinas.fasta")
class(insu)
names(insu)

#Lee las secuencias y genera un alineamiento múltiple por al menos dos algoritmos distintos
muscle<-msa(insu, "Muscle")
print(muscle, show="complete")

clustalw<-msa(insu, "ClustalW")
print(clustalw,show="complete")

#Crea un alineamiento básico de MSA usando la función ggmsa() para cada alineamiento .

alin<-msa(insu,"ClustalOmega")
aling<-msa(insu, "Muscle")

print(alin)
print(aling)


#Define una lista de regiones interesante para destacar en tu gráfica MSA.
ggmsa(alin, 10, 12, position_highlight = c(185, 190), char_width = 0.5) # me da este error multiple sequence alignment object no supported...

#Añade highlights a tu gráfica MSA con la función highlight_msa() .

ggmsa(insu, position_highlight= c(), char_width = 0.5)

ggmsa(insu, position_highlight= c(), char_width = 0.5)
#

#Personlaiza tu gráfica con el theme theme_bw() y las fucniones de escala de color scale_color_viridis_d() d ela librería viridis .
#no me deja cargar el viridis 
#me da varios errores de actualizar paquetes, los actualizo y me vuelve a pedir actualizar paquetes

#Guarda tu gráfica como archivo PDF con la función ggsave().
ggsave(alin)
ggsave(aling)
ggsave(insu)

# me da estos errores
> ggsave(alin)
Error in `ggsave()`:
  ! `device` must be "NULL", a string or a function.
Run `rlang::last_error()` to see where the error occurred.

> ggsave(aling)
Error in `ggsave()`:
  ! `device` must be "NULL", a string or a function.
Run `rlang::last_error()` to see where the error occurred.




