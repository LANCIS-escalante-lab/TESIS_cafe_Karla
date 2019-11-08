#PROCESAMIENTO DE DATOS EN INEGI(LABORATORIO DE MICRODATOS)
#######################       TABLA DE IDENTIFICACIÓN       ########################

#Se creó una tabla de identificación con las unidades de producción en las que se realiza el cultivo de café, con la finalidad de filtrar únicamente la información de dichas unidades de producción.
#1)Se utilizó la base de datos llamada "TRD_TERRENOS.CSV" debido a que en esta se encuentran las claves de las AGEB rurales por unidad de producción y se eliminaron las otras columnas quee no se utilizaron.
CUP_data = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_TERRENOS.CSV")
colnames(CUP_data) = c("id_cup", "id_terreno_cuest", "Entidad", "Municipio", "Localidad", "AGEB", "NUM_CTRL") 
str(CUP_data)
CUP_data$id_cup= as.factor(CUP_data$id_cup)
CUP_data$Entidad= as.factor(CUP_data$Entidad)
CUP_data$Municipio= as.factor(CUP_data$Municipio)
CUP_data$Localidad= as.factor(CUP_data$Localidad)
CUP_data$AGEB= as.factor(CUP_data$AGEB)
CUP_data = CUP_data[,c(1,3,4,5,6)]

#2)Se utilizó la base de datos llamada "TRD_AGRICULTURA_PERENNES_CAFE.CSV" para obtenerlas unidades de producción en dónde únicamente se siembra café, también se obtuvieron algunos variables relacionados al cultivo
cafe<-read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_AGRICULTURA_PERENNES_CAFE.CSV",header=TRUE)
cafe$id_cup= as.factor(cafe$id_cup)
colnames(cafe)[2]="id_cultivo"
cafe$id_cultivo= as.character(cafe$id_cultivo)
colnames(cafe)[3]="CVE_cultivo" 
cafe$CVE_cultivo= as.factor(cafe$CVE_cultivo)
colnames(cafe)[4]="sup_plantada"
colnames(cafe)[5]="sup_producción"
colnames(cafe)[6]="vol_cosechado"
colnames(cafe)[7]="vendido_vender"
colnames(cafe)[8]="sup_org"
colnames(cafe)[9]="nombre_cultivo"
cafe$nombre_cultivo= as.factor(cafe$nombre_cultivo)

#3)Se realizó la unión de las anteriores bases de datos a partir de la identificación de las unidades de producción en dónde se siembra café. Teniendo como resultado la "Tabla de identificación"
id_cafe= merge(cafe, CUP_data, by= "id_cup")

#TABLA DE VARIABLES
#La tabla de identificación generada se utilizó para seleccionar las unidades de producción en dónde se lleva a cabo el cultivo de café para cada una de las 20 bases de datos que se utilizaron del Censo Agropecuario 2007.
#Para nombrar cada columna de las bases de datos se utilizó el documento de excel "Descriptor de Archivos (FD)" como guía.
#Todas aquellas columnas que tenían datos categóricos, fueron convertidos a factores, para ello también se utilizó como guía el "Descriptor de Archivos (FD).
#Es importante señalar que debido a la cantidad de memoria que se necesita para procesar grandes basos de datos, se dividió por partes la importación de las bases de datos y su respectiva unión, así como su agregación (siguiente paso) ya que el software R abortaba misión si no se hacía de esta manera. 
#Con la finalidad de llevar un orden, se muestran a continuación todas las bases de datos que fueron utilizadas, pero se señala la sección a la que pertenecen originalmente. Cada sección posee por lo tanto su propia tabla de variables. Posteriormente se muestra también el proceso agregación con el nombre de sus respectivas secciones.

###PRIMERA SECCIÓN (Bases de datos: 1-8)###
##Base de datos 1.TRD_TECNOLOGIA_AGRICOLA 
tecno_agricola<-read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_TECNOLOGIA_AGRICOLA.CSV",header=TRUE)
#Renombrar columnas
colnames(tecno_agricola) = c("id_cup", "sup_fert","sup_sem_mejorada","sup_abono","sup_herb_quim", "sup_herb_org", "sup_insec_quim", "sup_insec_org",
                             "sup_quema_ctrl","otra_tec","sem_trans","ctrl_bio","injerto_arb","rotacion_cult","podas","asistencia_tec")
#Convertir a factores                         
tecno_agricola$id_cup= as.factor(tecno_agricola$id_cup)
tecno_agricola$sem_trans= as.factor(tecno_agricola$sem_trans)
tecno_agricola$ctrl_bio= as.factor(tecno_agricola$ctrl_bio)
tecno_agricola$injerto_arb= as.factor(tecno_agricola$injerto_arb)
tecno_agricola$rotacion_cult= as.factor(tecno_agricola$rotacion_cult)
tecno_agricola$podas= as.factor(tecno_agricola$podas)
tecno_agricola$asistencia_tec= as.factor(tecno_agricola$asistencia_tec)
tecno_agricola$otra_tec= as.factor(tecno_agricola$otra_tec) 

##Base de datos 2. TRD_INTERCALADOS_PERENNES
intercalados<-read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_INTERCALADOS_PERENNES.CSV",header=TRUE)
#Renombrar columnas
colnames(intercalados)= c("id_cup", "intercal","CVE_cult_1","CVE_cult_2","CVE_cult_3","sup_intercal",
                          "sup_propia","sup_renta", "sup_aparceria", "sup_prestamos","sup_o_der")
#Convertir a factores
intercalados$id_cup= as.factor(intercalados$id_cup)
intercalados$id_intercal= as.factor(intercalados$intercal)
#Seleccionar columnas que se van a utilizar
intercalados = intercalados[,c(1,2,6,7,8,9)]

##Base de datos 3. TRD_TENENCIA
tenencia = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_TENENCIA.CSV")
#Renombrar columnas
colnames(tenencia) = c("id_cup", "ejidal","comunal","privada","colonia","mun_est_nac") 

##Base de datos 4. TRD_DERECHOS.CSV
derechos= read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_DERECHOS.CSV")
#Renomrar columnas
colnames(derechos)= c("id_cup", "sup_propia","sup_renta", "sup_aparceria", "sup_prestamos","sup_o_der")

##Base de datos 5.  RD_AGRICULTURA_BAJO_CONTRATO
contrato = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_AGRICULTURA_BAJO_CONTRATO.CSV")
#Renombrar columnas
colnames(contrato) = c("id_cup","parte_cultivada","sup_cultivada","con_empresa","CVE_cult1","CVE_cult2",
                       "CVE_cult3","empacadora","agroindustria","comercializadora","especif_otra_indust",
                       "otra_indust","cult_1","cult_2","cult_3")
#Convertir a factores
contrato$parte_cultivada<- as.factor(contrato$parte_cultivada) 
contrato$con_empresa<- as.factor(contrato$con_empresa)
contrato$empacadora<- as.factor(contrato$empacadora)
contrato$agroindustria<- as.factor(contrato$agroindustria)
contrato$comercializadora<- as.factor(contrato$comercializadora)
contrato$otra_indust<- as.factor(contrato$otra_indust) 
#Seleccionar columnas que se van a utilizar
contrato= contrato[,c(1,2,3,4,8,9,10,11,12)]

##Base de datos 6. TRD_NO_SEMB_SUPERF_CAUSA
causa_no_semb = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_NO_SEMB_SUPERF_CAUSA.CSV")
#Renombrar columnas
colnames(causa_no_semb) = c("id_cup","sin_semb_PV","sup_no_semb","no_intereso","falta_dinero","mal_temporal",
                            "no_hubo_quien_semb","estaba_invadida","suelo_poco_fertil","suelo_erosionado","descanso",
                            "sup_descanso","nomb_otra_causa","otra_causa")
#Convertir factores
causa_no_semb$sin_semb_PV<- as.factor(causa_no_semb$sin_semb_PV) 
causa_no_semb$no_intereso<- as.factor(causa_no_semb$no_intereso)
causa_no_semb$falta_dinero<- as.factor(causa_no_semb$falta_dinero)
causa_no_semb$mal_temporal<- as.factor(causa_no_semb$mal_temporal)
causa_no_semb$no_hubo_quien_semb<- as.factor(causa_no_semb$no_hubo_quien_semb)
causa_no_semb$estaba_invadida<- as.factor(causa_no_semb$estaba_invadida)
causa_no_semb$suelo_poco_fertil<- as.factor(causa_no_semb$suelo_poco_fertil)
causa_no_semb$suelo_erosionado<- as.factor(causa_no_semb$suelo_erosionado)
causa_no_semb$descanso<- as.factor(causa_no_semb$descanso)
causa_no_semb$nomb_otra_causa<- as.factor(causa_no_semb$nomb_otra_causa)
causa_no_semb$otra_causa<- as.factor(causa_no_semb$otra_causa)

##Base de datos 7. TRD_CONSTRUCCIONES_INSTALACIONES
const_instal = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_CONSTRUCCIONES_INSTALACIONES.CSV")
#Renombrar columnas
colnames(const_instal) = c("id_cup","benefic_cafe_cacao","años_beneficiadora","desfibradora",
                           "años_desfibradora","deshidratadora","años_deshidratadora","empaca_frutas_verdura",
                           "años_empacadora","seleccionadora","años_seleccionadora","nomb_otra_instal","otra_instal","años_otra_instal",
                           "vivero","sup_vivero","invernadero","sup_invernadero","año_invernadero")
#Convertir factores
const_instal$benefic_cafe_cacao<- as.factor(const_instal$benefic_cafe_cacao)
const_instal$desfibradora<- as.factor(const_instal$desfibradora)
const_instal$deshidratadora<- as.factor(const_instal$deshidratadora)
const_instal$empaca_frutas_verdura<- as.factor(const_instal$empaca_frutas_verdura)
const_instal$seleccionadora<- as.factor(const_instal$seleccionadora)
const_instal$nomb_otra_instal<- as.factor(const_instal$nomb_otra_instal)
const_instal$otra_instal<- as.factor(const_instal$otra_instal)
const_instal$vivero<- as.factor(const_instal$vivero)
const_instal$invernadero<- as.factor(const_instal$invernadero)

#Base de datos 8.TRD_DESTINO_PROD_AGRICOLA
destino_produccion = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_DESTINO_PROD_AGRICOLA.CSV")
#Renombrar columnas
colnames(destino_produccion) = c("id_cup","sel_semilla","consumo_fam","consumo_animal","venta","venta_intermediario",
                                 "venta_mayorista","venta_cadena_comercial","venta_empaca_agroindust","nomb_otro_comprador",
                                 "venta_otro_comprador","venta_extranj","procesa_transforma","venta_produc_obt") 
