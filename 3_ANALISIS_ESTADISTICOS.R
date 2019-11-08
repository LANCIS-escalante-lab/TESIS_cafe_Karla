             ###    ANÁLISIS ESTADÍSTICO DE LA BASE DE DATOS   ### 

## 1) Importar base de datos y crear variable productividad
# Cargar la base de datos con todas las variables
cafe<-read.csv("ruta_de_archivo/archivo.csv",header = T)
# Calcular la productividad
prod<-(cafe$vol_cosechado)/(cafe$sup_produccion)
# unir productividad a la base de datos
cafe<-cbind(prod,cafe)
summary(cafe$prod)
# los NAs corresponden a ceros
cafe$prod[is.na(cafe$prod)] <- 0

#visualizando la productividad
caja= boxplot(cafe$prod, col= "blue")
hist(cafe$prod)
summary(cafe$prod)
# borrar columna "X" y una variable repetida "temp" 
colnames(cafe)
cafe[,-c(2,78,166)]->cafe



## 2) Transformar ciertas variables a factores
#Nota: Se requirió la transformación de algunas variables numéricas a factores, debido a que analizando detalladamente que las preguntas que contestaban en el cuestionario del Censo Agropecuario 2007, se dio a conocer que la información correspondía a la totalidad de los cultivos trabajados y no únicamente al cultivo de café, no obstante seguía representando información relevante para el manejo de sus unidades de producción.
cafe$sup_fert <- as.factor(cafe$sup_fert)
levels(cafe$sup_fert)[levels(cafe$sup_fert)>0] <- "Si_fert"
levels(cafe$sup_fert)[levels(cafe$sup_fert)==0] <- "Sin_fert"
levels(cafe$sup_fert)

cafe$sup_sem_mejorada <- as.factor(cafe$sup_sem_mejorada)
levels(cafe$sup_sem_mejorada)[levels(cafe$sup_sem_mejorada)>0] <- "Si_sem"
levels(cafe$sup_sem_mejorada)[levels(cafe$sup_sem_mejorada)==0] <- "No_sem"
levels(cafe$sup_sem_mejorada)

cafe$sup_abono<- as.factor(cafe$sup_abono)
levels(cafe$sup_abono)[levels(cafe$sup_abono)>0] <- "Si_abono"
levels(cafe$sup_abono)[levels(cafe$sup_abono)==0] <- "Sin_abono"
levels(cafe$sup_abono)

cafe$sup_herb_quim<- as.factor(cafe$sup_herb_quim)
levels(cafe$sup_herb_quim)[levels(cafe$sup_herb_quim)>0] <- "Si_h_q"
levels(cafe$sup_herb_quim)[levels(cafe$sup_herb_quim)==0] <- "Sin_h_q"
levels(cafe$sup_herb_quim) 

cafe$sup_herb_org <- as.factor(cafe$sup_herb_org)
levels(cafe$sup_herb_org)[levels(cafe$sup_herb_org)>0] <- "Si_h_o"
levels(cafe$sup_herb_org)[levels(cafe$sup_herb_org)==0] <- "Sin_h_o"
levels(cafe$sup_herb_org) 

cafe$sup_insec_quim <- as.factor(cafe$sup_insec_quim)
levels(cafe$sup_insec_quim)[levels(cafe$sup_insec_quim)>0] <- "Si_i_q"
levels(cafe$sup_insec_quim)[levels(cafe$sup_insec_quim)==0] <- "Sin_i_q"
levels(cafe$sup_insec_quim)

cafe$sup_insec_org <- as.factor(cafe$sup_insec_org)
levels(cafe$sup_insec_org)[levels(cafe$sup_insec_org)>0] <- "Si_i_o"
levels(cafe$sup_insec_org)[levels(cafe$sup_insec_org)==0] <- "Sin_i_o"
levels(cafe$sup_insec_org)

cafe$sup_quema_ctrl <- as.factor(cafe$sup_quema_ctrl)
levels(cafe$sup_quema_ctrl)[levels(cafe$sup_quema_ctrl)>0] <- "Si_quema"
levels(cafe$sup_quema_ctrl)[levels(cafe$sup_quema_ctrl)==0] <- "No_quema"
levels(cafe$sup_quema_ctrl)

