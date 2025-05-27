#Created by Aryan Bhaskar.
from scapy.all import *
from scapy.layers.inet import IP, TCP, UDP
from scapy.layers.http import HTTP
from scapy.layers import http
#from scapy.arch.windows import get_windows_if_list  ###COMMENT THIS OUT IF RUNNING ON LINUX 
import os
import argparse
import platform
import random
          
anomlist = ["nc", "WinPEAS", "LinPEAS", ".dll", ".bat", ".js", ".jar", ".sh", ".vbs", ".zip", ".rar", ".tar",  ".exe", ".aspx", "cmd", ".php",".lnk", "php", "phar", "gif", "302", "401" "403", "404",  "500", "upload"]

#######################################################SURICATA######################################################
# Define paths and configurations
suricata_config = "/etc/suricata/suricata.yaml"
log_dir = "/var/log/suricata/"
summary_file = "suricata_summary.json"

def run_suricata():
    cmd = ["suricata", "-c", suricata_config, "-l", log_dir, "-i", "wlan0"]
    return subprocess.Popen(cmd)

def process_logs():
    eve_file = os.path.join(log_dir, "eve.json")
    logs = []
    with open(eve_file, "r") as file:
        for line in file:
            log_entry = json.loads(line)
            logs.append(log_entry)
    return logs

def generate_summary(logs):
    summary = {
        "total_alerts": 0,
        "alerts_by_category": {},
        "alerts_by_severity": {},
    }
    for log in logs:
        if log.get("event_type") == "alert":
            summary["total_alerts"] += 1
            category = log["alert"]["category"]
            severity = log["alert"]["severity"]

            if category not in summary["alerts_by_category"]:
                summary["alerts_by_category"][category] = 0
            summary["alerts_by_category"][category] += 1

            if severity not in summary["alerts_by_severity"]:
                summary["alerts_by_severity"][severity] = 0
            summary["alerts_by_severity"][severity] += 1

    with open(summary_file, "w") as file:
        json.dump(summary, file, indent=4)

    print(f"Summary saved to {summary_file}")

def display_summary():
    with open(summary_file, "r") as file:
        summary = json.load(file)
    print("Suricata Alert Summary:")
    print(f"Total Alerts: {summary['total_alerts']}")
    print("Alerts by Category:")
    for category, count in summary["alerts_by_category"].items():
        print(f"  {category}: {count}")
    print("Alerts by Severity:")
    for severity, count in summary["alerts_by_severity"].items():
        print(f"  Severity {severity}: {count}")

def main():
    # Run Suricata in a separate process
    print("Starting Suricata...")
    process = run_suricata()

    try:
        # Wait for the process to be interrupted (Ctrl+C)
        process.wait()
    except KeyboardInterrupt:
        print("\nStopping Suricata...")
        process.terminate()
        process.wait()
        
        # Process logs and generate summary
        logs = process_logs()
        generate_summary(logs)
        display_summary()
#######################################################SURICATA######################################################

