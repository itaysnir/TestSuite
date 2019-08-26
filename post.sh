[ -z "$1" ] && exit -1;

#dir=19_06_14_18.40.40/
#$gdrive list -m 2000|grep no_bypass
#1C4sVrgrPcvIEEiOZeWrgdUCDe3H4bBpo                   no_bypass                                  dir               2019-08-26 16:35:45
#1E-EOVcLGL4gDRbXzyB1bXODqA1ydplCT                   Figs                                       dir               2019-08-26 16:33:16
#octo=1Asc-CvlH-6fp-muaRX6zbLKORWpt3G2R
gdrive='1C4sVrgrPcvIEEiOZeWrgdUCDe3H4bBpo'
dir=$1
ag=/homes/markuze/allocator_graphs/scripts/
suite=/homes/markuze/TestSuite/
cd /tmp/
rm -fr $dir
mkdir -p $dir
cd $dir
pwd
$suite/parse.pl -d $suite/Results/$dir
$suite/display.pl -d ${dir}.csv
$suite/plot.pl -d setup.csv
ls
mkdir csv
mv *.csv csv
cd ..
gdrive upload -r -p  $gdrive $dir

