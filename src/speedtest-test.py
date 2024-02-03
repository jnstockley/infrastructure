import speedtest

# servers = ["21020", "62104", "34707", "49772", "11750", "12187", "47744", "50826", "42427", "35781"]
# If you want to test against a specific server
# servers = [1234]

# 47744 -> AT&T IL
# 10145 -> CenturyLink IA

servers = [10145]

threads = None
# If you want to use a single threaded test
# threads = 1

s = speedtest.Speedtest()

s.get_servers(servers)

# s.get_best_server()


# print(s.get_servers(servers=servers))

