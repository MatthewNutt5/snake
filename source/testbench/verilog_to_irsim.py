# Python script for converting verilog testbench to IRSIM grid form
# Specifically built for snake game - not generalized
# Only operates on the section between "begin" and $dumpfile, etc.
# Make a separate file with all other parts removed

read_filename = input("Input file: ")
read_file = open(read_filename, 'r')

write_filename = input("Output file: ")
write_file = open(write_filename, 'w')

persist_digit = 0



def writeVector():
    # write 40 per line, insert extra line afterwards
    for i, digit in enumerate(write_line):
        write_file.write(str(digit))
        write_file.write(' ')
        if (i+1) % 40 == 0 and i > 0:
            write_file.write('\n')
    write_file.write('\n')



# write in_restart line
write_line = []
for line in read_file:
    line = line.strip()
    elems = line.split()
    assign_elems = line.split('=')
    
    if assign_elems[0].strip() == "in_restart":
        persist_digit = int(assign_elems[1].strip()[0])
        
    if len(elems) > 0 and elems[0].strip() == "`CLOCK":
        write_line.append(persist_digit)
        
writeVector()
read_file.seek(0)

# write in_direction_in\[0\] line
write_line = []
for line in read_file:
    line = line.strip()
    elems = line.split()
    assign_elems = line.split('=')
    
    if assign_elems[0].strip() == "in_direction_in":
        persist_digit = int(assign_elems[1].strip()[6])
        
    if len(elems) > 0 and elems[0].strip() == "`CLOCK":
        write_line.append(persist_digit)
        
writeVector()
read_file.seek(0)

# write in_direction_in\[1\] line
write_line = []
for line in read_file:
    line = line.strip()
    elems = line.split()
    assign_elems = line.split('=')
    
    if assign_elems[0].strip() == "in_direction_in":
        persist_digit = int(assign_elems[1].strip()[5])
        
    if len(elems) > 0 and elems[0].strip() == "`CLOCK":
        write_line.append(persist_digit)
        
writeVector()
read_file.seek(0)

# write in_direction_in\[2\] line
write_line = []
for line in read_file:
    line = line.strip()
    elems = line.split()
    assign_elems = line.split('=')
    
    if assign_elems[0].strip() == "in_direction_in":
        persist_digit = int(assign_elems[1].strip()[4])
        
    if len(elems) > 0 and elems[0].strip() == "`CLOCK":
        write_line.append(persist_digit)
        
writeVector()
read_file.seek(0)

# write in_direction_in\[3\] line
write_line = []
for line in read_file:
    line = line.strip()
    elems = line.split()
    assign_elems = line.split('=')
    
    if assign_elems[0].strip() == "in_direction_in":
        persist_digit = int(assign_elems[1].strip()[3])
        
    if len(elems) > 0 and elems[0].strip() == "`CLOCK":
        write_line.append(persist_digit)
        
writeVector()
read_file.seek(0)



read_file.close()
write_file.close()
