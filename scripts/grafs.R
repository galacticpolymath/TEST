# make figures
# 
require(pacman)
p_load(galacticEdTools,tidyverse,galacticPubs)

calling<-read_csv("data/orig-client-data_NoEdit/L.pa_Calling rate data.csv")
calling$hr<-gsub("00h","",calling$Time_Block)

#Male calling rate
g0 <- calling  %>% 
      ggplot(aes(y = Calls_per_hour, x = hr,col=Sex, shape=Sex)) + 
      geom_point(size=1.5) + 
      theme_galactic(text.cex = c(1,1,1.2,1), axis.tick.length=3) + 
      xlab("Time (hour)") + 
      ylab("Calls per Hour")+
      ggtitle("Guardian Frog Call Rates by Sex")

(g<-g0+scale_shape_manual(values=c(21,23))+
      scale_color_manual(values=c(gpPal[[2]]$hex[1],gpPal[[2]]$hex[13])) )
gpsave("frog-call-rates_LABELED.png")

g0+blank_labs(title_txt=NA)+scale_color_manual(values=c(gpPal[[2]]$hex[1],gpPal[[2]]$hex[13]),labels=c("____________","____________"))+scale_shape_manual(values=c(21,23),labels=c("____________","____________"))+theme(legend.key.size = unit(2, 'lines'),
                                                                                                                                                                                                                         legend.key.width=unit(1,"line"))

gpsave("frog-call-rates_BLANK.png") 
                                                                                                                                                                                                                  