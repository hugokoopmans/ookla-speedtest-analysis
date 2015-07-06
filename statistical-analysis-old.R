# ookla speedtest analysis functions

# test function
fn.ttest <- function(df.tmp, var, conflevel=0.95){
      #create df for each operator
      df.tm <- subset(df.tmp,operator=='T-Mobile NL')
      df.kpn <- subset(df.tmp,operator=='KPN NL')
      df.vf <- subset(df.tmp,operator=='Vodafone NL')
      
      # perform tests
      test.tm.kpn <- t.test(df.tm[var], df.kpn[var], alternative="two.sided", var.equal=FALSE, conf.level = conflevel)
      test.tm.vf <- t.test(df.tm[var], df.vf[var], alternative="two.sided", var.equal=FALSE, conf.level = conflevel)
      test.vf.kpn <- t.test(df.vf[var], df.kpn[var], alternative="two.sided", var.equal=FALSE, conf.level = conflevel)
            
      #create result df for download
      r1 <- cbind(nrow(df.tm),round(test.tm.kpn$estimate[1]),nrow(df.kpn),round(test.tm.kpn$estimate[2]),
                  paste(round(test.tm.kpn$estimate[1]-test.tm.kpn$estimate[2],1),'+/-',round((test.tm.kpn$conf.int[2]-test.tm.kpn$conf.int[1])/2,1)),
                  format.pval(test.tm.kpn$p.value), if (test.tm.kpn$p.value < 1-conflevel){"Yes"} else {"No"} )
      rownames(r1) <- "T-Mobile vs KPN"
      r2 <- cbind(nrow(df.tm),round(test.tm.vf$estimate[1]),nrow(df.vf),round(test.tm.vf$estimate[2]),
                  paste(round(test.tm.vf$estimate[1]-test.tm.vf$estimate[2],1),'+/-',round((test.tm.vf$conf.int[2]-test.tm.vf$conf.int[1])/2,1)),
                  format.pval(test.tm.vf$p.value), if (test.tm.vf$p.value < 1-conflevel){"Yes"} else {"No"})
      rownames(r2) <- "T-Mobile vs Vodafone"
      r3 <-cbind(nrow(df.vf),round(test.vf.kpn$estimate[1]),nrow(df.kpn),round(test.vf.kpn$estimate[2]),
                 paste(round(test.vf.kpn$estimate[1]-test.vf.kpn$estimate[2],1),'+/-',round((test.vf.kpn$conf.int[2]-test.vf.kpn$conf.int[1])/2,1)),
                 format.pval(test.vf.kpn$p.value), if (test.vf.kpn$p.value < 1-conflevel){"Yes"} else {"No"})
      rownames(r3) <- "Vodafone vs KPN"
      df.tr <- as.data.frame(rbind(r1,r2,r3))
      names(df.tr) <- c("n 1","Mean 1","n 2","Mean 2", "Mean Diff. +/- Conf. Bound" , "P-value","Significant")
      return(df.tr)
}