#!/usr/bin/env python3
"""
Network Traffic Analyzer with Flask Logging Integration
Author: Aryan Bhaskar
Optimized Version with Web Interface
"""

import os
import signal
import sys
import json
import time
import argparse
import platform
import logging
import threading
import datetime
from logging.handlers import RotatingFileHandler
from collections import defaultdict
from typing import Optional, Dict, Set, List

from scapy.all import *
from scapy.layers.inet import IP, TCP, UDP
from scapy.layers.http import HTTP, HTTPRequest, HTTPResponse
from flask import Flask, jsonify

# Constants
ANOMALY_KEYWORDS = {
    "nc", "winpeas", "linpeas", ".dll", ".bat", ".js", 
    ".jar", ".sh", ".vbs", ".zip", ".rar", ".tar", ".exe",
    ".aspx", "cmd", ".php", ".lnk", "php", "phar", "gif",
    "302", "401", "403", "404", "500", "upload"
}
SURICATA_CONFIG = "/etc/suricata/suricata.yaml"
LOG_DIR = "logs"

# Flask Application Setup
app = Flask(__name__)

class LogManager:
    """Centralized logging management system"""
    
    def __init__(self):
        self.log_dir = LOG_DIR
        self._setup_logging()
        
    def _setup_logging(self):
        """Configure logging infrastructure"""
        os.makedirs(self.log_dir, exist_ok=True)
        json_formatter = logging.Formatter(
            '{"time": "%(asctime)s", "level": "%(levelname)s", "message": %(message)s}',
            datefmt="%Y-%m-%dT%H:%M:%SZ"
        )

        # Traffic Log Handler (INFO level)
        traffic_handler = RotatingFileHandler(
            os.path.join(self.log_dir, 'traffic.log'),
            maxBytes=10*1024*1024,  # 10MB
            backupCount=5
        )
        traffic_handler.setLevel(logging.INFO)
        traffic_handler.setFormatter(json_formatter)
        traffic_handler.addFilter(lambda r: r.levelno == logging.INFO)

        # Anomaly Log Handler (ERROR level)
        anomaly_handler = RotatingFileHandler(
            os.path.join(self.log_dir, 'anomalies.log'),
            maxBytes=10*1024*1024,  # 10MB
            backupCount=5
        )
        anomaly_handler.setLevel(logging.ERROR)
        anomaly_handler.setFormatter(json_formatter)
        anomaly_handler.addFilter(lambda r: r.levelno == logging.ERROR)

        self.logger = logging.getLogger('TrafficAnalyzer')
        self.logger.setLevel(logging.INFO)
        self.logger.addHandler(traffic_handler)
        self.logger.addHandler(anomaly_handler)

    def log_packet(self, packet: Packet) -> None:
        """Log structured packet data"""
        log_entry = {
            "timestamp": datetime.datetime.utcnow().isoformat() + "Z",
            "source_ip": packet[IP].src if packet.haslayer(IP) else None,
            "dest_ip": packet[IP].dst if packet.haslayer(IP) else None,
            "protocol": self._get_protocol(packet),
            "length": len(packet),
            "summary": packet.summary()
        }
        self.logger.info(json.dumps(log_entry))

    def log_anomaly(self, packet: Packet, alert_type: str) -> None:
        """Log security anomalies"""
        alert_data = {
            "timestamp": datetime.datetime.utcnow().isoformat() + "Z",
            "alert_type": alert_type,
            "source_ip": packet[IP].src,
            "dest_ip": packet[IP].dst,
            "protocol": self._get_protocol(packet),
            "payload_sample": self._get_payload(packet)[:100]  # First 100 chars
        }
        self.logger.error(json.dumps(alert_data))

    def _get_protocol(self, packet: Packet) -> str:
        """Extract protocol name from packet"""
        if packet.haslayer(HTTP): return "HTTP"
        if packet.haslayer(TCP): return "TCP"
        if packet.haslayer(UDP): return "UDP"
        return "Other"

    def _get_payload(self, packet: Packet) -> str:
        """Extract payload from packet"""
        if packet.haslayer(Raw):
            return str(packet[Raw].load)
        return ""

    def get_logs(self, log_type: str = 'traffic') -> List[Dict]:
        """Retrieve logs for Flask integration"""
        try:
            filename = os.path.join(self.log_dir, f'{log_type}.log')
            with open(filename, 'r') as f:
                return [json.loads(line) for line in f.readlines()]
        except (FileNotFoundError, json.JSONDecodeError):
            return []

