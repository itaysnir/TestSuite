reset
#set terminal postscript eps color 18
set terminal postscript eps noenhanced color 18
set output 'memc.eps'

set multiplot title "Memcached Server" #layout 1,2 #title "Macro Tests: Memcached"
set style fill pattern   1.00 border lt -1
set style data histograms
set style histogram #cluster

set tmargin 2
set bmargin 1
set lmargin 13
set rmargin 2

set style line 5  lt 1 linecolor rgb "dark-red"
set style line 4  lt 1 linecolor rgb "red"
set style line 2  lt 1 linecolor rgb "sea-green"
set style line 1  lt 1 linecolor rgb "light-green"
set style line 3  lt 1 linecolor rgb "dark-blue"
set style line 6  lt 1 linecolor rgb "royalblue"
set style line 7  lt 1 linecolor rgb "goldenrod"
set style line 8  lt 1 linecolor rgb "grey30"
set style line 9  lt 1 linecolor rgb "brown"
set style line 10 lt 1 linecolor rgb "black

set grid
set border lw 0.5
set key horizontal nobox at -.5,-1 samplen 4 spacing 1
unset xtic
set origin 0,.2
set size .6, .8
set yrange [0:]
set ylabel "Transactions/sec"
plot for [COL=2:7:1]  'raw.dat' index 0 using COL:xtic(1) ls COL title columnhead(COL)

unset ylabel
set origin .6, .2
set size .4, .8
set lmargin 2
set rmargin 4
set yrange [0:100]
set y2label "total cpu%"
unset key
plot for [COL=2:7:1]  'raw.dat' index 1 using COL:xtic(1) ls COL title columnhead(COL)

unset multiplot

