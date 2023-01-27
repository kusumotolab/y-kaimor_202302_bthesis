import json
#f = open('path2/history.json', 'r', encoding='utf-8')
#classified for convenience
class MyJSONPurser:
    def __init__(self): #initialization
        self.data = None
        self.info = {}
        self.time_total = 0
        self.time_failure = 0
        self.solution_id = -1
        self.solution_time = -1
        self.ftr = 0
        self.soltr = -1.0
    def reset(self):
        self.data = None
        self.time_total = 0
        self.time_failure = 0    
    def purse(self, input, output):
        #f = open(input, 'r', encoding='utf-8')
        #for utf-8
        f = open(input, 'r')
        self.data = json.load(f)
        self.gen_number = len(self.data["variants"])
        self.solution_id = -1
        self.info = {}
        failure_number = 0
        for i in range(0, self.gen_number):
            time = int(self.data['variants'][i]['generationTime'])
            self.time_total += time
            if(self.data['variants'][i]['fitness'] == -1):
                self.time_failure += time
                failure_number += 1
            list = [] #for debug
            print("Number#{}:{}".format(i,(int(self.data['variants'][i]['generationTime']))))
            for j in range(0, len(self.data['variants'][i]['operation']['parentIds'])):
                list.append(j)
                parent_id = self.data['variants'][i]['operation']['parentIds'][j]
                if((self.data['variants'][i]['generationNumber'] > 0) and (self.data['variants'][i]['generationNumber'] - 1 == self.data['variants'][parent_id]['generationNumber'])): #is_previous
                    time += self.info[parent_id]['total_time']
                if(self.data['variants'][i]['fitness'] == 1):
                    def getancestor(id):
                        for i in range(0, len(self.data['variants'][id]['operation']['parentIds'])):
                            parent_id = self.data['variants'][id]['operation']['parentIds'][i]
                            if(parent_id == 0):
                                return
                            else:
                                if(parent_id not in array):
                                    array.append(parent_id)
                                    getancestor(parent_id)
                                else:
                                    return
                    array = []
                    getancestor(i)
                    self.solution_time = self.data['variants'][i]['generationTime']
                    for k in array:
                        self.solution_time += self.data['variants'][k]['generationTime']
            self.info[i] = {"total_time" : time, "variant_gentime" : int(self.data['variants'][i]['generationTime']), "gen" : self.data['variants'][i]['generationNumber'], "parents" : list, "operation" : self.data['variants'][i]['operation']['name']}
            #    print(self.info[i])
            if(self.data['variants'][i]['fitness'] == 1):
                self.solution_id = i
                self.soltr = 1.0 * self.solution_time / self.time_total
            else:
                self.soltr = -1
        self.ftr = 1.0 * self.time_failure / self.time_total
        #out = open(output, 'w', encoding='utf-8')
        out = open(output, 'w')
        out.write("### OUTPUT ###"+"\n")
        for i in range(1, self.gen_number):
            out.write("ID#"+str(i)+" : time : "+str(self.info[i].get("total_time"))+", Operation : "+self.info[i].get("operation") + ", fitness : " + str(self.data['variants'][i]['fitness']) + "\n")
        
        out.write("### Failure Time Ratio ###\n")
        out.write("FTR:" + str(self.ftr)+"("+str(self.time_failure)+"/"+str(self.time_total)+")\n")
        out.write("failure variants:" + str(1.0 * failure_number / (self.gen_number-1))+"("+str(failure_number)+"/"+str(self.gen_number - 1)+")\n")
        if(self.solution_id != -1):
            out.write("### Solution Time Ratio ###\n")
            out.write("the solution ID : "+str(self.solution_id)+"\n")
            out.write("STR:"+str(self.soltr)+"("+str(int(self.solution_time))+"/"+str(self.time_total)+")\n")
        out.close()
#    def getsolutiontime(self, id):
#        def getancestor(id):
#            for i in range(0, len(self.data['variants'][id]['operation']['parentIds'])):
#                parent_id = self.data['variants'][id]['operation']['parentIds'][i]
#                if(parent_id == 0):
#                    return
#                else:
#                    array.append(parent_id)
#                    self.getancestor(parent_id)
#        array = []
#        time = 0
#        getancestor(id)
#        for i in array:
#            time += self.data['variants'][i]['generationTime']
#            return time

# dict.info[2] = {"time" : int(data['variants'][2]['generationTime'])}

instance = MyJSONPurser()
out2 = open("C:/Users/yuuki/Downloads/build/fuga/summary.txt", 'w')
#instance.purse("C:/Users/yuuki/Downloads/build/fuga/Lang6-mini.json", "C:/Users/yuuki/Downloads/build/fuga/result.txt")
for k in range(1,42):
    instance.purse("C:/Users/yuuki/Downloads/build/fuga/Lang"+str(k)+"-mini.json", "C:/Users/yuuki/Downloads/build/fuga/result"+str(k)+".txt")
    out2.write(str(k) + " " + str(instance.ftr)+" "+str(instance.soltr)+"\n")
    

out2.close()
#output
#out = open('c:/users/81804/Downloads/output.txt', 'w', encoding='utf-8')