# Global instances
log_manager = LogManager()

class TrafficAnalyzer:
    """Core network traffic analysis engine"""
    
    def __init__(self, args: argparse.Namespace):
        self.args = args
        self.src_counts = defaultdict(int)
        self.dst_counts = defaultdict(int)
        self.protocol_counts = defaultdict(int)
        self.custom_wordlist: Set[str] = set()
        
        self._validate_args()
        self._load_custom_wordlist()

    def signal_handler(sig, frame):
        print("\n\033[91m[*] Shutting down analyzer...\033[0m")
        if hasattr(app, 'analyzer'):
            app.analyzer.display_summary()
        sys.exit(0)

    def _validate_args(self) -> None:
        """Validate input arguments"""
        if self.args.port and not (0 <= self.args.port <= 65535):
            raise ValueError("Invalid port number (0-65535)")
        if self.args.wordlist and not os.path.exists(self.args.wordlist):
            raise FileNotFoundError(f"Wordlist {self.args.wordlist} not found")

    def _load_custom_wordlist(self) -> None:
        """Load custom anomaly detection wordlist"""
        if self.args.wordlist:
            with open(self.args.wordlist, 'r') as f:
                self.custom_wordlist = {line.strip().lower() for line in f}

    def analyze_packet(self, packet: Packet) -> None:
        """Main packet analysis entry point"""
        if not packet.haslayer(IP):
            return

        if self._packet_passes_filters(packet):
            self._update_stats(packet)
            self._detect_anomalies(packet)
            self._generate_output(packet)

    def _packet_passes_filters(self, packet: Packet) -> bool:
        """Apply all configured filters to packet"""
        return all([
            self._protocol_filter(packet),
            self._port_filter(packet),
            self._keyword_filter(packet)
        ])

    def _protocol_filter(self, packet: Packet) -> bool:
        """Apply protocol filter"""
        if not self.args.protocol:
            return True
        proto = self.args.protocol.lower()
        return (
            (proto == 'tcp' and packet.haslayer(TCP)) or
            (proto == 'udp' and packet.haslayer(UDP)) or
            (proto == 'http' and packet.haslayer(HTTP))
        )

    def _port_filter(self, packet: Packet) -> bool:
        """Apply port filter"""
        if not self.args.port:
            return True
        layers = [TCP, UDP]
        for layer in layers:
            if packet.haslayer(layer):
                return self.args.port in {packet[layer].sport, packet[layer].dport}
        return False

    def _keyword_filter(self, packet: Packet) -> bool:
        """Apply keyword filter"""
        if not self.args.keyword:
            return True
        return self.args.keyword.lower() in str(packet).lower()

    def _update_stats(self, packet: Packet) -> None:
        """Update traffic statistics"""
        ip = packet[IP]
        self.src_counts[ip.src] += 1
        self.dst_counts[ip.dst] += 1
        
        if packet.haslayer(HTTP):
            self.protocol_counts['HTTP'] += 1
        elif packet.haslayer(TCP):
            self.protocol_counts['TCP'] += 1
        elif packet.haslayer(UDP):
            self.protocol_counts['UDP'] += 1
        else:
            self.protocol_counts['Other'] += 1

    def _detect_anomalies(self, packet: Packet) -> None:
        """Detect suspicious patterns in packet payload"""
        payload = self._get_payload(packet).lower()
        
        # Check built-in anomalies
        if any(keyword in payload for keyword in ANOMALY_KEYWORDS):
            self._trigger_alert(packet, "Built-in Anomaly List")
            
        # Check custom wordlist
        if self.custom_wordlist and any(word in payload for word in self.custom_wordlist):
            self._trigger_alert(packet, "Custom Wordlist")

    def _get_payload(self, packet: Packet) -> str:
        """Extract payload from packet"""
        if packet.haslayer(Raw):
            return str(packet[Raw].load)
        return ""

    def _trigger_alert(self, packet: Packet, alert_type: str) -> None:
        """Generate anomaly alert"""
        log_manager.log_anomaly(packet, alert_type)
        timestamp = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(packet.time))
        alert_msg = (
            f"\n!ALERT! [{alert_type}] Suspicious activity detected!\n"
            f"Timestamp: {timestamp}\n"
            f"Summary: {packet.summary()}\n"
            f"Source: {packet[IP].src} -> Destination: {packet[IP].dst}\n"
        )
        print(alert_msg)

    def _generate_output(self, packet: Packet) -> None:
        """Generate structured logging output"""
        log_manager.log_packet(packet)
        if self.args.summary:
            print(packet.summary())
        if self.args.output:
            with open(self.args.output, 'a') as f:
                f.write(packet.summary() + '\n')

    def display_summary(self) -> None:
        """Display final analysis summary"""
        print("\n" + "="*50)
        print("{:^50}".format("Analysis Summary"))
        print("="*50)
        print("\nTop Source IPs:")
        for ip, count in sorted(self.src_counts.items(), key=lambda x: x[1], reverse=True)[:5]:
            print(f"  {ip}: {count} packets")
        print("\nTop Destination IPs:")
        for ip, count in sorted(self.dst_counts.items(), key=lambda x: x[1], reverse=True)[:5]:
            print(f"  {ip}: {count} packets")
        print("\nProtocol Distribution:")
        for proto, count in self.protocol_counts.items():
            print(f"  {proto}: {count} packets")