#Convertir factores
destino_produccion$sel_semilla<- as.factor(destino_produccion$sel_semilla)
destino_produccion$consumo_fam<- as.factor(destino_produccion$consumo_fam)
destino_produccion$consumo_animal<- as.factor(destino_produccion$consumo_animal)
destino_produccion$venta<- as.factor(destino_produccion$venta)
destino_produccion$venta_intermediario<- as.factor(destino_produccion$venta_intermediario)
destino_produccion$venta_mayorista<- as.factor(destino_produccion$venta_mayorista)
destino_produccion$venta_cadena_comercial<- as.factor(destino_produccion$venta_cadena_comercial)
destino_produccion$venta_empaca_agroindust<- as.factor(destino_produccion$venta_empaca_agroindust)
destino_produccion$venta_otros_comprador<- as.factor(destino_produccion$nomb_otro_comprador)
destino_produccion$venta_otro_comprador<- as.factor(destino_produccion$venta_otro_comprador)
destino_produccion$venta_extranj<- as.factor(destino_produccion$venta_extranj)
destino_produccion$procesa_transforma<- as.factor(destino_produccion$procesa_transforma)
destino_produccion$venta_produc_obt<- as.factor(destino_produccion$venta_produc_obt)

##UNIÓN PRIMERA SECCIÓN (1ERA TABLA DE VARIABLES)
id_tecno= merge(id_cafe,tecno_agricola) 
id_tecno_intercal= merge(id_tecno, intercalados, all.x = T)
id_derechos= merge(id_tecno_intercal, derechos, all.x = T)
id_contrato= merge(id_derechos,contrato, all.x = T)
id_tenencia= merge(id_contrato,tenencia,  all.x = T)
id_causas= merge(id_tenencia,causa_no_semb, all.x = T)
id_destino= merge(id_causas,destino_produccion, all.x = T)
id_instal= merge(id_destino, const_instal, all.x = T)

###SEGUNDA SECCIÓN (Bases de datos:9-11)###
#Nota: borrar las anteriores bases de datos para que R no colapse.

##Base de datos 9.TRD_RIEGO_SUPERF_TIPO_FUENTE
tipo_fuente<-read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_RIEGO_SUPERF_TIPO_FUENTE.CSV",header=TRUE)
tipo_fuente= tipo_fuente[,-11] 
dim(tipo_fuente)
#Renombrar columnas
colnames(tipo_fuente)=c("id_cup","sup_temporal", "sup_riego","canales_recub","canales_tierra","sist_aspersion",
                        "sist_microaspersion","sist_goteo","nom_o_sist","sist_otro","prov_bordo","prov_pozo","prof_extrae_agua","prov_pozo_cielo_abierto",
                        "prov_rio","prov_manantial","prov_presa","nomb_otra_fuente","otra_fuente","agua_blanca","agua_negra","agua_tratada",
                        "no_sabe","animales_o_tronco_o_yunta","animales_propios","tractor","sembro_coa_o_azadon_o_herramienta")
#Convertir a factores
tipo_fuente$canales_recub= as.factor(tipo_fuente$canales_recub)
tipo_fuente$canales_tierra= as.factor(tipo_fuente$canales_tierra)
tipo_fuente$sist_aspersion= as.factor(tipo_fuente$sist_aspersion)
tipo_fuente$sist_microaspersion= as.factor(tipo_fuente$sist_microaspersion)
tipo_fuente$sist_goteo= as.factor(tipo_fuente$sist_goteo)
tipo_fuente$sist_otro= as.factor(tipo_fuente$sist_otro)
tipo_fuente$prov_bordo= as.factor(tipo_fuente$prov_bordo)
tipo_fuente$prov_pozo= as.factor(tipo_fuente$prov_pozo)
tipo_fuente$prov_pozo_cielo_abierto= as.factor(tipo_fuente$prov_pozo_cielo_abierto)
tipo_fuente$prov_rio= as.factor(tipo_fuente$prov_rio)
tipo_fuente$prov_manantial= as.factor(tipo_fuente$prov_manantial)
tipo_fuente$prov_presa= as.factor(tipo_fuente$prov_presa)
tipo_fuente$otra_fuente= as.factor(tipo_fuente$otra_fuente)
tipo_fuente$nomb_otra_fuente= as.factor(tipo_fuente$nomb_otra_fuente)
tipo_fuente$agua_blanca= as.factor(tipo_fuente$agua_blanca)
tipo_fuente$agua_negra= as.factor(tipo_fuente$agua_negra)
tipo_fuente$agua_tratada= as.factor(tipo_fuente$agua_tratada)
tipo_fuente$no_sabe= as.factor(tipo_fuente$no_sabe)
tipo_fuente$animales_o_tronco_o_yunta= as.factor(tipo_fuente$animales_o_tronco_o_yunta)
tipo_fuente$animales_propios= as.factor(tipo_fuente$animales_propios)
tipo_fuente$tractor= as.factor(tipo_fuente$tractor)
tipo_fuente$sembro_coa_o_azadon_o_herramienta= as.factor(tipo_fuente$sembro_coa_o_azadon_o_herramienta)

##Base de datos 10. TRD_OTRAS_SUPERFICIES
otras_superf = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_OTRAS_SUPERFICIES.CSV")
#Renombrar columnas
colnames(otras_superf)= c("id_cup","enmontada","sup_enmontada","sup_pastos_no","sup_semb_pastos",
                          "cort_arb_enmon","CVE_sp_cortada_1","cantidad_sp1",
                          "CVE_sp_cortada_2","cantidad_sp2","sin_veg","arenales_pedregales",
                          "sup_arenales_pedregales","ensalitrada","sup_ensalitrada",
                          "ensalitrada_años_s_veg","erosionada","sup_erosionada", 
                          "erosionada_años_s_veg","cubierta_agua","sup_cubierta_agua",
                          "contaminada","sup_contaminada","nomb_o_sn_v","otra_sin_veg","sup_o_sn_veg")
#Convertir a factores
otras_superf$id_cup= as.factor(otras_superf$id_cup)
otras_superf$enmontada<- as.factor(otras_superf$enmontada) 
otras_superf$cort_arb_enmon<- as.factor(otras_superf$cort_arb_enmon)
otras_superf$sin_veg<- as.factor(otras_superf$sin_veg)
otras_superf$arenales_pedregales<- as.factor(otras_superf$arenales_pedregales)
otras_superf$ensalitrada<- as.factor(otras_superf$ensalitrada)
otras_superf$erosionada<- as.factor(otras_superf$erosionada)
otras_superf$cubierta_agua<- as.factor(otras_superf$cubierta_agua)
otras_superf$contaminada<- as.factor(otras_superf$contaminada)
otras_superf$nomb_o_sn_v<- as.factor(otras_superf$nomb_o_sn_v)
otras_superf$otra_sin_veg<- as.factor(otras_superf$otra_sin_veg)

##Base de datos 11.TRD_SUPERFICIEs_BOSQUE_SELVA
bosque_selva= read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_SUPERFICIEs_BOSQUE_SELVA.CSV")
#Renombrar columnas
colnames(bosque_selva)= c("id_cup","selva","sup_selva","bosque","sup_bosque","cort_arb_sb","CVE_sp1_cort",
                          "cant_sp1_cort","CVE_sp2_cort","cant_sp2_cort","pastoreo_sb","reforesta_sb","sup_refores",
                          "refores_spp_rg","CVE_sp1_refor","cant_sp1_refor","CVE_sp2_refor","cant_sp2_refor",
                          "plant_fuera","arb_lind_disper","arb_terrenos_prod","arb_terr_lind_disp","cant_arboles",
                          "plant_spp_rg","CVE_sp1_plant","sup_sp1_plant", "CVE_sp2_plant",
                          "sup_sp2_plant","s_arbpl_export")
#Convertir a factores
bosque_selva$id_cup= as.factor(bosque_selva$id_cup)
bosque_selva$selva <- as.factor(bosque_selva$selva)
bosque_selva$bosque <- as.factor(bosque_selva$bosque)
bosque_selva$cort_arb_sb <- as.factor(bosque_selva$cort_arb_sb)
bosque_selva$pastoreo_sb<- as.factor(bosque_selva$pastoreo_sb)
bosque_selva$reforesta_sb <- as.factor(bosque_selva$reforesta_sb)
bosque_selva$refores_spp_rg <- as.factor(bosque_selva$refores_spp_rg)
bosque_selva$plant_fuera <- as.factor(bosque_selva$plant_fuera)
bosque_selva$arb_lind_disper <- as.factor(bosque_selva$arb_lind_disper)
bosque_selva$arb_terrenos_prod <- as.factor(bosque_selva$arb_terrenos_prod)
bosque_selva$arb_terr_lind_disp <- as.factor(bosque_selva$arb_terr_lind_disp)
bosque_selva$plant_spp_rg <- as.factor(bosque_selva$plant_spp_rg) 

#UNIÓN SEGUNDA SECCIÓN (2DA TABLA DE VARIABLES)
id_fuente= merge(id_cafe,tipo_fuente) 
id_superf= merge(id_fuente, otras_superf)
id_bosque= merge(id_superf,bosque_selva)

###TERCERA SECCIÓN (Base de datos:12-14)###
##Base de datos 12. TRD_TECNOLOGIA_FORESTAL
tecno_forestal = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_TECNOLOGIA_FORESTAL.CSV")
#Renombrar columnas
colnames(tecno_forestal)= c("id_cup","arb_corte_b","sup_arb_corte_b","aclareo","sup_aclareo","herb_quim_b",
                            "sup_herb_quim_b","herb_org_b","sup_herb_org_b","insec_quim_b","sup_insec_quim_b",
                            "insec_org_b","sup_insec_org_b","ctrl_incendio_b","ctrl_bio_b","quema_ctrl_b",
                            "asist_tecno_b","otra_tecno_b","sup_otra_tecno_b","aserradero_b","vivero_forestal",
                            "sec_madera","otra_instal_b","nomb_otra_instal_b")
#Convertir factores
tecno_forestal$id_cup= as.factor(tecno_forestal$id_cup)
tecno_forestal$arb_corte_b<- as.factor(tecno_forestal$arb_corte_b)
tecno_forestal$aclareo<- as.factor(tecno_forestal$aclareo)
tecno_forestal$herb_quim_b<- as.factor(tecno_forestal$herb_quim_b)
tecno_forestal$herb_org_b<- as.factor(tecno_forestal$herb_org_b)
tecno_forestal$insec_quim_b<- as.factor(tecno_forestal$insec_quim_b)
tecno_forestal$insec_org_b<- as.factor(tecno_forestal$insec_org_b)
tecno_forestal$ctrl_incendio_b<- as.factor(tecno_forestal$ctrl_incendio_b)
tecno_forestal$ctrl_bio_b<- as.factor(tecno_forestal$ctrl_bio_b)
tecno_forestal$quema_ctrl_b<- as.factor(tecno_forestal$quema_ctrl_b)
tecno_forestal$asist_tecno_b<- as.factor(tecno_forestal$asist_tecno_b)
tecno_forestal$otra_tecno_b<- as.factor(tecno_forestal$otra_tecno_b)
tecno_forestal$aserradero_b<- as.factor(tecno_forestal$aserradero_b)
tecno_forestal$vivero_forestal<- as.factor(tecno_forestal$vivero_forestal)
tecno_forestal$sec_madera<- as.factor(tecno_forestal$sec_madera)
tecno_forestal$nomb_otra_instal_b<- as.factor(tecno_forestal$nomb_otra_instal_b)
tecno_forestal$otra_instal_b<- as.factor(tecno_forestal$otra_instal_b) 

