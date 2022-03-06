COMMENT_OUT=$1
FILENAME=$2

if [[ -e $FILENAME ]]
then 
   echo $FILENAME exists
   awk "/$COMMENT_OUT 1/,/$COMMENT_OUT -1/"'{print $0}' $FILENAME
else
   echo "$FILENAME is not defined"
fi
