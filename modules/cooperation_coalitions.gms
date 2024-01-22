* COOPERATION COALITIONS
* Define coalitions mappings
#=========================================================================
*   ///////////////////////       SETTING      ///////////////////////
#=========================================================================
##  CONF
#_________________________________________________________________________
$ifthen.ph %phase%=='conf'

** COALITIONS GDXFIX
*$setglobal gdxfix "results_default"

# This is to be sure to initialize the sequence
$setglobal coalitions_t_sequence 1

$setglobal solmode 'noncoop'

## REGION WEIGHTS
$if %region_weights% == 'negishi' $setglobal calc_nweights ((CPC.l(t,n)**elasmu)/sum(nn, (CPC.l(t,nn)**(elasmu))))

* Population weights
$if %region_weights% == 'pop' $setglobal calc_nweights 1


## SETS
#_________________________________________________________________________
$elseif.ph %phase%=='sets'

* Some pre-defined coalitions
* in a policy file this set can be extended with new coalitions

* to implement an srm_coalition use the flag %coalition_folder% and 
* put the files inside data_srm_coalition/%coalition_folder%/map_clt_n.inc 
* and data_srm_coalition/%coalition_folder%/cltsolve.inc

SET clt "List of all possibly-applied coalitions" /
# Single-region coalitions
$include %datapath%n.inc
# European Union
eu27
noneu27
# Grand coalition (all)
grand
srm_coalition
coal_a
coal_b
coal_c
coal_d
coal_e
/;

* Some pre-defined coalitions mapping
* in a policy file this set can be extended with new coalitions
SET map_clt_n(clt,n) "Mapping set between coalitions and belonging regions" /
$ifthen.regionselected %n%=="ed57"
# Single-region coalition
arg.arg
aus.aus
aut.aut
bel.bel
bgr.bgr
blt.blt
bra.bra
can.can
chl.chl
chn.chn
cor.cor
cro.cro
dnk.dnk
egy.egy
esp.esp
fin.fin
fra.fra
gbr.gbr
golf57.golf57
grc.grc
hun.hun
idn.idn
irl.irl
ita.ita
jpn.jpn
meme.meme
mex.mex
mys.mys
nde.nde
nld.nld
noan.noan
noap.noap
nor.nor
oeu.oeu
osea.osea
pol.pol
prt.prt
rcam.rcam
rcz.rcz
rfa.rfa
ris.ris
rjan57.rjan57
rom.rom
rsaf.rsaf
rsam.rsam
rsas.rsas
rsl.rsl
rus.rus
slo.slo
sui.sui
swe.swe
tha.tha
tur.tur
ukr.ukr
usa.usa
vnm.vnm
zaf.zaf
# European Union + ukr + sui + nor
eu27.(aut, bel, bgr, cro, dnk, esp, fin, fra, grc, hun, irl, ita, nld, pol, prt, rcz, rfa, rom, rsl, slo, swe, blt, ukr, sui, nor)
# Non-EU27
noneu27.(gbr, arg, aus, bra, can, chl, chn, cor, egy, golf57, idn, jpn, meme, mex, mys, nde, noan, noap, osea, rcam, ris, rjan57, rsaf, rsam, rsas, rus, tha, tur, usa, vnm, zaf, oeu)
# Grand coalitions (all)
grand.(aut, bel, bgr, cro, dnk, esp, fin, fra, grc, hun, irl, ita, nld, pol, prt, rcz, rfa, rom, rsl, slo, swe, blt, gbr, arg, aus, bra, can, chl, chn, cor, egy, golf57, idn, jpn, meme, mex, mys, nde, noan, noap, nor, osea, rcam, ris, rjan57, rsaf, rsam, rsas, rus, sui, tha, tur, ukr, usa, vnm, zaf, oeu)
# Brics
coal_b.(bra, rus, idn, chn, zaf)
# Anglo
coal_c.(usa, gbr, can, aus)
# Asean
coal_d.(tha, jpn, rsaf, rsam)
# Remains
coal_e.(arg, chl, cor, egy, golf57, meme, mex, mys, noan, noap, nde, osea, rcam, ris, rjan57, rsas, tur, vnm, oeu)
$elseif.regionselected %n%=="witch17"
# Single-region coalition
brazil.brazil
canada.canada
china.china
europe.europe
india.india
indonesia.indonesia
jpnkor.jpnkor
laca.laca
mena.mena
mexico.mexico
oceania.oceania
sasia.sasia
seasia.seasia
southafrica.southafrica
ssa.ssa
te.te
usa.usa
# European Union
eu27.(europe)
# Non-EU27
noneu27.(brazil,canada,china,india,indonesia,jpnkor,laca,mena,mexico,oceania,sasia,seasia,southafrica,ssa,te,usa)
# Grand coalitions (all)
grand.(brazil,canada,china,europe,india,indonesia,jpnkor,laca,mena,mexico,oceania,sasia,seasia,southafrica,ssa,te,usa)
$endif.regionselected
$if set coalition_folder $include %datapath%data_srm_coalition/%coalition_folder%/map_clt_n.inc
/;

# Control set for active coalitions
SET cltsolve(clt) /
$if set coalition_folder $include %datapath%data_srm_coalition/%coalition_folder%/cltsolve.inc
/;

$ifthen.srm not set coalition_folder
* Initialized to no
cltsolve(clt) = no;

cltsolve('eu27') = yes;
cltsolve('noneu27') = yes;
*cltsolve('eu27') = yes;
*cltsolve('coal_b') = yes;
*cltsolve('coal_c') = yes;
*cltsolve('coal_d') = yes;
*cltsolve('coal_e') = yes;
*$endif.srm
# MACRO mapping between coalitions and belonging regions (probaby now obsolete due to changes in solver)
$macro mapclt(n)    map_clt_n(&clt,n)
$macro mapcclt(nn)  map_clt_n(&clt,nn)


##  BEFORE SOLVE
#_________________________________________________________________________
$elseif.ph %phase%=='before_solve'

#===============================================================================
*     ///////////////////////     REPORTING     ///////////////////////
#===============================================================================

##  GDX ITEMS
#_________________________________________________________________________
$elseif.ph %phase%=='gdx_items'

clt
map_clt_n
cltsolve


$endif.ph