##Base de datos 13. TRD_VENTA_FORESTAL
venta_forestal = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_VENTA_FORESTAL.CSV")
#Quedarse con las columnas de interés
venta_forestal=venta_forestal[,c(1:5)]
#Renombrar columnas
colnames(venta_forestal)= c("id_cup","desmonte_sb","sup_desm_agr","sup_desm_gd","sup_desm_otro")
#Convertir a factor
venta_forestal$desmonte_sb<-as.factor(venta_forestal$desmonte_sb)

##Base 14. TRD_CREDITOS_SEGUROS_APOYOS
apoyos = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_CREDITOS_SEGUROS_APOYOS.CSV")
#Renombrar columnas
colnames(apoyos)= c("id_cup","cred_prestamo","banca_comercial","sofol","union_cred",
                    "financiera_rural","nomb_otra_fuente","otra_fuente","fondos_fira","cred_avio", 
                    "monto_cred_avio", "cred_refaccionario","monto_cred_ref","nomb_cred_otro","cred_otro","monto_cred_otro",
                    "seguro","seg_agroasemex","nomb_otra_aseg","seg_otra_aseg","apoyo_gob","procampo",
                    "prog_ganadero","prog_diesel","prog_apoy_direc","prog_inv_rural","prog_desarrollo_cap",
                    "prog_desarrollo_rural","prog_fomento_agr","mujer_sect_agr","prodefor","conafor",
                    "prog_acua_pesca","prog_jornaleros_agr","prog_empleo_temp","prog_vivienda_rural",
                    "seguro_popular","oportunidades","prog_opc_prod","fondo_proy_prod","prog_infraest_hidroagr",
                    "prog_fondos_reg_indigenas","prog_desarrollo_reg_sust","prog_equidad_genero_indigenas",
                    "nomb_apoy_otro_prog","apoy_otro_prog","ahorro_ingresos","con_banca_comercial","con_banca_publica","con_union_cred",
                    "con_caja_ahorro","nomb_otra_inst","con_otra_inst") 
#Convertir a factores
apoyos$id_cup= as.factor(apoyos$id_cup)
apoyos$cred_prestamo<- as.factor(apoyos$cred_prestamo)
apoyos$banca_comercial<- as.factor(apoyos$banca_comercial)
apoyos$sofol<- as.factor(apoyos$sofol)
apoyos$union_cred<- as.factor(apoyos$union_cred)
apoyos$financiera_rural<- as.factor(apoyos$financiera_rural)
apoyos$otra_fuente<- as.factor(apoyos$otra_fuente)
apoyos$fondos_fira<- as.factor(apoyos$fondos_fira)
apoyos$cred_avio<- as.factor(apoyos$cred_avio)
apoyos$cred_refaccionario<- as.factor(apoyos$cred_refaccionario)
apoyos$cred_otro<- as.factor(apoyos$cred_otro)
apoyos$seguro<- as.factor(apoyos$seguro)
apoyos$seg_agroasemex<- as.factor(apoyos$seg_agroasemex)
apoyos$seg_otra_aseg<- as.factor(apoyos$seg_otra_aseg)
apoyos$apoyo_gob<- as.factor(apoyos$apoyo_gob)
apoyos$procampo<- as.factor(apoyos$procampo)
apoyos$prog_ganadero<- as.factor(apoyos$prog_ganadero)
apoyos$prog_diesel<- as.factor(apoyos$prog_diesel) 
apoyos$prog_apoy_direc<- as.factor(apoyos$prog_apoy_direc)
apoyos$prog_inv_rural<- as.factor(apoyos$prog_inv_rural)
apoyos$prog_desarrollo_cap<- as.factor(apoyos$prog_desarrollo_cap)
apoyos$prog_desarrollo_rural<- as.factor(apoyos$prog_desarrollo_rural)
apoyos$prog_fomento_agr<- as.factor(apoyos$prog_fomento_agr) 
apoyos$mujer_sect_agr<- as.factor(apoyos$mujer_sect_agr) 
apoyos$prodefor<- as.factor(apoyos$prodefor) 
apoyos$conafor<- as.factor(apoyos$conafor) 
apoyos$prog_acua_pesca<- as.factor(apoyos$prog_acua_pesca) 
apoyos$prog_jornaleros_agr<- as.factor(apoyos$prog_jornaleros_agr) 
apoyos$prog_vivienda_rural<- as.factor(apoyos$prog_vivienda_rural)
apoyos$prog_empleo_temp<- as.factor(apoyos$prog_empleo_temp) 
apoyos$seguro_popular<- as.factor(apoyos$seguro_popular) 
apoyos$oportunidades<- as.factor(apoyos$oportunidades) 
apoyos$prog_opc_prod<- as.factor(apoyos$prog_opc_prod) 
apoyos$fondo_proy_prod<- as.factor(apoyos$fondo_proy_prod)
apoyos$prog_infraest_hidroagr<- as.factor(apoyos$prog_infraest_hidroagr)
apoyos$prog_desarrollo_reg_sust<- as.factor(apoyos$prog_desarrollo_reg_sust)
apoyos$prog_fondos_reg_indigenas<- as.factor(apoyos$prog_fondos_reg_indigenas)
apoyos$prog_equidad_genero_indigenas<- as.factor(apoyos$prog_equidad_genero_indigenas)
apoyos$nomb_apoy_otro_prog<-as.factor(apoyos$nomb_apoy_otro_prog)
apoyos$apoy_otro_prog<- as.factor(apoyos$apoy_otro_prog)
apoyos$ahorro_ingresos<- as.factor(apoyos$ahorro_ingresos)
apoyos$con_banca_comercial<- as.factor(apoyos$con_banca_comercial)
apoyos$con_banca_publica<- as.factor(apoyos$con_banca_publica)
apoyos$con_union_cred<- as.factor(apoyos$con_union_cred)
apoyos$con_caja_ahorro<- as.factor(apoyos$con_caja_ahorro)
apoyos$nomb_otra_inst<-as.factor(apoyos$nomb_otra_inst)
apoyos$con_otra_inst<- as.factor(apoyos$con_otra_inst)

#UNIÓN TERCERA SECCIÓN (3ERA TABLA DE VARIABLES)
id_tecno_forestal= merge(tecno_forestal,id_cafe)
id_venta_forestal=merge(id_tecno_forestal,venta_forestal)
id_apoyos= merge(id_venta_forestal,apoyos)

### CUARTA SECCIÓN (Bases de datos: 15-17)###
##Base de datos 15.TRD_ORGANIZACION_ENTRE_PRODUCTORES
org_entre_prod = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_ORGANIZACION_ENTRE_PRODUCTORES.CSV")
#Renombrar columnas
colnames(org_entre_prod)= c("id_cup","org_para_apoyos","gpo_apoy","años_grup","cant_grup","mujs_grup",
                            "socied_rural","años_socied_rural","cant_socied_rural","mujs_socied-rural","socied_coop",
                            "años_socied_coop","cant_socied_coop","mjs_socied_coop","socied_civil","años_socied_civil",
                            "cant_socied_civil","mujs_socied_civil","solid_social","años_solid_social",
                            "cant_solid_social","mujs_solid_social","union_cred","años_union_cred","cant_union_cred",
                            "mujs_union_cred","coop_ahorro_cred","años_ahorro_cred","cant_ahorro_cred","mujs_ahorro_cred",
                            "socied_anon","años_socied_anon","cant_socied_anon","mujs_socied_anon","asoc_ganad","años_asoc_ganad",
                            "cant_asoc_ganad","mujs_asoc_ganad","asoc_agric","años_asoc_agric","cant_asoc_agric", "mujs_asoc_agric",
                            "union_agr_rg","años_union_agr_rg","union_gd_rg","años_union_gd_rg","asoc_sivic","años_asoc_sivic",
                            "union_soc_rural","años_union_soc_rural","otra_org","años_otra_org","cant_otra_org","mujs_otra_org","apoy_insumos",
                            "apoy_asist_tec","apoy_prod_contrato","apoy_procesam","apoy_comercial","apoy_agropec","apoy_precios",
                            "apoy_financ","otro_apoy","part_com_sist_pd","part_consejo_drsust","part_asoc_agr","part_asoc_ganad","part_org_camp","part_org_empr",
                            "part_otra_asoc")
#Convertir a factores
org_entre_prod$id_cup= as.factor(org_entre_prod$id_cup)
org_entre_prod$org_para_apoyos<- as.factor(org_entre_prod$org_para_apoyos)   
org_entre_prod$gpo_apoy<- as.factor(org_entre_prod$gpo_apoy)     
org_entre_prod$socied_rural<- as.factor(org_entre_prod$socied_rural)     
org_entre_prod$socied_coop<- as.factor(org_entre_prod$socied_coop)
org_entre_prod$socied_civil<- as.factor(org_entre_prod$socied_civil)
org_entre_prod$solid_social<- as.factor(org_entre_prod$solid_social)
org_entre_prod$union_cred<- as.factor(org_entre_prod$union_cred)
org_entre_prod$coop_ahorro_cred<- as.factor(org_entre_prod$coop_ahorro_cred)
org_entre_prod$socied_anon<- as.factor(org_entre_prod$socied_anon)
org_entre_prod$asoc_ganad<- as.factor(org_entre_prod$asoc_ganad)
org_entre_prod$asoc_agric<- as.factor(org_entre_prod$asoc_agric)
org_entre_prod$union_agr_rg<- as.factor(org_entre_prod$union_agr_rg)
org_entre_prod$union_gd_rg<- as.factor(org_entre_prod$union_gd_rg)
org_entre_prod$asoc_sivic<- as.factor(org_entre_prod$asoc_sivic)
org_entre_prod$union_soc_rural<- as.factor(org_entre_prod$union_soc_rural)
org_entre_prod$otra_org<- as.factor(org_entre_prod$otra_org)
org_entre_prod$apoy_insumos<- as.factor(org_entre_prod$apoy_insumos)
org_entre_prod$apoy_asist_tec<- as.factor(org_entre_prod$apoy_asist_tec)
org_entre_prod$apoy_prod_contrato<- as.factor(org_entre_prod$apoy_prod_contrato)
org_entre_prod$apoy_procesam<- as.factor(org_entre_prod$apoy_procesam)
org_entre_prod$apoy_comercial<- as.factor(org_entre_prod$apoy_comercial)
org_entre_prod$apoy_agropec<- as.factor(org_entre_prod$apoy_agropec)
org_entre_prod$apoy_precios= as.factor(org_entre_prod$apoy_precios)
org_entre_prod$apoy_financ<- as.factor(org_entre_prod$apoy_financ)
org_entre_prod$otro_apoy<- as.factor(org_entre_prod$otro_apoy)
org_entre_prod$part_consejo_drsust<- as.factor(org_entre_prod$part_consejo_drsust)
org_entre_prod$part_com_sist_pd<- as.factor(org_entre_prod$part_com_sist_pd)
org_entre_prod$part_asoc_agr<- as.factor(org_entre_prod$part_asoc_agr)
org_entre_prod$part_asoc_ganad<- as.factor(org_entre_prod$part_asoc_ganad)
org_entre_prod$part_org_camp<- as.factor(org_entre_prod$part_org_camp)
org_entre_prod$part_org_empr<- as.factor(org_entre_prod$part_org_empr)
org_entre_prod$part_otra_asoc<- as.factor(org_entre_prod$part_otra_asoc)  