class PacketAnalyzer:
   def __init__(self, args):
        self.src_ips = {}
        self.dst_ips = {}
        self.traffic_types = {"TCP": 0, "UDP": 0, "HTTP": 0, "Other": 0}
        self.args = args 
        self.protocol_filter = args.P if args is not None else None
        self.port_filter = args.p if args is not None else None
        self.keyword_filter = args.k if args is not None else None
        self.save_output = args.o if args is not None else None
        self.smry = args.s if args is not None else None
        self.anomlist = ["nc", "WinPEAS", "LinPEAS", ".dll", ".bat", ".js", ".jar", ".sh", ".vbs", ".zip", ".rar", ".tar",  ".exe", ".aspx", "cmd", ".php",".lnk", "php", "phar", "gif", "302", "401" "403", "404",  "500"]
      
   def filters(self, pkt):
      if IP in pkt:
        if self.protocol_filter:
            if self.protocol_filter.upper() == 'TCP':
               if TCP and not (HTTP in pkt or UDP in pkt) and self.smry == 'y':
                  timestamp = float(pkt.time)
                  borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                  print(f"{borat}: {pkt.summary()}")
                  return True
               elif TCP and not (HTTP in pkt or UDP in pkt) in pkt:
                  return True
               else:
                  return False
            elif self.protocol_filter.upper() == 'UDP':
               if UDP in pkt and self.smry == 'y':
                  timestamp = float(pkt.time)
                  borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                  print(f"{borat}: {pkt.summary()}")
                  return True
               elif UDP in pkt:
                  return True
               else:
                  return False
            elif self.protocol_filter.upper() == 'HTTP':
               if HTTP in pkt and self.smry == 'y':
                  timestamp = float(pkt.time)
                  borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                  print(f"{borat}: {pkt.summary()}")
                  return True
               elif UDP in pkt:
                  return True
               else:
                  return False
            else:
               print("Error in protocol selection: Please choose TCP, UDP, or HTTP\n")
               return False
                     
        if self.save_output:
           with open(self.save_output, 'a') as f:
              f.write(f"{borat}: {pkt.summary()}\n")
      
        if self.port_filter is not None:
            if TCP in pkt and (pkt[TCP].dport != self.port_filter and pkt[TCP].sport != self.port_filter) and self.smry == 'y':
                return False
            elif TCP in pkt and (pkt[TCP].dport != self.port_filter and pkt[TCP].sport != self.port_filter):
               return False
            if UDP in pkt and (pkt[UDP].dport != self.port_filter and pkt[UDP].sport != self.port_filter) and self.smry == 'y':
                return False  
            if UDP in pkt and (pkt[UDP].dport != self.port_filter and pkt[UDP].sport != self.port_filter):
               return False

        if self.keyword_filter:
            if self.keyword_filter in str(pkt):
                timestamp = float(pkt.time)
                borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                print(f"{borat}: {pkt.summary()}")
                if self.save_output:
                   with open(self.save_output, 'a') as f:
                      f.write(f"{borat}: {pkt.summary()}\n")
                return True
                
        if self.smry:
            if self.smry == "y":
               timestamp = float(pkt.time)
               borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
               print(f"{borat}: {pkt.summary()}")
               if self.save_output:
                  with open(self.save_output, 'a') as f:
                     f.write(f"{borat}: {pkt.summary()}\n")
               return True
            elif self.smry == 't':
               if TCP and not (HTTP in pkt or  UDP in pkt):
                  timestamp = float(pkt.time)
                  borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                  print(f"{borat}: {pkt.summary()}\n")
                  return True
            elif self.smry == 'h':
               if HTTP in pkt:
                  timestamp = float(pkt.time)
                  borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                  print(f"{borat}: {pkt.summary()}\n")
                  return True
            elif self.smry == 'u':
               if UDP in pkt:
                  timestamp = float(pkt.time)
                  borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                  print(f"{borat}: {pkt.summary()}\n")
                  return True
            else:
               return "Specify 'y' to view ALL, 't' to view TCP events, 'u' to view UDP events, 'h' to view HTTP events"          

        return True
      else:
        return False

   def mode_alert(self, pkt):
       if IP in pkt:
         src_ip = pkt[IP].src
         dst_ip = pkt[IP].dst
         self.update_src_ips(src_ip)
         self.update_dst_ips(dst_ip)
         self.update_traffic_types(pkt)
         if TCP in pkt and not HTTP in pkt:
            tcp_packet = pkt[TCP]
            if any(word in str(tcp_packet.payload).lower() for word in self.anomlist):
                print("\n!ALERT! Suspicious TCP packet detected!")
                timestamp = float(pkt.time)
                borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                print(f"{borat}: {pkt.summary()}")
         elif UDP in pkt:
            udp_packet = pkt[UDP]
            if any(word in str(udp_packet.payload).lower() for word in self.anomlist):
                print("\n!ALERT! Suspicious UDP packet detected!")
                timestamp = float(pkt.time)
                borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                print(f"{borat}: {pkt.summary()}")
         elif HTTP in pkt:
            http_packet = pkt[HTTP]
            if any(word in str(http_packet).lower() for word in self.anomlist):
               print("\n!ALERT! Suspicious HTTP packet detected!")
               timestamp = float(pkt.time)
               borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
               print(f"{borat}: {pkt.summary()}")
         
   def mode_alert_anomlist(self, choice):
      if choice in ["file", "File", "FILE", "f", "2", "F"]:
         filename = input("\nSpecify File or File Path: ")
         if os.path.exists(filename):
            print(f"\n[+]{filename} accepted. Now sniffing...")
            try:
               sniff(offline=filename, prn=self.mode_alert)
            except Exception as e:
               print(f"Err: {e}")
         else:
            print(f"Missed It!!! Your Bad... {filename} does not exist. Try again.")
      elif choice in ["interface", "Interface", "INTERFACE", "i", "1", "iface", "I"]:
         inter = input("\nSpecify Interface: ")
         if platform.system() == 'Windows':
            if inter in get_windows_if_list() or get_if_raw_hwaddr(inter):
               print(f"\nEvaluating {inter} on Windows...")
               try:
                  print(f"\nNow sniffing for terms in the anomlist on {inter}\n")
                  sniff(iface=inter,prn=self.mode_alert, store=0)
               except Exception as e:
                  print(f"Err: {e}\n")
            else:
               print(f"'{inter}' is not valid. Please run Get-NetAdapter")
         elif platform.system() == 'Linux':
            if inter in get_if_list() or get_if_raw_hwaddr(inter):
               print(f"\nEvaluating {inter} on Linux..")
               try:
                  print(f"Now sniffing for terms in the anomlist on {inter}")
                  sniff(iface=inter, prn=self.mode_alert, store=0)
               except Exception as e:
                  print(f"Err: {e}")
            else:
               print(f"'{inter}' is not valid. Please run ifconfig")
         else:
            print("Sorry, only Windows and Linux are supported at the moment. Please visit @ARYAN03B on Github for updates")
      else:
         print(f"'{choice}' is not a valid option. Please select a valid option.")
            
   def word_alert(self, pkt, dasfile):
      if IP in pkt:
        src_ip = pkt[IP].src
        dst_ip = pkt[IP].dst
        self.update_src_ips(src_ip)
        self.update_dst_ips(dst_ip)
        self.update_traffic_types(pkt)
        if TCP in pkt and not HTTP in pkt:
            tcp_packet = pkt[TCP]
            with open(dasfile, 'r') as file:
                wordlist = [line.strip() for line in file]
            if any(word in str(tcp_packet.payload).lower() for word in wordlist):
                print("\n!ALERT! Suspicious TCP packet detected based on wordlist!")
                timestamp = float(pkt.time)
                borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                print(f"{borat}: {pkt.summary()}")
        elif UDP in pkt:
            udp_packet = pkt[UDP]
            with open(dasfile, 'r') as file:
                wordlist = [line.strip() for line in file]
            if any(word in str(udp_packet.payload).lower() for word in wordlist):
                print("\n!ALERT! Suspicious UDP packet detected based on wordlist!")
                timestamp = float(pkt.time)
                borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                print(f"{borat}: {pkt.summary()}")
        elif HTTP in pkt:
            http_packet = pkt[HTTP]
            with open(dasfile, 'r') as file:
                wordlist = [line.strip() for line in file]
            if any(word in str(http_packet).lower() for word in wordlist):
                print("\n!ALERT! Suspicious HTTP packet detected based on wordlist!")
                timestamp = float(pkt.time)
                borat = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
                print(f"{borat}: {pkt.summary()}")

   def mode_alert_input(self, dasfile):
      if os.path.exists(dasfile):
         print(f"Anomalyzer will now alert based on terms from {dasfile}\n")        
         choice = input("\nSniff active Interface [i] or File [f]: ")
         if choice in ["file", "File", "FILE", "f", "2", "F"]:
            filename = input("Specify File or File Path: ")
            if os.path.exists(filename):
               print(f"\n[+]{filename} was successfully read.")
               try:
                  print(f"\nNow sniffing for terms in {dasfile} on {filename}...")
                  sniff(offline=filename, prn=self.word_alert, store=0)
               except Exception as e:
                  print(f"Err: {e}")
            else:
               print(f"Missed It!! Your Bad... {filename} does not exist. Please try again.")

         elif choice in ["interface", "Interface", "INTERFACE", "i", "1", "iface", "I"]:
            inter = input("Specify Interface: ")
            if platform.system() == 'Windows':
               if inter in get_windows_if_list() or get_if_raw_hwaddr(inter):
                  print(f"\nEvaluating {inter} on Windows...")
                  try:
                     print(f"\nNow sniffing for terms in {dasfile} on {inter}...")
                     sniff(iface=inter, prn=self.word_alert, store=0)
                  except Exception as e:
                     print(f"Err: {e}")
               else:
                  print(f"'{inter}' is not valid. Please run Get-NetAdapter")
            elif platform.system() == 'Linux':
               if inter in get_if_list() or get_if_raw_hwaddr(inter):
                  print(f"\nEvaluating {inter} on Linux...")
                  try:
                     print(f"\nNow sniffing for terms in {dasfile} on {inter}...")
                     sniff(iface=inter, prn=self.word_alert, store=0)
                  except Exception as e:
                     print(f"Err: {e}")
               else:
                  print(f"\n'{inter}' is not valid. Run ifconfig to find valid interfaces.")
            else:
               print("Sorry, only Windows and Linux are currently supported. Visit @ARYAN03B on Github for updates")
         else:
            print(f"'{choice}' is not a valid option. Please try i for Interface or f for File.")

   def handler(self, pkt):
      if self.filters(pkt):
         src_ip = pkt[IP].src
         dst_ip = pkt[IP].dst
         self.update_src_ips(src_ip)
         self.update_dst_ips(dst_ip)
         self.update_traffic_types(pkt)

   def src_ipcounter(self, src_ip):
      self.src_ips[src_ip] = self.src_ips.get(src_ip, 0) + 1
   def dst_ipcounter(self, dst_ip):
      self.dst_ips[dst_ip] = self.dst_ips.get(dst_ip, 0) + 1

   def traffic_counter(self, pkt):
      if TCP and not HTTP in pkt:
         self.traffic_types["TCP"] += 1
      elif UDP in pkt:
         self.traffic_types["UDP"] += 1
      elif HTTP in pkt:
         self.traffic_types["HTTP"] += 1
      else:
         self.traffic_types["Other"] += 1

   def update_src_ips(self, src_ip):
      self.src_ips[src_ip] = self.src_ips.get(src_ip, 0) + 1

   def update_dst_ips(self, dst_ip):
      self.dst_ips[dst_ip] = self.dst_ips.get(dst_ip, 0) + 1

   def update_traffic_types(self, pkt):
      self.traffic_counter(pkt)

   def banner(self):
      banner = [
         f"""
              █████╗    ███╗   ██╗    ██████╗    ███╗   ███╗    █████╗    ██╗      ██╗   ██╗  ███████╗   ███████╗   ██████╗        
             ██╔══██╗   ████╗  ██║   ██╔═══██╗   ████╗ ████║   ██╔══██╗   ██║      ██╗   ██╗  ╚════██║   ██╔════╝   ██╔══██╗       
             ███████║   ██╔██╗ ██║   ██║   ██║   ██╔████╔██║   ███████║   ██║       ██╗ ██╗       ██╔╝   ██║        ██████╔╝       
             ██╔══██║   ██║╚██╗██║   ██║   ██║   ██║╚██╔╝██║   ██╔══██║   ██║         ██║        ██╔╝    █████╗     ████══╝        
             ██║  ██║   ██║ ╚████║   ██║   ██║   ██║ ╚═╝ ██║   ██║  ██║   ██║         ██║       ██╔╝     ██╔══╝     ██║ ██║        
             ██║  ██║   ██║  ╚███║   ╚██████╔╝   ██║     ██║   ██║  ██║   █████████║  ██║      ███████╗  ███████╗   ██║  ██║       
             ╚═╝  ╚═╝   ╚═╝   ╚══╝    ╚═════╝    ╚═╝     ╚═╝   ╚═╝  ╚═╝   ╚════════╝  ╚═╝      ╚══════╝  ╚══════╝   ╚═╝  ╚═╝       
                               Network Traffic Analyzer for Anomaly Detection integrated with Suricata                             
            """
        ]

      anomalyzer = random.choice(banner)
      print(anomalyzer)
   def main_banner(self):
      self.banner()