cafe$sup_temporal <- as.factor(cafe$sup_temporal)
levels(cafe$sup_temporal)[levels(cafe$sup_temporal)>0] <- "Si_temporal"
levels(cafe$sup_temporal)[levels(cafe$sup_temporal)==0] <- "No_temporal"
levels(cafe$sup_temporal)

cafe$sup_riego <- as.factor(cafe$sup_riego)
levels(cafe$sup_riego)[levels(cafe$sup_riego)>0] <- "Si_riego"
levels(cafe$sup_riego)[levels(cafe$sup_riego)==0] <- "No_riego"
levels(cafe$sup_riego)

colnames(cafe)
#renombrar variables
colnames(cafe)[8]<- "fert"
colnames(cafe)[9]<- "sem_mej"
colnames(cafe)[10]<- "abono"
colnames(cafe)[11]<- "h_q"
colnames(cafe)[12]<- "h_o"
colnames(cafe)[13]<- "i_q"
colnames(cafe)[14]<- "i_o"
colnames(cafe)[15]<- "quema"
colnames(cafe)[54]<- "temporal"
colnames(cafe)[55]<- "riego"


# 3) Se realizaron los análisis estadísticos para la reducción de las variables

###################################################################################
##########                     ANÁLISIS DE CORRELACIÓN                  ###########

# Se realiza únicamente con las variables numéricas de la base de datos
data_num= cafe[,-c(1,2,8:15,54,55,164,166,167,169)]

#Nota: aparecía un error en algunas variables, debido a que tenían la desviación estándar=0
data_num=Filter(function(x) sd(x) != 0, data_num)

#NOTAS:
##El coeficiente de correlación utilizado es la Rho de Spearman
##Se calcula la matriz de correlación y sí resulta significativa (p< 0.05), se identifica cuáles de las variables tienen fuerte correlación (>0.7)

# Matriz de correlación
library(Hmisc)
data.rcorr = rcorr(as.matrix(data_num), type= "spearman")
data.rcorr


# Matriz p values
data.p = data.rcorr$P
data.p 

cor_sig <- function (data.p){abs(data.p<0.05)}
cp<-apply(data.p, 2, cor_sig)
cp
# Guardar archivo para visualizarlo y manipularlo en excel
#write.csv(cp, file = "cor_sig.csv")

# Matriz con variables que tienen una correlación fuerte (>0.7)
ma_cor<-cor(data_num,y=NULL, use = "complete.obs",
            method ="spearman")
ma_cor
alta<- function (ma_cor){(ma_cor >= 0.7)}
a<-apply(ma_cor, 2, alta)
#write.csv(a, file = "alta_cor_pos.csv")

alta_neg <- function (ma_cor){(ma_cor <= -0.7)}
b<-apply(ma_cor, 2, alta_neg)
#write.csv(b, file = "alta_cor_neg.csv")

## Imagen que ilustra si existe correlación significativa o no con las variables
# Lo rojo es que no hay correlación significativa
# Lo amarillo (crema) que sí hay correlación significativa
image(abs(data.p<0.05))

#matriz de correlación representada con colores para visualización
library(corrplot)
corrplot(ma_cor, method = "color",  tl.cex = 0.3, tl.col = "red")

##Como resultado se encontraron 64 variables fuertemente correlacionadas en 39 pares
# Se eliminaron 35 variables
colnames(data_num)
data_num2= data_num[,-c(1,2,3,6,9,18,21,23,26,33,35,37,38,46,48,51,54,56,58,60,62,63,66,70,73,77,79,81,83,85,86,101,109,114,136)]

## Así se ve la matriz de correlación cuando le quitamos las variables más fuertemente correlacionadas
ma_cor2<-cor(data_num2,y=NULL, use = "complete.obs",
             method ="spearman")
ma_cor2
corrplot(ma_cor2, method = "color",  tl.cex = 0.3, tl.col = "red")

#########################################################################
###########          ANÁLISIS DE MULTICOLINEALIDAD             ##########
library(mctest)

multi<-imcdiag(data_num2, cafe$prod, method = "VIF", na.rm = TRUE, corr = FALSE, vif = 10, tol = 0.1,
               conf = 0.95, cvif = 10, leamer = 0.1, all = TRUE)