##Base de datos 16. TRD_CAPACITACION_ASISTENCIA_TECNICA
asist_tec = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_CAPACITACION_ASISTENCIA_TECNICA.CSV")
#Renombrar columnas
colnames(asist_tec)=c("id_cup","capacitacion","asist_tec","serv_otro_productor","serv_tec","serv_despacho",
                      "serv_academia","nomb_otra_inst","serv_otra_inst","con_rec_propios","con_rec_pub","con_rec_priv",
                      "con_rec_otra_inst","cap_agr","cap_cria_animal","cap_manejo_forestal","cap_recol_silv",
                      "cap_pesca_acui","nomb_otra_act","cap_otra_act","cap_prod","cap_transf","cap_comercial",
                      "cap_org","cap_diseño_proy","cap_admin","cap_financ","cap_prog_gob",
                      "cap_uni_manejo_amb","cap_otro_tema") 
#Convertir factores
asist_tec$id_cup= as.factor(asist_tec$id_cup)
asist_tec$capacitacion<- as.factor(asist_tec$capacitacion)
asist_tec$asist_tec<- as.factor(asist_tec$asist_tec)
asist_tec$serv_otro_productor<- as.factor(asist_tec$serv_otro_productor)
asist_tec$serv_tec<- as.factor(asist_tec$serv_tec)
asist_tec$serv_despacho<- as.factor(asist_tec$serv_despacho)
asist_tec$serv_academia<- as.factor(asist_tec$serv_academia)
asist_tec$serv_otra_inst<- as.factor(asist_tec$serv_otra_inst)
asist_tec$nomb_otra_inst<- as.factor(asist_tec$nomb_otra_inst)
asist_tec$con_rec_propios<- as.factor(asist_tec$con_rec_propios)
asist_tec$con_rec_pub<- as.factor(asist_tec$con_rec_pub)
asist_tec$con_rec_priv<- as.factor(asist_tec$con_rec_priv)
asist_tec$con_rec_otra_inst<- as.factor(asist_tec$con_rec_otra_inst)
asist_tec$cap_agr<- as.factor(asist_tec$cap_agr)
asist_tec$cap_cria_animal<- as.factor(asist_tec$cap_cria_animal)
asist_tec$cap_manejo_forestal<- as.factor(asist_tec$cap_manejo_forestal)
asist_tec$cap_recol_silv<- as.factor(asist_tec$cap_recol_silv)
asist_tec$cap_pesca_acui<- as.factor(asist_tec$cap_pesca_acui)
asist_tec$cap_otra_act<- as.factor(asist_tec$cap_otra_act)
asist_tec$nomb_otra_act<- as.factor(asist_tec$nomb_otra_act)
asist_tec$cap_prod<- as.factor(asist_tec$cap_prod)
asist_tec$cap_transf<- as.factor(asist_tec$cap_transf)
asist_tec$cap_comercial<- as.factor(asist_tec$cap_comercial)
asist_tec$cap_org<- as.factor(asist_tec$cap_org)
asist_tec$cap_diseño_proy<- as.factor(asist_tec$cap_diseño_proy)
asist_tec$cap_admin<- as.factor(asist_tec$cap_admin)
asist_tec$cap_financ<- as.factor(asist_tec$cap_financ)
asist_tec$cap_prog_gob<- as.factor(asist_tec$cap_prog_gob)
asist_tec$cap_uni_manejo_amb<- as.factor(asist_tec$cap_uni_manejo_amb)
asist_tec$cap_otro_tema<- as.factor(asist_tec$cap_otro_tema) 

##Base de datos 17. TRD_ORGANIZACION_MANEJO
org_manejo = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_ORGANIZACION_MANEJO.CSV")
#Renombrar columnas
colnames (org_manejo)= c("id_cup","org_indiv","org_esposa_hijos","org_gpo_coop","tot_gpo_coop","org_empresa","nomb_otra_org","tot_org_otra",
                         "part_fam","tot_part_fam", "menores_12","mjs_menores_12","12_18","mjs_12_18","18_60","mujs_18_60","mas_60",
                         "mujs_mas_60","contratadas","tot_contratadas","cont_6_mes","cont_6_mujs","cont_6_cerca","cont_6_edo",
                         "cont_6_otro_edo","cont_6_otro_pais","cont_menos6","mujs_menos6","cont_menos6_cerca","cont_menos6_edo",
                         "cont_menos6_otro_edo","cont_menos6_otro_pais", "prod_otra_empr","respon_otra_empr","prod_agrop_forest","prod_menos6",
                         "prod_6_meses", "lab_zona_cerca","lab_edo","lab_otro_edo","lab_otro_pais")
#Convertir factores
org_manejo$id_cup= as.factor(org_manejo$id_cup)
org_manejo$org_indiv<- factor(org_manejo$org_indiv)
org_manejo$org_esposa_hijos<- factor(org_manejo$org_esposa_hijos)
org_manejo$org_gpo_coop<- factor(org_manejo$org_gpo_coop)
org_manejo$org_empresa<- factor(org_manejo$org_empresa)
org_manejo$nomb_otra_org<- factor(org_manejo$nomb_otra_org)
org_manejo$part_fam<- factor(org_manejo$part_fam)
org_manejo$contratadas<- factor(org_manejo$contratadas)
org_manejo$cont_6_cerca<- factor(org_manejo$cont_6_cerca)
org_manejo$cont_6_edo<- factor(org_manejo$cont_6_edo)
org_manejo$cont_6_otro_edo<- factor(org_manejo$cont_6_otro_edo)
org_manejo$cont_6_otro_pais<- factor(org_manejo$cont_6_otro_pais)
org_manejo$cont_menos6_cerca<- factor(org_manejo$cont_menos6_cerca)
org_manejo$cont_menos6_edo<- factor(org_manejo$cont_menos6_edo)
org_manejo$cont_menos6_otro_edo<- factor(org_manejo$cont_menos6_otro_edo)
org_manejo$cont_menos6_otro_pais<- factor(org_manejo$cont_menos6_otro_pais)                                    
org_manejo$prod_otra_empr<- factor(org_manejo$prod_otra_empr)                                    
org_manejo$respon_otra_empr<- factor(org_manejo$respon_otra_empr)    
org_manejo$prod_agrop_forest<- factor(org_manejo$prod_agrop_forest) 
org_manejo$prod_menos6<- factor(org_manejo$prod_menos6)                                    
org_manejo$prod_6_meses<- factor(org_manejo$prod_6_meses)     
org_manejo$lab_zona_cerca<- factor(org_manejo$lab_zona_cerca)     
org_manejo$lab_edo<- factor(org_manejo$lab_edo)     
org_manejo$lab_otro_edo<- factor(org_manejo$lab_otro_edo)     
org_manejo$lab_otro_pais<- factor(org_manejo$lab_otro_pais)

#UNIÓN CUARTA SECCIÓN (4TA TABLA DE VARIABLES)
id_org_prod= merge(id_cafe, org_entre_prod)
id_org_manejo=merge(id_org_prod,org_manejo)
id_asist_tec= merge(id_org_manejo, asist_tec)



### QUINTA SECCIÓN (Bases de datos: 18 Y 19) ###
#Base de datos 18. ACTIVIDAD_PROBLEMATICA_PRINCIPAL
act_problem = read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_ACTIVIDAD_PROBLEMATICA_PRINCIPAL.CSV")
#Renombrar columnas
colnames(act_problem)=c("id_cup","principal_act","nomb_otra_act_","otra_act_principal","uso_camiones","uso_ferrocarril","uso_transp_aereo",
                        "uso_embarcaciones","nomb_otro_medio","uso_otro_medio","no_usa_medio","problem_acceso_cred","prior_acceso_cred",
                        "problem_perd_fertil","prior_perd_fertil","problem_perd_sin","prior_perd_sin",
                        "problem_dif_comercial","prior_dif_comercial","problem_organizacion","prior_organizacion",
                        "problem_inf_insuf","prior_inf_insuf","problem_costos_insumos","prior_costos_insumos",
                        "problem_falta_asist","prior_falta_asist","problem_litigio_tierra","prior_litigio_tierra",
                        "problem_falta_acred_tierra","prior_falta_acred_tierra","problem_otro","prior_problem_otro",
                        "act_diferente","act_es_extrac_aren_arcill","act_es_otro_mineral","act_es_turismo","act_es_indust",
                        "act_es_comercio","act_es_artesania","otra_act") 
