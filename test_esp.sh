#!/bin/bash

echo "======================================"
echo "    ESP32 Linux Diagnostics           "
echo "======================================"

# 1. Search for connected USB serial devices
echo "[*] Searching for USB serial devices..."
PORT=$(ls /dev/ttyUSB* /dev/ttyACM* 2>/dev/null | head -n 1)

if [ -z "$PORT" ]; then
  echo "[!] FAIL: No USB serial devices found in /dev/ttyUSB* or /dev/ttyACM*."
  echo "    Check your USB cable (it might be power-only) or the board's USB chip is dead."
  exit 1
else
  echo "[+] Found device at: $PORT"
fi

# 2. Check user read/write permissions
echo "[*] Checking port permissions..."
if [ ! -r "$PORT" ] || [ ! -w "$PORT" ]; then
  echo "[!] FAIL: You do not have read/write permission for $PORT."
  echo "    Run 'sudo usermod -a -G dialout \$USER', then log out and back in."
  exit 1
else
  echo "[+] Permissions look good."
fi

# 3. Check for esptool installation
echo "[*] Checking for esptool..."
if ! command -v esptool &>/dev/null && ! command -v esptool &>/dev/null; then
  echo "[!] FAIL: esptool is not installed."
  echo "    Install it using 'sudo apt install esptool' or 'pip install esptool'."
  exit 1
else
  # Handle the command name whether it is installed via apt or pip
  ESP_CMD="esptool"
  if command -v esptool &>/dev/null; then ESP_CMD="esptool"; fi
  echo "[+] esptool found."
fi

# 4. Execute the hardware query
echo "======================================"
echo "[*] Querying ESP32 chip..."
echo "    NOTE: If it hangs on 'Connecting...', press and hold the BOOT button on your board!"
echo "======================================"

$ESP_CMD --port "$PORT" flash-id

# 5. Evaluate the result
if [ $? -eq 0 ]; then
  echo "======================================"
  echo "[+] SUCCESS: Hardware is responding and healthy!"
else
  echo "======================================"
  echo "[!] FAIL: The USB chip works, but the ESP32 chip itself did not respond."
  echo "    Suspects: Dead voltage regulator, faulty auto-reset, or strapped pins."
fi