multi
#Como resultado se encontraron 17 variables con multicolinealidad
# si se eliminan 14 de esas 17 y se corre el análisis nuevamente ya no se detecta multicolinealidad en el sistema
colnames(data_num2)
data_mul<- data_num2[,-c(5:13,21,24,36,38,39)]

# Se ajusta la base de datos después de la reducción de variables
cafe2 = cafe[,c(1,2,6:15,17,18,30,32,34,35,37:39,42,46,49:57,
                59,61,62,65,71,73,76,77,79:81,83,84,86:88,90,92,94,96,99:112,114:120,122:125,127:147,149:169)]

#Se nombran los renglones de la Base de datos con el nombre de las las AGEBs rurales (CVEGEO)
library(tidyverse)
cafe2<-cafe2 %>% remove_rownames %>% column_to_rownames(var="CVEGEO")

# Se renombran algunas variables de la Base de datos
(cafe2)
colnames(cafe2)[2]<- "vender"
colnames(cafe2)[17]<- "inj_arb"
colnames(cafe2)[19]<- "sel_sem"
colnames(cafe2)[20]<- "con_fam_td"
colnames(cafe2)[21]<- "con_ani_td"
colnames(cafe2)[22]<- "v_inter"
colnames(cafe2)[23]<- "v_agroi"
colnames(cafe2)[24]<- "v_otro"
colnames(cafe2)[25]<- "v_ext"
colnames(cafe2)[26]<- "b_cafe"
colnames(cafe2)[27]<- "transf"
colnames(cafe2)[30]<- "prof_a"
colnames(cafe2)[32]<- "c_a_enm"
colnames(cafe2)[33]<- "sup_enm"
colnames(cafe2)[37]<- "o_sn_vg"
colnames(cafe2)[38]<- "selva"
colnames(cafe2)[39]<- "bosque"
colnames(cafe2)[40]<- "c_a_sb"
colnames(cafe2)[41]<- "past_sb"
colnames(cafe2)[42]<- "refor_sb"
colnames(cafe2)[43]<- "p_ssp"
colnames(cafe2)[44]<- "desm_sb"
colnames(cafe2)[45]<- "sup_desm_gd"
colnames(cafe2)[46]<- "sup_desm_o"
colnames(cafe2)[47]<- "aclareo"
colnames(cafe2)[48]<- "h_q_sb"
colnames(cafe2)[49]<- "h_o_sb"
colnames(cafe2)[50]<- "i_q_sb"
colnames(cafe2)[51]<- "i_o_sb"
colnames(cafe2)[52]<- "ctrl_i_sb"
colnames(cafe2)[53]<- "ctrl_b_sb"
colnames(cafe2)[54]<- "quema_sb"
colnames(cafe2)[55]<- "asist_sb"
colnames(cafe2)[56]<- "o_tec_sn"
colnames(cafe2)[57]<- "aserra_sb"
colnames(cafe2)[58]<- "vivero_sb"
colnames(cafe2)[59]<- "crédito"
colnames(cafe2)[60]<- "seguro"
colnames(cafe2)[61]<- "apoyo_gob"
colnames(cafe2)[65]<- "org_apoy"
colnames(cafe2)[69]<- "part_fam"
colnames(cafe2)[72]<- "dep_econ"
colnames(cafe2)[76]<- "p_act_o"
colnames(cafe2)[80]<- "uso_o_med"
colnames(cafe2)[81]<- "no_medio"
colnames(cafe2)[82]<- "pro_cred"
colnames(cafe2)[83]<- "pro_p_fert"
colnames(cafe2)[84]<- "pro_sin"
colnames(cafe2)[85]<- "pro_d_com"
colnames(cafe2)[89]<- "pro_asist"
colnames(cafe2)[90]<- "pro_litig"
colnames(cafe2)[91]<- "pro_acred"
colnames(cafe2)[102]<- "n_gdo_aprob"
colnames(cafe2)[103]<- "o_nvl_est"
colnames(cafe2)[106]<- "drenaj_fosa"
colnames(cafe2)[107]<- "energía"
colnames(cafe2)[112]<- "temperatura"
colnames(cafe2)[113]<- "clima"
colnames(cafe2)[114]<- "precipitación"
colnames(cafe2)[115]<- "textura_s"
colnames(cafe2)[116]<- "suelo"
colnames(cafe2)[117]<- "pendiente"
colnames(cafe2)[118]<- "uso_suelo"