#Convertir a factores
act_problem$id_cup<- as.factor(act_problem$id_cup)
act_problem$principal_act<- as.factor(act_problem$principal_act)
act_problem$nomb_otra_act<- as.factor(act_problem$nomb_otra_act)
act_problem$otra_act_principal<- as.factor(act_problem$otra_act_principal)
act_problem$uso_camiones<- as.factor(act_problem$uso_camiones)
act_problem$uso_ferrocarril<- as.factor(act_problem$uso_ferrocarril)
act_problem$uso_transp_aereo<- as.factor(act_problem$uso_transp_aereo)
act_problem$uso_embarcaciones<- as.factor(act_problem$uso_embarcaciones)
act_problem$nomb_otro_medio<- as.factor(act_problem$nomb_otro_medio)
act_problem$uso_otro_medio<- as.factor(act_problem$uso_otro_medio)
act_problem$no_usa_medio<- as.factor(act_problem$no_usa_medio)
act_problem$problem_acceso_cred<- as.factor(act_problem$problem_acceso_cred)
act_problem$prior_acceso_cred<- as.factor(act_problem$prior_acceso_cred)
act_problem$problem_perd_fertil<- as.factor(act_problem$problem_perd_fertil)
act_problem$prior_perd_fertil<- as.factor(act_problem$prior_perd_fertil)
act_problem$problem_perd_sin<- as.factor(act_problem$problem_perd_sin)
act_problem$prior_perd_sin<- as.factor(act_problem$prior_perd_sin)
act_problem$problem_dif_comercial<- as.factor(act_problem$problem_dif_comercial)
act_problem$prior_dif_comercial<- as.factor(act_problem$prior_dif_comercial)
act_problem$problem_organizacion<- as.factor(act_problem$problem_organizacion)
act_problem$prior_organizacion<- as.factor(act_problem$prior_organizacion)
act_problem$problem_inf_insuf<- as.factor(act_problem$problem_inf_insuf)
act_problem$prior_inf_insuf<- as.factor(act_problem$prior_inf_insuf) 
act_problem$problem_costos_insumos<- as.factor(act_problem$problem_costos_insumos)
act_problem$prior_costos_insumos<- as.factor(act_problem$prior_costos_insumos)
act_problem$problem_falta_asist<- as.factor(act_problem$problem_falta_asist)
act_problem$prior_falta_asist<- as.factor(act_problem$prior_falta_asist)
act_problem$problem_litigio_tierra<- as.factor(act_problem$problem_litigio_tierra)
act_problem$prior_litigio_tierra<- as.factor(act_problem$prior_litigio_tierra)
act_problem$problem_falta_acred_tierra<- as.factor(act_problem$problem_falta_acred_tierra)
act_problem$prior_falta_acred_tierra<- as.factor(act_problem$prior_falta_acred_tierra)
act_problem$problem_otro<- as.factor(act_problem$problem_otro)
act_problem$prior_problem_otro<- as.factor(act_problem$prior_problem_otro)
act_problem$act_diferente<- as.factor(act_problem$act_diferente)
act_problem$act_es_extrac_aren_arcill<- as.factor(act_problem$act_es_extrac_aren_arcill)
act_problem$act_es_otro_mineral<- as.factor(act_problem$act_es_otro_mineral)
act_problem$act_es_turismo<- as.factor(act_problem$act_es_turismo)
act_problem$act_es_indust<- as.factor(act_problem$act_es_indust)
act_problem$act_es_comercio<- as.factor(act_problem$act_es_comercio)
act_problem$act_es_artesania<- as.factor(act_problem$act_es_artesania)
act_problem$otra_act<- as.factor(act_problem$otra_act)

##Base de datos 19. TRD_CARACTTERISTICAS_SOCIODEMOGRAFICAS
caract_sociodemo= read.csv("Z:\\Procesamiento\\Insumos\\Censo Agropecuario\\TRD_CARACTTERISTICAS_SOCIODEMOGRAFICAS.CSV")
#Renombrar columnas
colnames (caract_sociodemo) =c("id_cup","ingresos_act_agr_forest","import_proced_ingresos","ingresos_envio_dinero","import_envio_dinero",
                               "ingresos_apoy_gob","import_apoy_gob","ingresos_otra_act","import_otra_act","dinero_env_hermano",
                               "dinero_env_hijo", "dinero_env_padres","dinero_env_esposos","dinero_env_otro_fam","nomb_otra","dinero_otra_fuente","verif_genero",
                               "edad_productor","verif_habla_esp","prod_lengua_ind","lengua_ind","padres_lengua_ind", "pareja_lengua_ind", "prod_escuela",
                               "ning_grado_aprob","grado_aprob_primaria","grado_aprob_secu","grado_aprob_bachill","grado_aprob_bachill_año",
                               "otro_nivel_est","depend_economicos","depend_menores_18","depend_mujeres_menores_18","depend_mayores_18",
                               "depend_mujeres_mayores_18","vivienda_agua_entubada","vivienda_drenaje_red_pub","vivienda_drenaje_fosa_sep",
                               "vivienda_energ_elec","vivienda_gas","vivienda_sanitario","vivienda_piso","vivienda_paredes") 
#Convertir a factores
caract_sociodemo$id_cup<- as.factor(caract_sociodemo$id_cup)
caract_sociodemo$ingresos_act_agr_forest<- as.factor(caract_sociodemo$ingresos_act_agr_forest)
caract_sociodemo$import_proced_ingresos<- as.factor(caract_sociodemo$import_proced_ingresos)
caract_sociodemo$ingresos_envio_dinero<- as.factor(caract_sociodemo$ingresos_envio_dinero) 
caract_sociodemo$import_envio_dinero<- as.factor(caract_sociodemo$import_envio_dinero)
caract_sociodemo$ingresos_apoy_gob<- as.factor(caract_sociodemo$ingresos_apoy_gob)
caract_sociodemo$import_apoy_gob<- as.factor(caract_sociodemo$import_apoy_gob)
caract_sociodemo$ingresos_otra_act<- as.factor(caract_sociodemo$ingresos_otra_act)
caract_sociodemo$import_otra_act<- as.factor(caract_sociodemo$import_otra_act) 
caract_sociodemo$dinero_env_hermano<- as.factor(caract_sociodemo$dinero_env_hermano)
caract_sociodemo$dinero_env_hijo<- as.factor(caract_sociodemo$dinero_env_hijo)
caract_sociodemo$dinero_env_padres<- as.factor(caract_sociodemo$dinero_env_padres)
caract_sociodemo$dinero_env_esposos<- as.factor(caract_sociodemo$dinero_env_esposos)
caract_sociodemo$dinero_env_otro_fam<- as.factor(caract_sociodemo$dinero_env_otro_fam)
caract_sociodemo$nomb_otra<- as.factor(caract_sociodemo$nomb_otra)
caract_sociodemo$dinero_otra_fuente<- as.factor(caract_sociodemo$dinero_otra_fuente)
caract_sociodemo$verif_genero<- as.factor(caract_sociodemo$verif_genero)
caract_sociodemo$verif_habla_esp<- as.factor(caract_sociodemo$verif_habla_esp)
caract_sociodemo$prod_lengua_ind<- as.factor(caract_sociodemo$prod_lengua_ind) 
caract_sociodemo$lengua_ind<- as.factor(caract_sociodemo$lengua_ind) 
caract_sociodemo$padres_lengua_ind<- as.factor(caract_sociodemo$padres_lengua_ind)
caract_sociodemo$pareja_lengua_ind<- as.factor(caract_sociodemo$pareja_lengua_ind)
caract_sociodemo$prod_escuela<- as.factor(caract_sociodemo$prod_escuela)
caract_sociodemo$ning_grado_aprob<- as.factor(caract_sociodemo$ning_grado_aprob)
caract_sociodemo$grado_aprob_primaria<- as.factor(caract_sociodemo$grado_aprob_primaria) 
caract_sociodemo$grado_aprob_secu<- as.factor(caract_sociodemo$grado_aprob_secu)
caract_sociodemo$grado_aprob_bachill<- as.factor(caract_sociodemo$grado_aprob_bachill)
caract_sociodemo$grado_aprob_bachill_año<-as.factor(caract_sociodemo$grado_aprob_bachill_año)
caract_sociodemo$otro_nivel_est<- as.factor(caract_sociodemo$otro_nivel_est)
caract_sociodemo$vivienda_agua_entubada<- as.factor(caract_sociodemo$vivienda_agua_entubada)
caract_sociodemo$vivienda_drenaje_red_pub<- as.factor(caract_sociodemo$vivienda_drenaje_red_pub)
caract_sociodemo$vivienda_drenaje_fosa_sep<- as.factor(caract_sociodemo$vivienda_drenaje_fosa_sep) 
caract_sociodemo$vivienda_energ_elec<- as.factor(caract_sociodemo$vivienda_energ_elec)
caract_sociodemo$vivienda_gas<- as.factor(caract_sociodemo$vivienda_gas)
caract_sociodemo$vivienda_sanitario<- as.factor(caract_sociodemo$vivienda_sanitario)
caract_sociodemo$vivienda_piso<- as.factor(caract_sociodemo$vivienda_piso)
caract_sociodemo$vivienda_paredes<- as.factor(caract_sociodemo$vivienda_paredes)

#UNIÓN QUINTA SECCIÓN (5TA TABLA DE VARIABLES)
id_problematica= merge(id_cafe,act_problem)
id_sociodemo= merge(id_problematica, caract_sociodemo)

###############          TABLA DE AGREGACIÓN          #############

#Por motivos de confidencialidad se agregaron los datos reportados por unidad de producción al siguiente nivel espacial, que es AGEB rural.
#La agregación se llevó a cabo utilizando el promedio para las variables numéricas y la frecuencia para cada una de las respuestas de las variables categóricas; y como resultado se obtuvo una tabla de agregación.
#Es importante señalar que agregaciones se fueron haciendo inmediatamente después de la unión de las bases de datos que correspondían a cada sección (paso anterior). 

######AGREGACIÓN DE VARIABLES#######      PRIMERA SECCIÓN
#Numéricas
library(tidyr)
library(tidyverse)
library(dbplyr)
datos_agg = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad"))
mean_num = datos_agg %>% summarise_if(is.numeric, mean, na.rm = TRUE)

#factores
library(tidyr)
####################################################################################
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "sem_trans"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sem_trans, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "sem_trans_0","sem_trans_1","sem_trans_2")
merged_all= merge(mean_num, summ_cat)
####################################################################################
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "ctrl_bio"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = ctrl_bio, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "Ctrl_bio_1","Ctrl_bio_2")
merged_all= merge(mean_num, summ_cat)
####################################################################################
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "injerto_arb"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = injerto_arb, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","injerto_arb_1","injerto_arb_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "rotacion_cult"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = rotacion_cult, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","rotacion_cult_1","rotacion_cult_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "podas"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = podas, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB", "Localidad","podas_1","podas_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "otra_tec"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_tec, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","otra_tec_0")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "intercal"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = intercal, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","intercal_1","intercal_2","NA")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "parte_cultivada"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = parte_cultivada, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","parte_cultivada_1")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "con_empresa"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = con_empresa, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","con_empresa_1","con_empresa_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "empacadora"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = empacadora, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad","Municipio","AGEB","Localidad","empacadora_0","empacadora_1","empacadora_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "agroindustria"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = agroindustria, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","agroindustria_0","agroindustria_1","agroindustria_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "comercializadora"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = comercializadora, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","comercializadora_0","comercializadora_1","comercializadora_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "otra_indust"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_indust, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","otra_indust_0","otra_indust_1","otra_indust_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "sin_semb_PV"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sin_semb_PV, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","sin_semb_PV_1","sin_semb_PV_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "no_intereso"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = no_intereso, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","no_intereso_0","no_intereso_1")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "falta_dinero"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = falta_dinero, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","falta_dinero_0","falta_dinero_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "mal_temporal"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = mal_temporal, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","mal_temporal_0","mal_temporal_3")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "no_hubo_quien_semb"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = no_hubo_quien_semb, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","no_hubo_quien_semb_0","no_hubo_quien_semb_4")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "estaba_invadida"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = estaba_invadida, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","estaba_invadida_0","estaba_invadida_5")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "suelo_poco_fertil"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = suelo_poco_fertil, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","suelo_poco_fertil_0","suelo_poco_fertil_6")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "suelo_erosionado"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = suelo_erosionado, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","suelo_erosionado_0","suelo_erosionado_7")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "descanso"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = descanso, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","descanso_0","descanso_8")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "otra_causa"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_causa, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","otra_causa_0","otra_causa_9")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "benefic_cafe_cacao"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = benefic_cafe_cacao, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","benefic_cafe_1","benefic_cafe_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "vivero"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = vivero, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","vivero_1","vivero_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "invernadero"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = invernadero, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","invernadero_1","invernadero_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "sel_semilla"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sel_semilla, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","sel_semilla_1","sel_semilla_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "consumo_fam"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = consumo_fam, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","consumo_fam_1","consumo_fam_2","consumo_fam_3")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "consumo_animal"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = consumo_animal, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","consumo_anim_0","consumo_anim_1","consumo_anim_2","consumo_anim_3")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "venta"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = venta, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad", "venta_0","venta_1","venta_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "venta_intermediario"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = venta_intermediario, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","venta_inter_0","venta_inter_1","venta_inter_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "venta_mayorista"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = venta_mayorista, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","venta_may_0","venta_may_1","venta_may_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "venta_cadena_comercial"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = venta_cadena_comercial, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","venta_comer_0","venta_comer_1","venta_comer_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "venta_empaca_agroindust"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = venta_empaca_agroindust, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","venta_agroi_0","venta_agroi_1","venta_agroi_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "venta_otro_comprador"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = venta_otro_comprador, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","venta_otro_0","venta_otro_1","venta_otro_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "venta_extranj"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = venta_extranj, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","venta_extranj_0","venta_extranj_1","venta_extranj_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "procesa_transforma"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = procesa_transforma, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","procesa_transforma_0","procesa_transforma_1","procesa_transforma_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_instal, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "venta_produc_obt"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = venta_produc_obt, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","venta_produc_obt_0","venta_produc_obt_1","venta_produc_obt_2")
merged_all= merge(merged_all, summ_cat) ##PRIMERA TABLA DE AGREGACIÓN
#Se guardó en un archivo csv
write.csv(merged_all,"Z:\\Procesamiento\\Trabajo\\cafe_primeraparte.csv")