class SuricataManager:
    """Suricata IDS integration manager"""
    
    def __init__(self):
        self.process: Optional[subprocess.Popen] = None
        self.eve_file = os.path.join(LOG_DIR, "eve.json")

    def start(self, interface: str) -> None:
        """Start Suricata process"""
        if not os.path.exists(SURICATA_CONFIG):
            raise FileNotFoundError(f"Suricata config {SURICATA_CONFIG} not found")
        cmd = [
            "suricata",
            "-c", SURICATA_CONFIG,
            "-l", LOG_DIR,
            "-i", interface
        ]
        self.process = subprocess.Popen(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        time.sleep(2)

    def stop(self) -> None:
        """Stop Suricata process"""
        if self.process:
            self.process.terminate()
            self.process.wait()

    def process_logs(self) -> Dict:
        """Process Suricata eve.json logs"""
        alerts = []
        try:
            with open(self.eve_file, 'r') as f:
                for line in f:
                    entry = json.loads(line)
                    if entry.get('event_type') == 'alert':
                        alerts.append(entry)
        except FileNotFoundError:
            return {}
        return {
            'total_alerts': len(alerts),
            'alerts_by_category': self._count_field(alerts, 'alert.category'),
            'alerts_by_severity': self._count_field(alerts, 'alert.severity')
        }

    def _count_field(self, alerts: list, field: str) -> Dict:
        """Count occurrences of a specific field"""
        counts = defaultdict(int)
        for alert in alerts:
            keys = field.split('.')
            value = alert
            try:
                for key in keys:
                    value = value[key]
                counts[value] += 1
            except KeyError:
                continue
        return dict(counts)

class NetworkInterface:
    """Cross-platform network interface handler"""
    
    @staticmethod
    def validate(interface: str) -> bool:
        """Validate interface exists"""
        system = platform.system()
        try:
            if system == 'Windows':
                return any(iface['name'] == interface for iface in get_windows_if_list())
            elif system == 'Linux':
                return interface in get_if_list()
            return False
        except Exception:
            return False

# Flask Routes
@app.route('/api/logs/traffic')
def get_traffic_logs():
    return jsonify(log_manager.get_logs('traffic'))

@app.route('/api/logs/anomalies')
def get_anomaly_logs():
    return jsonify(log_manager.get_logs('anomalies'))

@app.route('/api/stats')
def get_stats():
    analyzer = getattr(app, 'analyzer', None)
    if not analyzer:
        return jsonify({"error": "Analyzer not active"}), 503
    return jsonify({
        "source_counts": analyzer.src_counts,
        "protocol_distribution": analyzer.protocol_counts
    })

def display_banner() -> None:
    """Display ASCII art banner"""
    banner = r"""
     █████╗ ███╗   ██╗ ██████╗ ███╗   ███╗ █████╗ ██╗      ██╗   ██╗  ███████╗ ███████╗ ██████╗        
    ██╔══██╗████╗  ██║██╔═══██╗████╗ ████║██╔══██╗██║      ██╗   ██╗  ╚════██║ ██╔════╝██╔══██╗       
    ███████║██╔██╗ ██║██║   ██║██╔████╔██║███████║██║       ██╗ ██╗       ██╔╝ ██║     ██████╔╝       
    ██╔══██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══██║██║         ██║        ██╔╝  █████╗  ████══╝        
    ██║  ██║██║ ╚████║██║   ██║██║ ╚═╝ ██║██║  ██║██║         ██║       ██╔╝   ██╔══╝  ██║ ██║        
    ██║  ██║██║  ╚███║╚██████╔╝██║     ██║██║  ██║██████████║  ██║      ███████╗ ███████╗██║  ██║       
    ╚═╝  ╚═╝╚═╝   ╚══╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚════════╝  ╚═╝      ╚══════╝ ╚══════╝╚═╝  ╚═╝       
                          Network Traffic Analyzer with Flask Integration                         
    """
    print(banner)

def main():
    """Main program execution"""
    display_banner()
    
    # Set up signal handler
    signal.signal(signal.SIGINT, TrafficAnalyzer.signal_handler)

    parser = argparse.ArgumentParser(
        description="Network Traffic Analyzer with Web Interface",
        formatter_class=argparse.RawTextHelpFormatter
    )
    parser.add_argument("-p", "--port", type=int, help="Filter by port number")
    parser.add_argument("-P", "--protocol", choices=['tcp', 'udp', 'http'],
                       help="Filter by protocol (TCP/UDP/HTTP)")
    parser.add_argument("-k", "--keyword", help="Search for keyword in packets")
    parser.add_argument("-w", "--wordlist", help="Custom anomaly detection wordlist")
    parser.add_argument("-o", "--output", help="Save output to file")
    parser.add_argument("-s", "--summary", action='store_true',
                       help="Show packet summaries during analysis")
    parser.add_argument("--web", action='store_true', help="Enable Flask web interface")
    parser.add_argument("--web-host", type=str, default='0.0.0.0', help="Web interface host")
    parser.add_argument("--web-port", type=int, default=5000, help="Web interface port")
    args = parser.parse_args()

    try:
        analyzer = TrafficAnalyzer(args)
        suricata = SuricataManager()

        # Start web interface if requested
        if args.web:
            def run_flask():
                app.run(host=args.web_host, port=args.web_port, debug=False, use_reloader=False)
            flask_thread = threading.Thread(target=run_flask, daemon=True)
            flask_thread.start()
            print(f"\nWeb interface started at http://{args.web_host}:{args.web_port}")
            app.analyzer = analyzer  # Make analyzer available to Flask context

        print("\n[1] Live Traffic Analysis\n[2] PCAP File Analysis\n[3] Suricata Integration")
        choice = input("Select mode: ").strip()
        
        if choice == '1':
            interface = input("Enter interface: ")
            if not NetworkInterface.validate(interface):
                raise ValueError(f"Invalid interface: {interface}")
            print(f"\nStarting analysis on {interface}...")
            sniff(iface=interface, prn=analyzer.analyze_packet, store=0)
            
        elif choice == '2':
            pcap_file = input("Enter PCAP file path: ")
            if not os.path.exists(pcap_file):
                raise FileNotFoundError(f"PCAP file {pcap_file} not found")
            print(f"\nAnalyzing {pcap_file}...")
            sniff(offline=pcap_file, prn=analyzer.analyze_packet, store=0)
            
        elif choice == '3':
            interface = input("Enter interface for Suricata: ")
            if not NetworkInterface.validate(interface):
                raise ValueError(f"Invalid interface: {interface}")
            print("\nStarting Suricata IDS...")
            suricata.start(interface)
            try:
                print("Suricata running... Press Ctrl+C to stop")
                while True:
                    time.sleep(1)
            except KeyboardInterrupt:
                print("\nStopping Suricata...")
                suricata.stop()
                stats = suricata.process_logs()
                print("\nSuricata Alerts Summary:")
                print(f"Total Alerts: {stats.get('total_alerts', 0)}")
                print("By Category:", json.dumps(stats.get('alerts_by_category', {}), indent=2))
                print("By Severity:", json.dumps(stats.get('alerts_by_severity', {}), indent=2))
        else:
            print("Invalid selection")
            sys.exit(1)
            
        analyzer.display_summary()

    except Exception as e:
        print(f"\nError: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