##############################################################################
####################      ANÁLISIS FACTORIAL MIXTO       #####################

library("ggplot2")
library("FactoMineR")
library("factoextra")
famd<- FAMD(cafe2, ncp = 30, graph = FALSE)
print(famd)
eig.val <- get_eigenvalue(famd)
head(eig.val)
graf<-eig.val

fviz_screeplot(famd)
var <- get_famd_var(famd)
var
(var$contrib)

# Plot of variables###
fviz_famd_var(famd, repel = FALSE)
# Contribución de la primera dimensión
#la línea roja discontinua en el gráfico anterior indica el valor promedio esperado, si las contribuciones fueran uniformes
fviz_contrib(famd, "var", axes = 1)
# Contribución de las siguientes dimensiones
fviz_contrib(famd, "var", axes = 2)
fviz_contrib(famd, "var", axes = 3)
fviz_contrib(famd, "var", axes = 4)
fviz_contrib(famd, "var", axes = 5)
fviz_contrib(famd, "var", axes = 6)
fviz_contrib(famd, "var", axes = 7)
fviz_contrib(famd, "var", axes = 8)
fviz_contrib(famd, "var", axes = 9)
fviz_contrib(famd, "var", axes = 10)


##correlación  entre variables (cualitativas y cuantitativas) con dimensiones principales:
plot(famd, choix = "var") 

##contribuciones de variables cuantitativas
fviz_famd_var(famd,"quanti.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE) 
##variables cualitativas
quali.var <- get_famd_var(famd, "quali.var")
quali.var 
(quali.var$contrib)
fviz_famd_var(famd, "quali.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"))

## Como resultado de este análisis la base de datos se redujo a 90 variables ## 
colnames(cafe2)
cafe3= cafe2[,c(1,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19,20,22,23,24,25,26,28,29,30,31,32,33,34,36,37,38,39,40,41,42,43,44,45,47,48,52,53,54,55,59,
                61,62,63,64,69,70,71,72,74,76,79,81,82,83,84,85,86,87,88,89,91,94,96,97,99,100,101,103,104,105,
                106,107,108,109,110,111,112,113,114,115,116,117,118)]



# 4) Finalmente se realizó el Árbol de regresión como modelo de clasificación de las AGEB rurales donde se cultiva café a partir de su productividad

###########################################################################################
#######################                ÁRBOL DE REGRESIÓN              ####################
library(rpart)
library(rpart.plot)
library(ggplot2)
arbol<- rpart(prod~.,data = cafe3, method = "anova")
arbol

rpart.plot(arbol, type=2, digits=3, fallen.leaves = TRUE)
library(dplyr)
arbol$frame %>% select(var, n, dev)

arbol

##Diagnóstico del modelo (árbol)
pred<-predict(arbol,newdata = cafe3)
plot(cafe3$prod,pred)
arbol

plot(cafe3$prod,pred)
plot(cafe3$prod-pred)## diferencia entre la productividad observada menos la predicha y la mayoría son errores pequeños (cero)
var(cafe3$prod-pred)
sqrt(var(cafe3$prod-pred))#desvest

plot((cafe3$prod-pred)/1.755465)
abline(h=1.755465) # multiplicar valor z por la desvest más la media que en este caso es cero (hipótesis nula)
abline(h=-(1.755465))

###
#1.965 es una constante de una aproximación normal(valor z)
abline(h=1.965*1.755465) # multiplicar valor z por la desvest más la media que en este caso es cero (hipótesis nula)
abline(h=-(1.965*1.755465))

##por el número Z para estandarizar los residuos
sqrt(var(cafe3$prod-pred))*1.965 
#[1] 3.449489 ##

#hacer las líneas en el gráfico
abline(h=-3.449489)
abline(h=3.449489)
plot(((cafe3$prod-pred)*1.965)/(3.449489))##estandarizado
#líneas
abline(h=-3.449489)
abline(h=3.449489)

plot(pred,(cafe_fnl$prod-pred)/ 1.661733)
abline(h=-3.265305)
abline(h=3.265305)



