import system, os, streams, strUtils, json
import httpclient

const rdap_domain = "http://rdap.apnic.net/ip/"
let target_ip_file = "./ip_list_499_1120.txt"
let client = newHttpClient()
#let client = newAsyncHttpClient()

type whois = object
type rdap = object

proc get_info(dap: rdap, ip: string): string =
    try:
        let rdap_url = rdap_domain & ip
        let content = client.getContent(rdap_url)
        return content
    except:
        discard
    finally:
        discard

proc get_whois(ip: string): string =
    try:
        let ipstr = "http://rdap.apnic.net/ip/" & ip
        let content = client.getContent(ipstr)
        return content
    except:
        discard
        #echo "error"
    finally:
        discard
        #echo "complete"

proc get_info(who: whois, ip: string): TaintedString =
    let ip_file: File = open(target_ip_file, FileMode.fmRead)
    let ip_lines = newStringStream(ip_file.readAll())
    for ip in ip_lines.lines():
        echo ip.get_whois()

var dap = rdap()
let ip_file: File = open(target_ip_file, FileMode.fmRead)
let ip_lines = newStringStream(ip_file.readAll())
for ip in ip_lines.lines():
    #echo ip.get_whois()
    try:
        echo dap.get_info(ip)
    finally:
        discard
#echo dap.get_info("124.110.100.168")
