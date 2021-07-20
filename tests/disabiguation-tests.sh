# This is a bash script for automatically calculating ambiguity in our transducer
CORPUS=/home/jlopezn1/ling073/ling073-tsz-spa-corpus/tsz.sentences.txt
MORPH=/home/jlopezn1/ling073/ling073-tsz/tsz.automorf.bin
RLX=/home/jlopezn1/ling073/ling073-tsz/tsz.rlx.bin # you might need to remove ".bin"
TOKENS=`cat ${CORPUS} | apertium-destxt | lt-proc ${MORPH} | apertium-cleanstream | sed 's/$\W*\^/$\n^/g' | wc -l`
echo $TOKENS
ANALYSES=`cat ${CORPUS} | apertium-destxt | lt-proc ${MORPH} | apertium-cleanstream | sed 's/$\W*\^/$\n^/g' | cut -f2- -d'/' | sed 's/\//\n/g' | wc -l`
echo $ANALYSES
DISAMB=`cat ${CORPUS} | apertium-destxt | lt-proc ${MORPH} | apertium-cleanstream | cg-proc ${RLX} | sed 's/$\W*\^/$\n^/g' | cut -f2- -d'/' | sed 's/\//\n/g' | wc -l`
AMBIGPRE=`calc $ANALYSES/$TOKENS`
AMBIGPOST=`calc $DISAMB/$TOKENS`
echo "Ambiguity before disambiguation: ${AMBIGPRE}"
echo "Ambiguity after disambiguation: ${AMBIGPOST}"
