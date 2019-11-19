import system, os, streams, strUtils, json
import httpclient

let target_ip_file = "./iplist.txt"
let client = newHttpClient()
#let client = newAsyncHttpClient()

type whois = object
type rdap = object

proc get_info(who: whois, ip: string): string =
    let ip_file: File = open(target_ip_file, FileMode.fmRead)
    let ip_lines = newStringStream(ip_file.readAll())
    for ip in ip_lines.lines():
        echo ip.whois()

proc get_info(dap: rdap, ip: string): json =
    try:
        let rdap_url = "http://rdap.apnic.net/ip/" & ip
        let content = client.getContent(rdap_url)
        return %*cotent

proc whois(ip: string): string =
    try:
        let ipstr = "http://rdap.apnic.net/ip/" & ip
        let content = client.getContent(ipstr)
        return content
    except:
        echo "error"
    finally:
        echo "complete"


rdap.get_info("124.110.100.168")
