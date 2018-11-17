from wmi_client_wrapper import WmiClientWrapper as wcw
from time import time
from statistics import mean
import sys

con = wcw(host="192.168.0.9", username='gbkim', password='3434844')

average = list([])

print("Test Class Name : {0}".format(sys.argv[1]))

for x in range(50):
	start = time()
	print("[{0} Job] : Executed".format(x))
	res = con.query('SELECT * FROM {0}'.format(sys.argv[1]))
	end = time()
	if isinstance(res, list) and len(res) >= 1:
		# print("It's List")
		if isinstance(res[0], dict):
			# print("It's Dict")
			# res = res[0]
			# print(res, type(res))
			# lp = res.get('LoadPercentage')
			# print(res)
			pass
		else:
			# print("It's not Dict")
			# print(res)
			pass
	else:
		# print("Not list")
		# print(res)
		pass
	# end = time()
	print(end-start)
	average.append(end-start)

print("{0} takens to finish 50 times job.".format(mean(average)))
