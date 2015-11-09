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
            
      # for sanity
      # p-value
      p1 <- format.pval(t1.tk$p.value)
      # significance level
      s1 <- if (t1.tk$p.value < 1-conflevel){"Yes"} else {"No"}
      # difference of the means
      d1 <- round(t1.tk$estimate[1]-t1.tk$estimate[2],1)
      # confidence level
      c1 <- paste('+/-',round((t1.tk$conf.int[2]-t1.tk$conf.int[1])/2,1))
      # abs difference latency = max other is min
      l1 <- if (var=="latency"){round(max(t1.tk$estimate[1],t1.tk$estimate[2]),1)} else {round(min(t1.tk$estimate[1],t1.tk$estimate[2]),1)}
      # result
      r1 <- if (s1=="Yes"){round(100*d1/l1,1)} else {"NA"}

      # same for second test
      p2 <- format.pval(t2.tv$p.value)
      s2 <- if (t2.tv$p.value < 1-conflevel){"Yes"} else {"No"}
      d2 <- round(t2.tv$estimate[1]-t2.tv$estimate[2],1)
      c2 <- paste('+/-',round((t2.tv$conf.int[2]-t2.tv$conf.int[1])/2,1))
      l2 <- if (var=="latency"){round(max(t2.tv$estimate[1],t2.tv$estimate[2]),1)} 
              else {round(min(t2.tv$estimate[1],t2.tv$estimate[2]),1)}
      r2 <- if (s2=="Yes"){round(100*d2/l2,1)} else {"NA"}
      
      # do nice rounding
      # test 1 tmobile vs kpn
      t1.e1 <- if (var=="latency"){round(t1.tk$estimate[1],1)} else {round(t1.tk$estimate[1])}
      t1.e2 <- if (var=="latency"){round(t1.tk$estimate[2],1)} else {round(t1.tk$estimate[2])}
      # test 2 tmobile vs vodafone
      t2.e1 <- if (var=="latency"){round(t2.tv$estimate[1],1)} else {round(t2.tv$estimate[1])}
      t2.e2 <- if (var=="latency"){round(t2.tv$estimate[2],1)} else {round(t2.tv$estimate[2])}

      # create result rows for table
      r1 <- cbind("T-Mobile","KPN", nrow(df.tm),t1.e1,nrow(df.kpn),t1.e2,p1, s1, d1, c1, r1)
      rownames(r1) <- "T-Mobile vs KPN"
      
      r2 <- cbind("T-Mobile","Vodafone",nrow(df.tm),t2.e1,nrow(df.vf),t2.e2,p2, s2, d2, c2, r2)
      rownames(r2) <- "T-Mobile vs Vodafone"

      # put it all together
      df.tr <- as.data.frame(rbind(r1,r2))#,r3)) not interested in KPN vs Vodafone anymore...
      names(df.tr) <- if (var=="latency"){c("Operator1","Operator2","Sample1","Mean1","Sample2","Mean2", "P-value","Sign.","Diff(ms)","Conf Int","Rel(%)")}
                         else {c("Operator1","Operator2","Sample1","Mean1","Sample2","Mean2", "P-value","Sign.","Diff(Kbps)","Conf Int","Rel(%)")}
      return(df.tr)
}