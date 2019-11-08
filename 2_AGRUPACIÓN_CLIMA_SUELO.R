###     PROCESAMIENTO DE REDUCCIÓN DE VARIABLES AMBIENTALES (CLIMA Y SUELO)    ###

#Reducir niveles de las variables: clima y suelo 

#1) Cargar la base de datos del cultivo de café que corresponde a la "tabla de agregación".
cafe<-read.csv("ruta_de_archivo/archivo.csv",header = T)
head(cafe)
str(cafe)

#2) Agrupar diferentes tipos de clima y de suelo.

##Clima
#Se agruparon los 37 tipos de clima en 11 grupos.

levels(cafe$clima) <- list(clim_1=c("(A)C(fm)","(A)C(m)","(A)C(m)(f)"), 
                             clim_2=c("(A)C(w1)","(A)C(w2)","(A)C(wo)","(A)C(wo)x'"),
                             clim_3= c("A(f)","Am","Am(f)"),
                             clim_4= c("Aw1","Aw1(x')","Aw2","Aw2(x')","Awo","Awo(x')"),
                             clim_5 = c("BS1(h')w","BSo(h')(x')","BSo(h')w","BW(h')w"),
                             clim_6= c("BS1h(x')","BS1hw","BSohw"),
                             clim_7= c("BS1kw","BS1k(x')","BSokw"),
                             clim_8= c("C(f)","C(m)","C(m)(f)"),
                             clim_9= c("C(w1)","C(w1)x'","C(w2)","C(w2)x'","C(wo)"),
                             clim_10= "Cb'(m)(f)",
                             clim_11= c("Cb'(w2)","Cb'(w2)x'"))
##Suelo 
#Se agruparon los 24 tipos de suelo en 7 grupos.
#levels(caf$tipo_sue_m)
levels(cafe$suelo)<- list(suelo_1= c("AC","AL","LV","LX"),
                              suelo_2= c("AN","GL","NT","PL","PT"),
                              suelo_3= c("AR","CM","FL","RG"),
                              suelo_4= c("CH","KS","PH","UM"),
                              suelo_5= c("CL","DU"),
                              suelo_6="HS",
                              suelo_7= c("LP","SC","SN","VR"))