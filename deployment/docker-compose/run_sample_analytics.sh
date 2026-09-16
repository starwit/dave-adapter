
# delete old data
docker compose down -v


echo "Shifting sample data set to current date/time"
./shift_timestamps.sh

# starting with shifted data
docker compose up