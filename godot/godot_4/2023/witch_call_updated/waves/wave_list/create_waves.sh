FOLDER=$1
DIFF=$2
MIN=$3
MAX=$4

for i in $(seq $MIN $MAX); do
  FILENAME="wave-$DIFF-$i"
  cat wave_X.tres > "$FOLDER/$FILENAME"
done

