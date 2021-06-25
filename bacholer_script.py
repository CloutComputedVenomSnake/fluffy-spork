import sys
import fileinput


addIncludes = False
beginMainFlag = False #to add the reset and start measuring
resetAndStart = False #reset and and start are added
endMeasuring = False #end measuring added

codeSection = "dosmth"
counter = 1

stack = []
listOfCodeSections = ["dosmth","dosmth3", "beg","beginsmth", "thirdMethodTest"]
listOfUniqueCodeSections = [] #do i enter only unique elements??? check if one element is a substring of another element

for i in listOfCodeSections:
    foundElseWhere = False
    for j in listOfCodeSections:
        if ((j in i)) and listOfCodeSections.index(i) != listOfCodeSections.index(j):
            foundElseWhere = True
    if foundElseWhere == False:
        listOfUniqueCodeSections.append(i)



print(listOfUniqueCodeSections)
for currentMethod in listOfUniqueCodeSections:
    print(currentMethod)
    endMainFlag = False
    enteredMain = False
    foundSection = False
    for i, line in enumerate(fileinput.input('C:/Users/DELL/Desktop/Python Script Test File/new 1.txt', inplace=1)):
        if beginMainFlag and resetAndStart == False:
            print("PERF_RESET(PERFORMANCE_COUNTER_BASE);\nPERF_START_MEASURING(PERFORMANCE_COUNTER_BASE);")
            beginMainFlag = False
            resetAndStart = True
        if foundSection == True:
            sys.stdout.write("PERF_END (PERFORMANCE_COUNTER_BASE,"+""+ str(counter) +""+");\n")
            if counter == 7:
                counter = 1
            else:    
                counter += 1
            
            foundSection = False
        if (line.find(currentMethod) != -1):
            sys.stdout.write("PERF_BEGIN (PERFORMANCE_COUNTER_BASE,"+""+ str(counter) +""+");\n") 
            foundSection = True
        if (line.find('}')!=-1 and (len(stack) != 0) and enteredMain):
            stack.pop()
            if len(stack) == 0 and endMeasuring == False:
                #reached end of main
                print("PERF_STOP_MEASURING(PERFORMANCE_COUNTER_BASE);\nperf_print_formatted_report(PERFORMANCE_COUNTER_BASE, alt_get_cpu_freq(), 2, FIRST COL, SECOND COL);")
                enteredMain = False
                endMeasuring = True
        if addIncludes == False:
            print("#include <io.h>\n#include <altera_avalon_performance_counter.h>")#first includes
            addIncludes = True
    
        if (line.find('main') != -1) and (line.find('{') != -1):
            #found main
            beginMainFlag = True
            enteredMain = True
            stack.append('{')
        sys.stdout.write(line) #write the line you read
        