######AGREGACIÓN DE VARIABLES#######        SEGUNDA SECCIÓN 
#Numéricos 
datos_agg = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad"))
mean_num_2 = datos_agg %>% summarise_if(is.numeric, mean, na.rm = TRUE)

#Factores
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "canales_recub"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = canales_recub, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","canales_recub_0","canales_recub_1","canales_recub_2")
merged_all= merge(mean_num_2, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "canales_tierra"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = canales_tierra, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","canales_tierra_0","canales_tierra_1","canales_tierra_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "sist_aspersion"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sist_aspersion, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","sist_aspersion_0","sist_aspersion_1","sist_aspersion_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "sist_microaspersion"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sist_microaspersion, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","sist_microaspersion_0","sist_microaspersion_1","sist_microaspersion_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "sist_goteo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sist_goteo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","sist_goteo_0","sist_goteo_1","sist_goteo_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","sist_otro"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sist_otro, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","sist_otro_0","sist_otro_1","sist_otro_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prov_bordo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prov_bordo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prov_bordo_0","prov_bordo_1","prov_bordo_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prov_rio"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prov_rio, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prov_rio_0","prov_rio_1","prov_rio_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prov_pozo_cielo_abierto"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prov_pozo_cielo_abierto, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prov_pozo_cielo_ab_0","prov_pozo_cielo_ab_1","prov_pozo_cielo_ab_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "otra_fuente"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_fuente, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","otra_fuente_0","otra_fuente_1","otra_fuente_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prov_manantial"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prov_manantial, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prov_manantial_0","prov_manantial_1","prov_manantial_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prov_presa"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prov_presa, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prov_presa_0","prov_presa_1","prov_presa_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "agua_blanca"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = agua_blanca, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","agua_blanca_0","agua_blanca_1","agua_blanca_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "agua_negra"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = agua_negra, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","agua_negra_0","agua_negra_1","agua_negra_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","agua_tratada"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = agua_tratada, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","agua_trat_0","agua_trat_1","agua_trat_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "no_sabe"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = no_sabe, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","no_sabe_0","no_sabe_3")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "animales_o_tronco_o_yunta"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = animales_o_tronco_o_yunta, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","anim_1","anim_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "animales_propios"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = animales_propios, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","anim_propios_0","anim_propios_1","anim_propios_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","tractor"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = tractor, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","tractor_1","tractor_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "sembro_coa_o_azadon_o_herramienta"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sembro_coa_o_azadon_o_herramienta, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","herramienta_0","herramienta_1","herramienta_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "enmontada"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = enmontada, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","enmontada_1","enmontada_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","cort_arb_enmon"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cort_arb_enmon, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cor_arb_en_0","cor_arb_en_1","cor_arb_en_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","sin_veg"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sin_veg, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","sin_veg_0","sin_veg_1","sin_veg_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "arenales_pedregales"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = arenales_pedregales, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","arenal_pedregal_0","arenal_pedregal_1","arenal_pedregal_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "ensalitrada"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = ensalitrada, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","ensalitrada_0", "ensalitrada_1","ensalitrada_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","erosionada"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = erosionada, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","erosionada_0","erosionada_1","erosionada_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "cubierta_agua"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cubierta_agua, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cub_agua_0","cub_agua_1","cub_agua_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","contaminada"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = contaminada, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","contaminada_0","contaminada_1","contaminada_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","otra_sin_veg"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_sin_veg, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","otra_sin_veg_0","otra_sin_veg_1","otra_sin_veg_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad","selva"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = selva, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","selva_1","selva_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "bosque"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
#str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = bosque, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","bosque_0","bosque_1","bosque_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "cort_arb_sb"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cort_arb_sb, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cort_arb_sb_0","cort_arb_sb_1","cort_arb_sb_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "pastoreo_sb"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = pastoreo_sb, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","pastoreo_sb_0","pastoreo_sb_1","pastoreo_sb_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "reforesta_sb"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = reforesta_sb, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","refor_sb_0","refor_sb_1","refor_sb_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "refores_spp_rg"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = refores_spp_rg, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","refor_spp_rg_0","refor_spp_rg_1","refor_spp_rg_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "plant_fuera"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = plant_fuera, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","arb_fuera_0","arb_fuera_1","arb_fuera_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "arb_lind_disper"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = arb_lind_disper, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","arb_lind_disp_0","arb_lind_disp_1","arb_lind_disp_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","arb_terrenos_prod"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = arb_terrenos_prod, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","arb_terr_prod_0","arb_terr_prod_1","arb_terreno_prod_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","arb_terr_lind_disp"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = arb_terr_lind_disp, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","arb_terr_lind_0","arb_terr_lind_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_bosque, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","plant_spp_rg"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = plant_spp_rg, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","plant_spp_reg_0","plant_spp_reg_1","plant_spp_region_2")
merged_all= merge(merged_all, summ_cat)###SEGUNDA TABLA DE AGREGACIÓN
#Guardar en archivo CSV
write.csv(merged_all,"Z:\\Procesamiento\\Trabajo\\cafe_segundaparte.csv")



######AGREGACIÓN DE VARIABLES#######      TERCERA SECCIÓN 
#Numéricos
datos_agg = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad"))
mean_num_3 = datos_agg %>% summarise_if(is.numeric, mean, na.rm = TRUE)