if __name__ == "__main__":
   parser = argparse.ArgumentParser(
      usage="python anomalyzer.py [-h] [-P PROTOCOL] [-p PORT] [-k KEYWORD] [-o SAVE_FILE] [-s SUMMARY]",
      description="help: specify arguments before choosing option. OPTION 1 sniffs local traffic on specified interface. OPTION 2 sniffs pcap files. OPTION 3 sniffs through a specified interface or file for suspicious activity, alerting on potential malicious traffic. OPTION 4 analyzes HTTP packets through an interface or a file. ✎ USE RESPONSIBLY AND visit @ARYAN03B FOR UPDATES✎", 
      epilog="example: python anomalyzer.py -P TCP -s y"
      )
   parser.add_argument("-P", metavar="PROTOCOL", help="filter by TCP, UDP, or HTTP")
   parser.add_argument("-p", type=int, metavar="PORT", help="filter by port")
   parser.add_argument("-k",  metavar="KEYWORD",help="search through traffic for specified keyword. Works with options 1,2,4")
   parser.add_argument("-o", metavar='SAVE_FILE', help="save output to file")
   parser.add_argument("-s", metavar="SUMMMARY", action='store', help="view packet summaries")
   args = parser.parse_args()
   analyzer = PacketAnalyzer(args)
   analyzer.main_banner()   

   if args.P and args.P.upper() not in ["TCP", "UDP", "HTTP"]:
      parser.error("-P must be followed by TCP, UDP, or HTTP\n")

   if args.p and (args.p < 0 or args.p > 65535):
      parser.error("-p must be between 0-65535\n")

   if args.s and args.s not in ["y", "t", "u", "h"]:
      parser.error("-s can only use 'y' to view ALL, 't' to view TCP events, 'u' to view UDP events,  or 'h' to view HTTP events\n")


   print(f"\nWelcome to ANOMALYZER, an advanced packet sniffer/analyzer and IDS. Please choose an option or run with -h for more information")

   while True:
        option = input("\nOptions \n1. Active Sniffing \n2. File Sniffing \n3. Alert Mode \n4. HTTP Analysis \n5. Suricata \nType number: ")
        if option in ["1", "2", "3", "4", "5"]:
            break
        else:
            print("Select a Valid Option.")

   if option == "1":
    while True:
        interface = input("Type Interface(Like wlan0, eth0...): ")
        if platform.system() == 'Windows':
            if interface in get_windows_if_list() or get_if_raw_hwaddr(interface):
                print("Evaluating response for Windows machine...")
                try:
                    print("\n[+] Windows Interface accepted. Now sniffing...\n")
                    sniff(iface=interface, prn=analyzer.handler, store=0)
                    break
                except Exception:
                    print(f"Specify valid interface: Wi-Fi, Ethernet, Local Area Connection, etc")
            else:
                pass
        elif platform.system() == 'Linux':
            if interface in get_if_list() or get_if_raw_hwaddr(interface):
                print("Evaluating response for Linux machine...")
                try:
                    sniff(iface=interface, prn=analyzer.handler, store=0)
                    print("[+] Linux interface accepted. Now sniffing...\n")
                    break
                except Exception as e:
                    print(f"Specify valid interface: eth0, wlan0, tun0, etc: {e}")
            else:
                pass
        else:
            print("Only Linux and Windows are supported currently. Check back later for updates")

   elif option == "2":
      while True:
         filename = input("Type File or File Path: ")
         if os.path.exists(filename):
            print("\n[+] File was successfully read. Please Wait...\n")
            try:
               sniff(offline=filename, prn=analyzer.handler, store=0)
            except Exception:
              pass
            break
         else:
            print(f"Womp womp. '{filename}' does not exist. Please try again.")

   elif option == "3":
      while True:
         alert = input("Sniff for terms in Wordlist [1] or anomlist [2]: ")
         if alert in ["wordlist", "Wordlist", "WORDLIST", "w", "1", "W"]:              #Alert mode uses a wordlist
            dasfile = input(f"Specify Wordlist or Wordlist Path: ")
            analyzer.mode_alert_input(dasfile)  
            break
         elif alert in ["Anomlist", "anomlist", "ANOMLIST", "s", "2", "S"]:            #Alert mode uses anomlist
            print("Cheeky selection. Anomalyzerrr will now alert based off of the terms in the anomlist....")
            choice = input("\nSniff active Interface [i] or File [f]: ")
            analyzer.mode_alert_anomlist(choice)
            break
         else:
            print("Invalid option. Please choose either 1 or 2.")

   elif option == "4":
      while True:
         ice = input("\nSniff active Interface [i] or File [f]: ")
         if ice in ["f", "F", "file", "File", "2"]:
            vanilla = input("\nSpecify File or File Path: ")
            if os.path.exists(vanilla):
                  try:
                     packets = sniff(offline=vanilla, prn=analyzer.handler)
                     http_packets = [packet for packet in packets if packet.haslayer(http.HTTPRequest) or packet.haslayer(http.HTTPResponse)]
                     
                     if http_packets:
                        if analyzer.args and analyzer.args.k:
                            packets = [packet for packet in packets if analyzer.args.k in str(packet)]
                        
                        for packet in packets:
                           if packet.haslayer(http.HTTPRequest):
                              http_request = packet.getlayer(http.HTTPRequest)
                              print("=" * 50)
                              print("{:^50}".format("HTTP Request"))
                              print("=" * 50)
                              print(f"Method: {http_request.Method.decode()} URL: {http_request.Path.decode()}")
                              print("Headers: ")
                              for header, value in http_request.fields.items():
                                 if isinstance(value, bytes):
                                    print(f"{header}: {value.decode()}")
                                 else:
                                    print(f"{header}: {value}")
                                 if hasattr(packet, 'load') and packet.load:
                                    print("Body: ")
                                    print(packet.load.decode())
                                 else:
                                    print("Body: No body data\n")
                           elif packet.haslayer(http.HTTPResponse):
                              http_response = packet.getlayer(http.HTTPResponse)
                              print("=" * 50)
                              print("{:^50}".format("HTTP Response"))
                              print("=" * 50)
                              print(f"Status Code: {http_response.Status_Code.decode()} {http_response.Reason_Phrase.decode()}")
                              print("Headers: ")
                              for header, value in http_response.fields.items():
                                 if isinstance(value, bytes):
                                    print(f"{header}: {value.decode()}")
                                 else:
                                    print(f"{header}: {value}")
                                 if hasattr(packet, 'load') and packet.load:
                                    print("Body: ")
                                    print(packet.load.decode())
                                 else:
                                    print("Body: No body data")
                     else:
                        print("No HTTP packets found in the file.")
                    
                  except Exception as e:
                     print(f"Error while analyzing HTTP packets: {e}")
                  break
            else:
               print(f"The file '{vanilla}' does not exist. Try again.")

         elif ice in ["i", "I", "interface", "Interface", "iface", "1"]:
            madrid = input("\nSpecify Interface: ")
            if platform.system() == 'Windows':
               if madrid in get_windows_if_list() or get_if_raw_hwaddr(madrid):
                  print("Evaluating response for Windows machine...")
                  try:
                     packets = sniff(iface=madrid, prn=analyzer.handler)
                     http_packets = [packet for packet in packets if packet.haslayer(http.HTTPRequest) or packet.haslayer(http.HTTPResponse)]
                     
                     if http_packets:
                        if analyzer.args and analyzer.args.k:
                            packets = [packet for packet in packets if analyzer.args.k in str(packet)]
                        
                        for packet in packets:
                           if packet.haslayer(http.HTTPRequest):
                              http_request = packet.getlayer(http.HTTPRequest)
                              print("=" * 50)
                              print("{:^50}".format("HTTP Request"))
                              print("=" * 50)
                              print(f"Method: {http_request.Method.decode()} URL: {http_request.Path.decode()}")
                              print("Headers: ")
                              for header, value in http_request.fields.items():
                                 if isinstance(value, bytes):
                                    print(f"{header}: {value.decode()}")
                                 else:
                                    print(f"{header}: {value}")
                                 if hasattr(packet, 'load') and packet.load:
                                    print("Body: ")
                                    print(packet.load.decode())
                                 else:
                                    print("Body: No body data\n")
                           elif packet.haslayer(http.HTTPResponse):
                              http_response = packet.getlayer(http.HTTPResponse)
                              print("=" * 50)
                              print("{:^50}".format("HTTP Response"))
                              print("=" * 50)
                              print(f"Status Code: {http_response.Status_Code.decode()} {http_response.Reason_Phrase.decode()}")
                              print("Headers: ")
                              for header, value in http_response.fields.items():
                                 if isinstance(value, bytes):
                                    print(f"{header}: {value.decode()}")
                                 else:
                                    print(f"{header}: {value}")
                                 if hasattr(packet, 'load') and packet.load:
                                    print("Body: ")
                                    print(packet.load.decode())
                                 else:
                                    print("Body: No body data")
                     else:
                        print(f"No HTTP found on {madrid}")

                  except Exception as e:
                     print(f"Error while Analyzing HTTP packets: {e}")
                     break
               else:
                  print(f"Specify a valid interface. '{madrid}' is incorrect.")

            elif platform.system() == 'Linux':
               if madrid in get_if_list() or get_if_raw_hwaddr(madrid):
                  print("Evaluating response for Linux machine...")
                  try:
                     packets = sniff(iface=madrid, prn=analyzer.handler)
                     http_packets = [packet for packet in packets if packet.haslayer(http.HTTPRequest) or packet.haslayer(http.HTTPResponse)]
                     
                     if http_packets:
                        if analyzer.args and analyzer.args.k:
                            packets = [packet for packet in packets if analyzer.args.k in str(packet)]
                        
                        for packet in packets:
                           if packet.haslayer(http.HTTPRequest):
                              http_request = packet.getlayer(http.HTTPRequest)
                              print("=" * 50)
                              print("{:^50}".format("HTTP Request"))
                              print("=" * 50)
                              print(f"Method: {http_request.Method.decode()} URL: {http_request.Path.decode()}")
                              print("Headers: ")
                              for header, value in http_request.fields.items():
                                 if isinstance(value, bytes):
                                    print(f"{header}: {value.decode()}")
                                 else:
                                    print(f"{header}: {value}")
                                 if hasattr(packet, 'load') and packet.load:
                                    print("Body: ")
                                    print(packet.load.decode())
                                 else:
                                    print("Body: No body data\n")
                           elif packet.haslayer(http.HTTPResponse):
                              http_response = packet.getlayer(http.HTTPResponse)
                              print("=" * 50)
                              print("{:^50}".format("HTTP Response"))
                              print("=" * 50)
                              print(f"Status Code: {http_response.Status_Code.decode()} {http_response.Reason_Phrase.decode()}")
                              print("Headers: ")
                              for header, value in http_response.fields.items():
                                 if isinstance(value, bytes):
                                    print(f"{header}: {value.decode()}")
                                 else:
                                    print(f"{header}: {value}")
                                 if hasattr(packet, 'load') and packet.load:
                                    print("Body: ")
                                    print(packet.load.decode())
                                 else:
                                    print("Body: No body data")
                     else:
                        print(f"No HTTP found on {madrid}")

                  except Exception as e:
                     print(f"Error while Analyzing HTTP packets: {e}")
                     break
               else:
                  print(f"Specify a valid interface. '{madrid}' is incorrect.")
         else:
            print(f"'{ice}' is not a valid option. Please type i or f")

   elif option == "5":
    print("Starting Suricata for network analysis...")
    main()  # This will execute the Suricata script and display the summary

   print("=" * 50)
   print("{:^50}".format("Anomalyzer Summary"))
   print("=" *50)

   print("\nSource IPs:")
   for ip, count in analyzer.src_ips.items():
      print(f"{ip}: {count}")

   print("\nDestination IPs:")
   for ip, count in analyzer.dst_ips.items():
      print(f"{ip}: {count}")

   print("\nTraffic Types:")
   for traffic_type, count in analyzer.traffic_types.items():
      print(f"{traffic_type}: {count}")
