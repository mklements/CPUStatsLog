# Raspberry Pi CPU Stats Logger

This repository contains a simple Bash script that continuously monitors and logs key CPU statistics on a Raspberry Pi, which is useful for performance or thermal testing.

## What This Script Does

The script:
* Reads CPU clock speed (ARM frequency)
* Reads CPU core voltage
* Reads CPU temperature
* Reads throttling status (undervoltage / thermal throttling flags)
* Calculates CPU load percentage
* Displays live stats in the terminal
* Logs all data to a CSV file (cpu_data_log.csv) once per second
* The CSV file is automatically created (with headers) if it does not already exist.

This makes it useful for:
* Thermal testing
* Cooling comparisons
* Overclock validation
* Power stability testing
* Long-term performance logging

## Installation on a Raspberry Pi 5

Open a terminal on your Pi and run:
1. Clone the repository
```
git clone https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
```
2. Change into the directory
```
cd YOUR-REPO-NAME
```
3. Make the script executable
```
chmod +x cpustatslog.sh
```
4. Run the script
```
./cpustatslog.sh
```

The script will now:
*Clear the screen each second
*Display live CPU stats
*Append readings to cpu_data_log.csv
*Press CTRL + C to stop logging.

Output File
All data is logged to:
```
cpu_data_log.csv
```

Format:
```
Timestamp,CPU Clock (Hz),CPU Voltage (V),Temperature (C),Throttled,CPU Load (%)
```

Optional: Run in Background
If you want it to keep running after closing the terminal:
```
nohup ./cpustatslog.sh &
```
