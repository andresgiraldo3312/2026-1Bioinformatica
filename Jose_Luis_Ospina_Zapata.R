#Instalar y cargar bibliotecas necesarias
if (!require(tseries)) install.packages("tseries")
library(tseries)

if (!require(randtests)) {
  install.packages("randtests")
}
library(randtests)

install.packages("BSDA")
library(BSDA)

install.packages("car")
library(car)

#Se quiere investigar el impacto de dos factores sobre la resistencia bacteriana
#Los factores son: hospitales (1, 2, 3) y bacterias (bacteria A, bacteria B)
#El objetivo es determinar si los hospitales afectan la resistencia bacteriana
#y si estos efectos varían según el tipo de bacteria.

#Simulación de los datos
#Se genera un conjunto de datos simulados con 60 sujetos,
#divididos en 3 grupos de hospitales (1, 2, 3)
#y dos tipos de bacterias (bacteria A, bacteria B).
set.seed(123)

# Simulación de datos
subjects <- factor(1:60)
hospitales <- factor(rep(c(1, 2, 3), each = 20))
bacterias <- factor(rep(c("bacteria A", "bacteria B"), times = 30))

# Simulación de resistencia bacteriana en MIC(concentracion minima inhibitoria)
mic <- c(rnorm(20, mean = 6, sd = 1),
         rnorm(20, mean = 7, sd = 1),
         rnorm(20, mean = 5, sd = 1))

# Creación del dataframe
data <- data.frame(subjects, hospitales, bacterias, mic)

head.matrix(data)

#Se realiza un ANOVA Factorial para evaluar los efectos principales
#y la interacción entre los factores hospitales y bacterias.
anova_factorial <- aov(mic ~ hospitales * bacterias, data = data)
summary(anova_factorial)

#El valor p del ANOVA es menor que 0.05,
#lo que quiere decir que hay diferencias significativas
#entre los grupos de hospitales.

#Efecto principal del hospital:
#Evalúa si los hospitales (1, 2, 3)
#tienen un impacto significativo en la resistencia.
#El efecto principal de los hospitales es significativo (valor p = 3.28e-07).

#Efecto principal de las bacterias:
#Determina si las bacterias (bacteria A, bacteria B)
#afecta significativamente la resistencia.
#El efecto principal de las bacterias no es significativo (valor p = 0.73).

#Interacción hospitales-bacterias:
#Verifica si los efectos de los hospitales dependen del tipo de bacteria.
#La interacción entre hospitales y bacterias no es significativa
#(valor p = 0.289).

#Pruebas de supuestos

#Normalidad de los residuos:
#Prueba de Shapiro-Wilk para verificar si los residuos
#se distribuyen normalmente.
# Prueba de normalidad
shapiro.test(residuals(anova_factorial))

#Los residuos siguen una distribución normal porque
#el valor p de la prueba Shapiro-Wilk es mayor que 0.05.
#Gráficamente se puede corroborar con el gráfico Q-Q:
qqnorm(residuals(anova_factorial))
qqline(residuals(anova_factorial), col = "blue", lwd = 2)

#En el gráfico Q-Q los puntos siguen aproximadamente la línea recta,
#entonces los residuos siguen una distribución normal.

#Homocedasticidad:
#Usamos la prueba de Levene para verificar si las varianzas son homogéneas.
#Prueba de homocedasticidad
leveneTest(mic ~ hospitales * bacterias, data = data)

#El valor de p es mayor que 0.05, se corrobora que las varianzas son homogéneas.
#Se puede evaluar este atributo de manera gráfica:
plot(fitted(anova_factorial), residuals(anova_factorial),
     main = "Residuos vs. Valores ajustados",
     xlab = "Valores ajustados", ylab = "Residuos")
abline(h = 0, col = "red", lwd = 2)

#En el gráfico no hay un patrón visible, las varianzas son homogéneas.

# Independencia de los residuos: Gráfico de residuos en función del orden.
plot(residuals(anova_factorial), type = "l",
     main = "Residuos vs. Orden de datos", xlab = "Orden", ylab = "Residuos")
abline(h = 0, col = "red", lwd = 2)

#El grafico verifica la independencia de los residuos porque
#no hay un patrón en los residuos, se cumple la independencia.

#Pruebas post-hoc

#Si se encuentran diferencias significativas en los efectos principales
#o en la interacción, se aplica la prueba de Tukey para realizar
#comparaciones múltiples.
# Prueba post-hoc de Tukey
TukeyHSD(anova_factorial)

#La prueba de Tukey confirma a través de comparación de los grupos de
#hospitales, el impacto significativo sobre la resistencia antibiótica
#en el estudio.

#Conclusión: Al realizar análisis de todos los resultados obtenidos
#a lo largo del desarrollo de esta actividad podemos establecer como
#decisión final que se rechaza la hipótesis nula, lo que sugiere que al menos
#uno de los factores en este caso los hospitales tienen un efecto significativo
#sobre la resistencia antibiótica.
