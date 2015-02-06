# ookla speedtest analysis functions

# test function
fn.ttest <- function(df.tmp, var, conflevel=0.95){
      #create df for each operator
      df.tm <- subset(df.tmp,operator=='T-Mobile NL')
      df.kpn <- subset(df.tmp,operator=='KPN NL')
      df.vf <- subset(df.tmp,operator=='Vodafone NL')
      
      # perform tests
      t1.tk <- t.test(df.tm[var], df.kpn[var], alternative="two.sided", var.equal=FALSE, conf.level = conflevel)
      t2.tv <- t.test(df.tm[var], df.vf[var], alternative="two.sided", var.equal=FALSE, conf.level = conflevel)
      t3.vk <- t.test(df.vf[var], df.kpn[var], alternative="two.sided", var.equal=FALSE, conf.level = conflevel)
            
      # for sanity 
      p1 <- format.pval(t1.tk$p.value)
      s1 <- if (t1.tk$p.value < 1-conflevel){"Yes"} else {"No"}
      d1 <- paste(round(t1.tk$estimate[1]-t1.tk$estimate[2],1),'+/-',round((t1.tk$conf.int[2]-t1.tk$conf.int[1])/2,1))
      m1 <- if (s1=="Yes"){round(t1.tk$conf.int[1],1)} else {"NA"}
      l1 <- round(min(t1.tk$estimate[1],t1.tk$estimate[2]),1)
      r1 <- if (s1=="Yes"){round(100*m1/l1,1)} else {"NA"}

      p2 <- format.pval(t2.tv$p.value)
      s2 <- if (t2.tv$p.value < 1-conflevel){"Yes"} else {"No"}
      d2 <- paste(round(t2.tv$estimate[1]-t2.tv$estimate[2],1),'+/-',round((t2.tv$conf.int[2]-t2.tv$conf.int[1])/2,1))
      m2 <- if (s2=="Yes"){round(t2.tv$conf.int[1],1)} else {"NA"}
      l2 <- round(min(t2.tv$estimate[1],t2.tv$estimate[2]),1)
      r2 <- if (s2=="Yes"){round(100*m2/l2,1)} else {"NA"}
      
      p3 <- format.pval(t1.tk$p.value)
      s3 <- if (t3.vk$p.value < 1-conflevel){"Yes"} else {"No"}
      d3 <- paste(round(t3.vk$estimate[1]-t3.vk$estimate[2],1),'+/-',round((t3.vk$conf.int[2]-t3.vk$conf.int[1])/2,1))
      m3 <- if (s3=="Yes"){round(t3.vk$conf.int[1],1)} else {"NA"}
      l3 <- round(min(t3.vk$estimate[1],t3.vk$estimate[2]),1)
      r3 <- if (s3=="Yes"){round(100*m3/l3,1)} else {"NA"}
      
      #create result df for download
      r1 <- cbind("T-Mobile","KPN", nrow(df.tm),round(t1.tk$estimate[1]),nrow(df.kpn),round(t1.tk$estimate[2]),
                  p1, s1, d1, m1, r1
                  )
      rownames(r1) <- "T-Mobile vs KPN"
      r2 <- cbind("T-Mobile","Vodafone",nrow(df.tm),round(t2.tv$estimate[1]),nrow(df.vf),round(t2.tv$estimate[2]),
                  p2, s2, d2, m2, r2
                  )
      rownames(r2) <- "T-Mobile vs Vodafone"
      r3 <-cbind("Vodafone","KPN",nrow(df.vf),round(t3.vk$estimate[1]),nrow(df.kpn),round(t3.vk$estimate[2]),
                 p3, s3, d3, m3, r3
                )
      rownames(r3) <- "Vodafone vs KPN"
      df.tr <- as.data.frame(rbind(r1,r2,r3))
      names(df.tr) <- c("Operator1","Operator2","Sample1","Mean1","Sample2","Mean2", "P-value","Sign.","Diff of Means","Abs(Kbps)","Rel(%)")
      return(df.tr)
}