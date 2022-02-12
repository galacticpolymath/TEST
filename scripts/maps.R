require(pacman)
p_load(rnaturalearth,rnaturalearthdata,rgdal,sf,ggplot2,plotKML,dplyr)
asia<-ne_countries(continent="Asia",returnclass="sf")
plot(asia)

world<-ne_countries(returnclass="sf")



#Get data from online database
f <- rnaturalearth::ne_download(scale=50,type="geography_regions_polys",category="physical", returnclass = "sf") 

#extract borneo
borneo<-subset(f,LABEL=="BORNEO")
borneo<-cbind(borneo,st_coordinates(st_centroid(borneo)))
borneo$Name<-"Borneo"

ggplot()+geom_sf(data=world)+xlim(90,151)+ylim(-41,27)+theme_void()+
  geom_sf(data=borneo,fill=gpColors("flare"),alpha=.4,color="transparent")

ggsave("assets/R/Borneo_map.png")
# +
#   geom_sf(data=borneo,col=gpColors("flare"),alpha=1,fill="transparent")
  #+
  #geom_text(data=borneo,aes(X,Y,label=LABEL),size=7,fontface="bold")+

#export Borneo map to kml
st_write(borneo %>% dplyr::select(Name,geometry),"assets/R/borneo.kml",driver="kml",append=FALSE)
# maptools::kmlPoints(obj=as.SpatialPoints(st_coordinates(st_centroid(borneo))),"assets/R/borneo.kml",kmlname="label",name="BORNEO")
