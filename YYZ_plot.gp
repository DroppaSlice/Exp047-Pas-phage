set terminal x11
set ytics ( \
 "E2348C_PP_2" 1.0, \
 "E2348C_PP_4" 50960.0, \
 "E2348C_PP_5" 96472.0, \
 "E2348C_PP_6" 137258.0, \
 "" 190501 \
)
set size 1,1
set grid
set nokey
set border 10
set tics scale 0
set xlabel "NC_011356.1"
set ylabel "QRY"
set format "%.0f"
set xrange [1:54896]
set yrange [1:190501]
set linestyle 1  lt 1 lw 2 pt 6 ps 1
set linestyle 2  lt 3 lw 2 pt 6 ps 1
set linestyle 3  lt 2 lw 2 pt 6 ps 1
plot \
 "YYZ_plot.fplot" title "FWD" w lp ls 1, \
 "YYZ_plot.rplot" title "REV" w lp ls 2

print "-- INTERACTIVE MODE --"
print "consult gnuplot docs for command list"
print "mouse 1: coords to clipboard"
print "mouse 2: mark on plot"
print "mouse 3: zoom box"
print "'h' for help in plot window"
print "enter to exit"
pause -1
