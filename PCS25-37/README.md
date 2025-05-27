# Anomalyzer

Anomalyzer is a Network Traffic Analyzer (NTA) with advanced packet sniffing, network anomaly detection, and Suricata integration. It features keyword-based alerting for monitoring suspicious network traffic, along with HTTP logs analysis and a Suricata rule-based Intrusion Detection System (IDS).

## Features
- Live network traffic sniffing
- Offline packet capture (PCAP) analysis
- Keyword-based alerting for suspicious packets
- HTTP logs analysis
- Suricata integration for advanced alerting and rule-based detection

## Requirements
- Python 3.x
- Suricata (Intrusion Detection System)
- Scapy (Network packet manipulation)

## Installation
### 1. Clone the repository:
```bash
git clone https://github.com/ARYAN03B/anomalyzer.git
cd anomalyzer
```
### 2. Install dependencies:
```bash
pip install -r requirements.txt
```
### 3. Install and configure Suricata:
```bash
sudo apt install suricata
```
### 4. Configure Suricata:
Place your Suricata configuration file (suricata.yaml) in the config directory.

### 5. Run the application (with sudo):
```bash
sudo python3 anomalyzer.py
```
