myafr=read.table('afr.Tajima.D', header=T )
Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  : 
  line 1 did not have 4 elements
> myafr=read.table('afr.Tajima.D', header=T ,comment.char="")
> myafr$pop='AFR'
> myamr=read.table('amr.Tajima.D', header=T ,comment.char="")
> myamr$pop='AMR'