#Factores
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "arb_corte_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = arb_corte_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","arb_corte_b_0","arb_corte_b_1","arb_corte_b_2")
merged_all= merge(mean_num_3, summ_cat)
####################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "aclareo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = aclareo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","aclareo_b_0","aclareo_b_1","aclareo_b_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "herb_quim_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
#str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = herb_quim_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","h_quim_b_0","h_quim_b_1","h_quim_b_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","herb_org_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
#str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = herb_org_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","h_org_b_0","h_org_b_1","h_org_b_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "insec_quim_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
#str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = insec_quim_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","i_quim_b_0","i_quim_b_1","i_quim_b_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "insec_org_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
#str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = insec_org_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","i_org_b_0","i_org_b_1","i_org_b_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "ctrl_incendio_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
#str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = ctrl_incendio_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","ctrl_inc_b_0","ctrl_inc_b_1","ctrl_inc_b_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "ctrl_bio_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
#str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = ctrl_bio_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","ctrl_bio_b_0","ctrl_bio_b","ctrl_bio_b_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "quema_ctrl_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
#str(datos_cat)
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = quema_ctrl_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","quem_ctrl_b_0","quem_ctrl_b_1","quem_ctrl_b_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad","asist_tecno_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = asist_tecno_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","asist_tec_b_0","asist_tec_b_1","asist_tec_b_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad","otra_tecno_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_tecno_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","otra_tec_b_0","otra_tec_b_1","otra_tec_b_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad","aserradero_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = aserradero_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","aserr_b_0","aserr_b_1","aserr_b_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","vivero_forestal"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = vivero_forestal, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","vivero_fores_l_0","vivero_fores_1","vivero_fores_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "sec_madera"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sec_madera, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","sec_madera_0","sec_madera_1","sec_madera_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad","otra_instal_b"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_instal_b, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","otra_inst_b_0","otra_inst_b_1","otra_inst_b_2")
merged_all= merge(merged_all, summ_cat) 
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad","desmonte_sb"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = desmonte_sb, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","desmonte_sb_0","desmonte_sb_1","desmonte_sb_2")
merged_all= merge(merged_all, summ_cat) 
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad","cred_prestamo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cred_prestamo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cred_prestamo_0","cred_prestamo_1","cred_prestamo_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "banca_comercial"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = banca_comercial, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","banca_comercial_0","banca_comercial_1","banca_comercial_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "sofol"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = sofol, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","sofol_0","sofol_1","sofol_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "union_cred"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = union_cred, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","union_cred_0","union_cred_1","union_cred_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "financiera_rural"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = financiera_rural, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","financiera_rural_0","financiera_rural_1","financiera_rural_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","otra_fuente"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_fuente, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","otra_fuente_b_1","otra_fuente_b_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","fondos_fira"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = fondos_fira, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","fondos_fira_0","fondos_fira_1","fondos_fira_2", "fondos_fira_3")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","cred_avio"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cred_avio, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "cred_avio_0","cred_avio_1","cred_avio_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "cred_refaccionario"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cred_refaccionario, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "cred_refac_0","cred_refac_1","cred_refac_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","cred_otro"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cred_otro, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "cred_otro_0","cred_otro_1","cred_otro_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "seguro"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = seguro, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "seguro_0","seguro_1","seguro_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","seg_agroasemex"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = seg_agroasemex, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","seg_agroasemex_0","seg_agroasemex_1","seg_agroasemex_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "seg_otra_aseg"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = seg_otra_aseg, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "seg_otra_aseg_0","seg_otra_aseg_1","seg_otra_aseg_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "apoyo_gob"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoyo_gob, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","apoyo_gob_0","apoyo_gob_1","apoyo_gob_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","procampo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = procampo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "procampo_0","procampo_1","procampo_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prog_ganadero"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_ganadero, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","prog_ganadero_0","prog_ganadero_1","prog_ganadero_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prog_diesel"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_diesel, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "prog_diesel_0","prog_diesel_1","prog_diesel_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prog_apoy_direc"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_apoy_direc, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "prog_apoy_direc_0","prog_apoy_direc_1","prog_apoy_direc_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prog_inv_rural"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_inv_rural, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","prog_inv_rural_0","prog_inv_rural_1","prog_inv_rural_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prog_desarrollo_rural"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_desarrollo_rural, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","prog_d_rural_0","prog_d_rural_1","prog_d_rural_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prog_desarrollo_cap"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_desarrollo_cap, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "prog_d_cap_0","prog_d_cap_1","prog_d_cap_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prog_fomento_agr"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_fomento_agr, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "prog_fomento_agr_0","prog_fomento_agr_1","prog_fomento_agr_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "mujer_sect_agr"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = mujer_sect_agr, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "mujer_sect_agr_0","mujer_sect_agr_1","mujer_sect_agr_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prodefor"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prodefor, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","prodefor_0","prodefor_1","prodefor_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","conafor"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = conafor, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "conafor_0","conafor_1","conafor_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prog_acua_pesca"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_acua_pesca, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "prog_acua_pesca_0","prog_acua_pesca_1","prog_acua_pesca_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################  
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prog_jornaleros_agr"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_jornaleros_agr, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","prog_jornal_0","prog_jornal_1","prog_jornal_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prog_empleo_temp"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_empleo_temp, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "prog_empleo_0","prog_empleo_1","prog_empleo_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prog_vivienda_rural"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_vivienda_rural, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prog_viv_rural_0","prog_viv_rural_1","prog_viv_rural_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","seguro_popular"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = seguro_popular, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","seg_pop_0","seg_popular_1","seg_pop_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "oportunidades"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = oportunidades, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prog_oport_0","prog_oport_1","prog_oport_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prog_opc_prod"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_opc_prod, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prog_opc_prod_0","prog_opc_prod_1","prog_opc_prod_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "fondo_proy_prod"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = fondo_proy_prod, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","fondo_proy_0","fondo_proy_1","fondo_proy_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prog_infraest_hidroagr"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_infraest_hidroagr, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prog_inf_hid_0","prog_inf_hid_1","prog_inf_hid_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad", "prog_equidad_genero_indigenas"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prog_equidad_genero_indigenas, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prog_eq_g_ind_0","prog_eq_g_ind_1","prog_eq_g_ind_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","apoy_otro_prog"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoy_otro_prog, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","apoy_otro_prog_0","apoy_otro_prog_1","apoy_otro_prog_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prog_fondos_reg_indigenas"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,6)], key = prog_fondos_reg_indigenas, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prog_fond_r_ind_0","prog_fond_r_ind_1","prog_fond_r_ind_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","ahorro_ingresos"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = ahorro_ingresos, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","ahorro_ingresos_0","ahorro_ingresos_1","ahorro_ingresos_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "con_banca_comercial"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = con_banca_comercial, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","con_banca_comercial_0","con_banca_comercial_1","con_banca_comercial_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","con_banca_publica"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = con_banca_publica, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","con_banca_publica_0","con_banca_publica_1","con_banca_publica_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","con_union_cred"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = con_union_cred, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","con_union_cred_0","con_union_cred_1","con_union_cred_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","con_caja_ahorro"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = con_caja_ahorro, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","con_caja_ahorro_0","con_caja_ahorro_1","con_caja_ahorro_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_apoyos, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "con_otra_inst"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = con_otra_inst, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","con_otra_inst_0","con_otra_inst_1","con_otra_inst_2")
merged_all= merge(merged_all, summ_cat)###TERCERA TABLA DE AGREGACIÓN
#Guardar en archivo CSV
write.csv(merged_all,"Z:\\Procesamiento\\Trabajo\\cafe_terceraparte.csv")


######AGREGACIÓN DE VARIABLES#######       CUARTA SECCIÓN 
#Numéricas
library(dplyr)
datos_agg = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad"))
mean_num_4 = datos_agg %>% summarise_if(is.numeric, mean, na.rm = TRUE)

#####factores
library(tidyr)
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","capacitacion"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = capacitacion, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","capacitacion_0","capacitacion_1","capacitacion_2")
merged_all= merge(mean_num_4, summ_cat)
####################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "asist_tec"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = asist_tec, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","asist_tec_0","asist_tec_1","asist_tec_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "serv_tec"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = serv_tec, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","serv_tec_0","serv_tec_1","serv_tec_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "serv_despacho"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = serv_despacho, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","serv_desp_0","serv_desp_1","serv_desp_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","serv_academia"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = serv_academia, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","serv_acad_0","serv_acad_1","serv_acad_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "serv_otra_inst"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = serv_otra_inst, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","serv_o_inst_0","serv_o_inst_1","serv_o_inst_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "serv_otro_productor"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = serv_otro_productor, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","serv_o_prod_0","serv_o_prod_1","serv_o_prod_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "con_rec_propios"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = con_rec_propios, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","rec_prop_0","rec_prop_1","rec_prop_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "org_para_apoyos"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = org_para_apoyos, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","org_apoy_0","org_apoy_1","org_apoy_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","gpo_apoy"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = gpo_apoy, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","gpo_apoy_0","gpo_apoy_1")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "socied_rural"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = socied_rural, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","soc_rural_0","soc_rural_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "socied_coop"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = socied_coop, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","soc_coop_0","soc_coop_3")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "socied_civil"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = socied_civil, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","soc_civil_0","soc_civil_4")
merged_all= merge(merged_all, summ_cat) 
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "solid_social"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = solid_social, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","sol_social_0","sol_social_5")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "union_cred"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = union_cred, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","union_cred_0","union_cred_6")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "coop_ahorro_cred"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = coop_ahorro_cred, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","coop_ah_cred_0","coop_ah_cred_7")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "socied_anon"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = socied_anon, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","soc_anon_0","soc_anon_8")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","asoc_ganad"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = asoc_ganad, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","asoc_gd_0","asoc_gd_9")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "asoc_agric"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = asoc_agric, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","asoc_agr_0","asoc_agr_10")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "union_agr_rg"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = union_agr_rg, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","union_agr_rg_0","AGEB,union_agr_rg_11")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","union_gd_rg"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = union_gd_rg, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","union_gd_rg_0","AGEB,union_gd_rg_12")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "asoc_sivic"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = asoc_sivic, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "asoc_sivic_0","asoc_sivic_13")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","union_soc_rural"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = union_soc_rural, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","union_soc_rl_0","union_soc_rl_14")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "otra_org"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_org, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","otra_org_0","otra_org_15")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "apoy_insumos"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoy_insumos, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "apoy_insumos_0","apoy_insumos_1","apoy_insumos_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","apoy_asist_tec"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoy_asist_tec, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "apoy_asist_tec_0","apoy_asist_tec_1","apoy_asist_tec_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","apoy_prod_contrato"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoy_prod_contrato, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","apoy_prod_0","apoy_prod_1","apoy_prod_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","apoy_comercial"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoy_comercial, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "apoy_comer_0","apoy_comer_1","apoy_comer_2")
merged_all= merge(merged_all, summ_cat)  
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "apoy_agropec"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoy_agropec, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","apoy_sg_agr_0","apoy_sg_agr_1","apoy_sg_agr_2")
merged_all= merge(merged_all, summ_cat) 
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","apoy_precios"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoy_precios, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "apoy_precios_0","apoy_precios_1","apoy_precios_2")
merged_all= merge(merged_all, summ_cat) 
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad","apoy_financ"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = apoy_financ, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "apoy_financ_0","apoy_financ_1","apoy_financ_2")
merged_all= merge(merged_all, summ_cat) 
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "otro_apoy"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otro_apoy, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","otro_apoy_0","otro_apoy_1","otro_apoy_2")
merged_all= merge(merged_all, summ_cat) 
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "part_asoc_ganad"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = part_asoc_ganad, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","part_asoc_gd_0","part_asoc_gd_1","part_asoc_gd_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "part_asoc_agr"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = part_asoc_agr, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","part_asoc_agr_0","part_asoc_agr_1","part_asoc_agr_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "part_org_camp"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = part_org_camp, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","part_org_camp_0","part_org_camp_1","part_org_camp_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "part_org_empr"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = part_org_empr, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","part_org_empr_0","part_org_empr_1","part_org_empr_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "part_com_sist_pd"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = part_com_sist_pd, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","part_com_sist_pd_0","part_com_sist_pd_1","part_com_sist_pd_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "part_otra_asoc"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = part_otra_asoc, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","part_otra_asoc_0","part_otra_asoc_1","part_otra_asoc_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "org_indiv"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = org_indiv, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","org_indiv_0","org_indiv_1","org_indiv_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "org_esposa_hijos"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = org_esposa_hijos, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad", "org_esposa_hij_0","org_esposa_hij_1","org_esposa_hij_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","org_gpo_coop"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = org_gpo_coop, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","org_gpo_coop_0","org_gpo_coop_1","org_gpo_coop_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "org_empresa"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = org_empresa, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","org_empresa_0","org_empresa_1","org_empresa_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "part_fam"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = part_fam, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","part_fam_0","part_fam_1","part_fam_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","contratadas"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = contratadas, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","contratadas_0","contratadas_1","contratadas_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "cont_6_cerca"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cont_6_cerca, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cont_6_cerca_0","cont_6_cerca_1","cont_6_cerca_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "cont_6_edo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cont_6_edo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cont_6_edo_0","cont_6_edo_1","cont_6_edo_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "cont_6_otro_edo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cont_6_otro_edo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cont_6_otro_edo_0","cont_6_otro_edo_1","cont_6_otro_edo_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","cont_6_otro_pais"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cont_6_otro_pais, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cont_6_otro_pais_0","cont_6_otro_pais_1","cont_6_otro_pais_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","cont_menos6_cerca"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cont_menos6_cerca, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cont_menos6_cerca_0","cont_menos6_cerca_1","cont_menos6_cerca_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "cont_menos6_edo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cont_menos6_edo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cont_menos6_edo_0","cont_menos6_edo_1","cont_menos6_edo_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "cont_menos6_otro_edo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cont_menos6_otro_edo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cont_menos6_otro_edo_0","cont_menos6_otro_edo_1","cont_menos6_otro_edo_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","cont_menos6_otro_pais"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = cont_menos6_otro_pais, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","cont_menos6_otro_pais_0","cont_menos6_otro_pais_1","cont_menos6_otro_pais_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prod_otra_empr"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prod_otra_empr, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prod_otra_empr_0","prod_otra_empr_1","prod_otra_empr_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","respon_otra_empr"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = respon_otra_empr, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","respon_otra_empr_0")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prod_6_meses"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prod_6_meses, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prod_6_meses_0","prod_6_meses_2")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prod_menos6"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prod_menos6, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prod_menos6_0","prod_menos6_1")
merged_all= merge(merged_all, summ_cat)
################################################################################### 
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "lab_zona_cerca"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = lab_zona_cerca, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB", "Localidad","lab_zona_cerca_0","lab_zona_cerca_1","lab_zona_cerca_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","lab_edo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = lab_edo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","lab_edo_0","lab_edo_1","lab_edo_2") 
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB","Localidad","lab_otro_edo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = lab_otro_edo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","lab_otro_edo_0","lab_otro_edo_1","lab_otro_edo_2")
merged_all= merge(merged_all, summ_cat)
###################################################################################
datos_cat = group_by(id_asist_tec, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","lab_otro_pais"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = lab_otro_pais, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","lab_otro_pais_0","lab_otro_pais_1","lab_otro_pais_2") 
merged_all= merge(merged_all, summ_cat) ###CUARTA TABLA DE AGREGACIÓN
#Guardar en archivo CSV
write.csv(merged_all,"Z:\\Procesamiento\\Trabajo\\cafe_cuartaparte.csv")


