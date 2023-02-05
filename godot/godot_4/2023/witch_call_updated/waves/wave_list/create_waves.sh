MIN=$1
MAX=$2
FOLDER="$MIN-$MAX-$3"

if [ ! -d "$FOLDER" ]; then
  mkdir -p "$FOLDER"
fi

for i in $(seq $MIN $MAX); do
  cat wave_X.tres > "$FOLDER/wave_$i.tres"
done
