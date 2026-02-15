# CPU Stats Log
# By: Michael Klements
# 16/02/2026
#!/bin/bash

# Define the output file
OUTPUT_FILE="cpu_data_log.csv"

# Check if the file exists, if not, create the CSV header
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "Timestamp,CPU Clock (Hz),CPU Voltage (V),Temperature (C),Throttled,CPU Load (%)" > "$OUTPUT_FILE"
fi

# Start the logging loop
while true; do
    # Get the current timestamp
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    # Get the CPU data
    CPU_CLOCK=$(vcgencmd measure_clock arm | cut -d "=" -f 2)
    CPU_VOLTAGE=$(vcgencmd measure_volts core | cut -d "=" -f 2 | sed 's/V$//')  # Remove the 'V' symbol
    TEMP=$(vcgencmd measure_temp | cut -d "=" -f 2 | cut -d "'" -f 1)
    THROTTLED=$(vcgencmd get_throttled | cut -d "=" -f 2)  # Only raw throttled value (e.g., 0x0)

    # Get the CPU load percentage using top (ensuring it's working reliably)
    CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

    # Clear screen and print the values on new lines
    clear
    echo "CPU Clock: $CPU_CLOCK Hz"
    echo "CPU Voltage: $CPU_VOLTAGE V"  # Only one 'V' here
    echo "Temperature: $TEMP °C"
    echo "Throttled: $THROTTLED"
    echo "CPU Load: $CPU_LOAD %"

    # Log the data to the CSV file
    echo "$TIMESTAMP,$CPU_CLOCK,$CPU_VOLTAGE,$TEMP,$THROTTLED,$CPU_LOAD" >> "$OUTPUT_FILE"

    # Sleep for 1 second before the next read
    sleep 1
done