######AGREGACIÓN DE VARIABLES########       QUINTA SECCIÓN
#Numéricas
datos_agg = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad"))
mean_num_5 = datos_agg %>% summarise_if(is.numeric, mean, na.rm = TRUE)

#####factores
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "principal_act"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = principal_act, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","prin_act_0","prin_act_1","prin_act_2","prin_act_3","prin_act_4", "prin_act_5")
merged_all= merge(mean_num_5, summ_cat)
####################################################################################
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "otra_act_principal"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = otra_act_principal, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","otra_prin_0","otra_prin_5")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "uso_camiones"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = uso_camiones, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","uso_camiones_0","uso_camiones_1","uso_camiones_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "uso_ferrocarril"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = uso_ferrocarril, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","ferrocarril_0","ferrocarril_1","ferrocarril_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "uso_transp_aereo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = uso_transp_aereo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","aereo_0","aereo_1","aereo_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "uso_embarcaciones"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = uso_embarcaciones, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","embarcaciones_0","embarcaciones_1","embarcaciones_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "uso_otro_medio"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = uso_otro_medio, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad", "otro_medio_0","otro_medio_1","otro_medio_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "no_usa_medio"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = no_usa_medio, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad", "no_medio_0","no_medio_3")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","problem_acceso_cred"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = problem_acceso_cred, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB", "Localidad","pro_acc_cred_0","pro_acc_cred_1")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prior_acceso_cred"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prior_acceso_cred, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_acc_cred_0")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","problem_perd_fertil"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = problem_perd_fertil, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio", "AGEB","Localidad","pro_perd_fertil_0","pro_perd_fertil_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prior_perd_fertil"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key = prior_perd_fertil, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_perd_fertil_0")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "problem_perd_sin"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_perd_sin, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_perd_sin_0","pro_perd_sin_3")
merged_all= merge(merged_all, summ_cat) 
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prior_perd_sin"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_perd_sin, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_perd_sin_0")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","problem_dif_comercial"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_dif_comercial, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_dif_comerc_0","pro_dif_comerc_4")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prior_dif_comercial"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_dif_comercial, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_dif_comercial_0")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad","problem_organizacion"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_organizacion, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_org_0","pro_org_5")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","prior_organizacion"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_organizacion, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_org_0")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","problem_inf_insuf"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_inf_insuf, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_infrae_0","pro_infrae_6")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prior_inf_insuf"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_inf_insuf, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_infrae_0")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","problem_costos_insumos"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_costos_insumos, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_c_insumos_0","pro_c_insumos_7")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prior_costos_insumos"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_costos_insumos, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_costos_insumos_0")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","problem_falta_asist"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_falta_asist, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_asist_0","pro_asist_8")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prior_falta_asist"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_falta_asist, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_falta_asist_0")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "problem_litigio_tierra"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_litigio_tierra, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_lit_t_0","pro_lit_t_9")
merged_all= merge(merged_all, summ_cat) 
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prior_litigio_tierra"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_litigio_tierra, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_litigio_t_0")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "problem_falta_acred_tierra"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_falta_acred_tierra, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_acred_t_0"," pro_acred_t_10")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prior_falta_acred_tierra"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_falta_acred_tierra, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_falta_acred_tierra_0")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "problem_otro"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =problem_otro, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pro_otro_0","pro_otro_11")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prior_problem_otro"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prior_problem_otro, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","prior_problem_otro_0")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","act_diferente"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =act_diferente, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","act_dif_0","act_dif_1","act_dif_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "act_es_extrac_aren_arcill"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =act_es_extrac_aren_arcill, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","ex_aren_0","ex_aren__1","ex_aren__2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "act_es_otro_mineral"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =act_es_otro_mineral, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","otro_min_0","otro_min_1","otro_min_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "act_es_turismo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =act_es_turismo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","turismo_0","turismo_1","turismo_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "act_es_indust"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =act_es_indust, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","act_indust_0","act_indust_1","act_indust_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "act_es_comercio"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =act_es_comercio, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","comercio_0","comercio_1","comercio_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "act_es_artesania"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =act_es_artesania, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","artesania_0","artesania_1","artesania_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "otra_act"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =otra_act, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","otra_act_p_0","otra_act_1_p","otra_act_2_p")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "ingresos_act_agr_forest"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =ingresos_act_agr_forest, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","i_act_agr_f_0","i_act_agr_f_1")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "import_proced_ingresos"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =import_proced_ingresos, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","import_proced_ing_0","import_proced_ing_1")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "ingresos_envio_dinero"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =ingresos_envio_dinero, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","i_env_dinero_0","i_env_dinero_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "import_envio_dinero"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =import_envio_dinero, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","import_env_dinero_0","import_env_dinero_1")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "ingresos_apoy_gob"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =ingresos_apoy_gob, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","i_apoy_gob_0","i_apoy_gob_3")
merged_all= merge(merged_all, summ_cat)  
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "import_apoy_gob"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =import_apoy_gob, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","import_apoy_gob_0","import_apoy_gob_1")
merged_all= merge(merged_all, summ_cat) 
####################################################################################
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","ingresos_otra_act"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =ingresos_otra_act, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","i_otra_act_0","i_otra_act_4")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "import_otra_act"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =import_otra_act, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","import_otra_act_0","import_otra_act_1","import_otra_act_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "dinero_env_hermano"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =dinero_env_hermano, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","din_herm_0","din_herm_1","din_herm_2")
merged_all= merge(merged_all, summ_cat)  
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "dinero_env_hijo"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =dinero_env_hijo, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","din_hijo_0","din_hijo_1","din_hijo_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "dinero_env_padres"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =dinero_env_padres, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","din_padres_0","din_padres_1","din_padres_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "dinero_env_otro_fam"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =dinero_env_otro_fam, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","din_o_fam_0","din_o_fam_1","din_o_fam_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "dinero_otra_fuente"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =dinero_otra_fuente, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","din_o_fuente_0","din_o_fuente_1","din_o_fuente_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "verif_genero"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =verif_genero, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","genero_0","genero_1","genero_2")
merged_all= merge(merged_all, summ_cat)
####################################################################################  
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","verif_habla_esp"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =verif_habla_esp, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","habla_esp_0","habla_esp_1","habla_esp_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prod_lengua_ind"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prod_lengua_ind, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","lengua_ind_0","lengua_ind_1","lengua_ind_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "padres_lengua_ind"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =padres_lengua_ind, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","p_lengua_ind_0","p_lengua_ind_1","p_lengua_ind_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB", "Localidad","pareja_lengua_ind"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =pareja_lengua_ind, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","pja_lengua_ind_0","pja_lengua_ind_1","pja_lengua_ind_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "prod_escuela"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =prod_escuela, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","escuela_0","escuela_1","escuela_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "ning_grado_aprob"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =ning_grado_aprob, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","ng_gdo_aprob_0","ng_gdo_aprob_1")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad","grado_aprob_primaria"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =grado_aprob_primaria, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","primaria_0","primaria_1","primaria_2", "primaria_3",
                      "primaria_4", "primaria_5","primaria_6")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad","grado_aprob_secu"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =grado_aprob_secu, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","secu_0","secu_1","secu_2", "secu_3")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "grado_aprob_bachill"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =grado_aprob_bachill, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","bachill_0","bachill_1","bachill_2","bachill_3",
                      "bachill_4","bachill_5","bachill_6", "bachill_9", "bachill_11"
                      ,"bachill_12","bachill_18")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "grado_aprob_bachill_año"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =grado_aprob_bachill_año, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","bachill_año_0","bachill_año_5")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "otro_nivel_est"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =otro_nivel_est, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","otro_nvl_est_0","otro_nvl_est_5")
merged_all= merge(merged_all, summ_cat) 
####################################################################################
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "vivienda_agua_entubada"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =vivienda_agua_entubada, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","agua_ent_0","agua_ent_1","agua_ent_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "vivienda_drenaje_red_pub"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =vivienda_drenaje_red_pub, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","drenaje_red_0","drenaje_red_1","drenaje_red_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "vivienda_drenaje_fosa_sep"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =vivienda_drenaje_fosa_sep, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","drenaje_fosa_0","drenaje_fosa_1","drenaje_fosa_2")
merged_all= merge(merged_all, summ_cat)  
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "vivienda_energ_elec"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =vivienda_energ_elec, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","energ_elec_0","energ_elec_1","energ_elec_2")
merged_all= merge(merged_all, summ_cat) 
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "vivienda_gas"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =vivienda_gas, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","gas_0","gas_1","gas_2")
merged_all= merge(merged_all, summ_cat) 
####################################################################################
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "vivienda_sanitario"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =vivienda_sanitario, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","sanitario_0","sanitario_1","sanitario_2")
merged_all= merge(merged_all, summ_cat)  
####################################################################################
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "vivienda_piso"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =vivienda_piso, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","piso_0","piso_1","piso_2")
merged_all= merge(merged_all, summ_cat)
#################################################################################### 
datos_cat = group_by(id_sociodemo, .dots = c("Entidad", "Municipio", "AGEB","Localidad", "vivienda_paredes"))
datos_cat = datos_cat %>% summarise(n = n()) %>% mutate(freq = n/sum(n))
summ_cat = spread(data = datos_cat[,c(1,2,3,4,5,7)], key =vivienda_paredes, value = freq)
summ_cat
colnames(summ_cat)= c("Entidad", "Municipio","AGEB","Localidad","paredes_0","paredes_1","paredes_2")
merged_all= merge(merged_all, summ_cat) ##QUINTA TABLA DE AGREGACIÓN


#Guardar archivo en CSV
write.csv(merged_all,"Z:\\Procesamiento\\Trabajo\\cafe_quintaparte.csv")

#Al final se juntaron todas las tablas de agregación en un solo archivo en Excel nombrado "data_fnl.csv", y este se envió a revisión de confidencialidad en el Laboratorio de Microdatos de INEGI.

