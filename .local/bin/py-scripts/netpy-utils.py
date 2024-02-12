import os, sys
import argparse

class SmartFormatter(argparse.HelpFormatter):

    def _split_lines(self, text, width):
        if text.startswith('R|'):
            return text[2:].splitlines()
        # this is the RawTextHelpFormatter._split_lines
        return argparse.HelpFormatter._split_lines(self, text, width)

parser = argparse.ArgumentParser(prog='netpy-utils', usage="%(prog)s [OPTIONS] ...", description="Python tool to perform fast calculation with networks.", formatter_class=SmartFormatter)

parser.add_argument('-v', '--version', action='version', version='%(prog)s 3.0')
parser.add_argument('-hf', '--hostsfile', type=str, metavar='', required=False, help="file with hosts")
parser.add_argument('-of', '--ogfile', type=str, metavar='', required=False, help="file with the original network mask")
parser.add_argument('-nf', '--newfile', type=str, metavar='', required=False, help="file with the new network mask")
parser.add_argument('-cmb', '--convertmb', type=str, metavar='', required=False, help="mask in format a.b.c.d to convert to binary")
parser.add_argument('-cbm', '--convertbm', type=str, metavar='', required=False, help="binary in format bin_octate.bin_octate.bin_octate.bin_octate to convert to mask")
parser.add_argument('-i', '--interactive', action='store_true', help="interactively gets network ip given ip_host:og_mask:new_mask,(...)")
parser.add_argument('-p', '--prefixes', action='store_true', help="prints prefixes table.")

args = parser.parse_args()

def string_to_bin_to_decimal(string_aux):
    decimal = 0

    for digit in string_aux: # 11 000 000
        decimal = decimal*2 + int(digit)

    return decimal


def string_to_decimal_to_bin(string_aux):
    aux = ""
    num = int(string_aux)
    num = bin(num).replace("0b", "")

    if len(num) != 8:
        while (len(aux) + len(num)) != 8:
            aux += "0"

    return aux + num



def mask_to_bin(mask):
    converted_nuger = ""
    aux = ""

    for i in range(len(mask)):

        if mask[i] == ".": # make conversion
            converted_nuger += str(string_to_decimal_to_bin(aux)) + "."
            aux = ""

        else:
            aux += mask[i]

    return (converted_nuger)

def bin_to_mask(bin_num):
    converted_nuger = ""
    bin_num = bin_num.replace(" ", "")
    aux = ""

    for i in range(len(bin_num)):

        if bin_num[i] == ".": # if is met then convert to decimal
            converted_nuger += str(string_to_bin_to_decimal(aux)) + "."
            aux = ""

        else:
            aux += bin_num[i]

    return (converted_nuger)


def get_net_of_subnet(net1, net2): # apply and operation to find the new host network address
    result = ""
    ans = ""
    net1 = net1.replace(" ", "")
    net1 = net1.replace(".", "")
    net2 = net2.replace(" ", "")
    net2 = net2.replace(".", "")

    for i in range(len(net1)):
        result += str(int(net1[i]) and int(net2[i])) # applies and

    for i in range(len(result)): # parses the new network address
        if (i+1) % 8 == 0:
            ans += result[i] + "."
        else:
            ans += result[i]

    return ans


def get_broadcast_addr(net1, net2):
    result = ""
    ans = ""

    net1 = net1.replace(" ", "")
    net1 = net1.replace(".", "")

    net2 = net2.replace(" ", "")
    net2 = net2.replace(".", "")

    for i in range(len(net1)):
        a = int(net1[i])
        b = int(net2[i])

        if b == 0:
            result += str(1)
        elif b == 1:
            result += str(int(net1[i]) and int(net2[i]))


    for i in range(len(result)):
        if (i+1) % 8 == 0:
            ans += result[i] + "."
        else:
            ans += result[i]

    return ans


def get_bits(bin_num):
    ones = 0

    for i in range(len(bin_num)):
        if bin_num[i] == "1": # if is met then convert to decimal
            ones += 1

    return ones


def new_network_ips_table(hosts, og_subnets, new_masks):

    for i in range(len(hosts)):
        hosts[i] += "."
        og_subnets[i] += "."
        new_masks[i] += "."

    print("\n| -------------------------------- |\n")
    for i in range(len(hosts)):

        print("::- Starting information:\n")
        print("Original net:", hosts[i][:-1])
        print("Original net in binary:", mask_to_bin(hosts[i])[:-1], "\n")

        print("Original subnet:", og_subnets[i][:-1])
        print("Original subnet in binary", mask_to_bin(og_subnets[i])[:-1], "\n")

        print("New subnet mask:", new_masks[i][:-1])
        print("New subnet mask in binary:", mask_to_bin(new_masks[i])[:-1], "\n")

        # Perform calculations
        new_subnet_mask_bits = get_bits(mask_to_bin(new_masks[i])) # counts bits in new subnet mask
        og_subnet_mask_bits = get_bits(mask_to_bin(og_subnets[i])) # counts bits in old subnet mask

        subnets_bits = new_subnet_mask_bits - og_subnet_mask_bits # new subnet bits
        subnets_created = 2**subnets_bits # nuger of subnets created

        num_of_host_bits_per_subnet = 32 - new_subnet_mask_bits # nuger of hosts will be the 32 - the number of new subnet bits
        num_of_host_per_subnet = (2**num_of_host_bits_per_subnet) - 2 # actual hosts will be 2^new hosts bits - 2
        new_subnet = get_net_of_subnet(mask_to_bin(hosts[i]), mask_to_bin(new_masks[i]))

        old_subnets_created = 2**og_subnet_mask_bits
        num_of_old_bits_per_subnet = 32 - og_subnet_mask_bits
        num_of_old_host_per_subnet = (2**num_of_host_bits_per_subnet) - 2

        print(":: Old subnets and hosts with old subnet mask")
        print("Number of subnet bits:", og_subnet_mask_bits)
        print("Number of subnets created:", old_subnets_created)
        print("Number of old hosts bits per subnet:", num_of_host_bits_per_subnet)
        print("Number of hosts per subnet:", num_of_host_per_subnet)

        # Information of new subnets and hosts created with the new subnet mask given the old one
        print("::- New subnets and hosts created with the new subnet mask:\n")
        print("Number of subnet bits:", subnets_bits)
        print("Number of subnets created:", subnets_created)
        print("Number of host bits per subnet:", num_of_host_bits_per_subnet)
        print("Number of hosts per subnet:", num_of_host_per_subnet)

        print("New subnet address:", bin_to_mask(new_subnet)[:-1])
        print("New subnet in binary:", new_subnet[:-1], "\n")

        print("IP broadcast", bin_to_mask(get_broadcast_addr(mask_to_bin(hosts[i]), mask_to_bin(new_masks[i])))[:-1])
        print("\n| -------------------------------- |")


def interactive():
    aux = ""

    data = input("Enter a hosts, original subnet mask and new subnet in the following format: host:original subnet:new_mask\n")
    hosts = list()
    og_subnets = list()
    new_masks = list()

    host_bool = False
    subnet_bool = False

    data = data.replace(" ", "")

    for currChar in data:
        if currChar == ":" and host_bool == False: # if a host hasn't been detected
            hosts.append(aux)
            host_bool = True
            aux = ""
        elif currChar == ":" and subnet_bool == False:
            og_subnets.append(aux)
            subnet_bool = True
            aux = ""
        elif currChar == ",": # if we reach a comma, then more data will be inputted
            new_masks.append(aux)
            aux = ""
            host_bool = False
            subnet_bool = False
        else:
            aux += currChar

    new_masks.append(aux)

    new_network_ips_table(hosts, og_subnets, new_masks)

def get_data_from_file(path):
    data = list()

    f = open(path, 'r')

    for line in f:
        data.append(line)

    f.close()

    return data


def prefixes():

    aux_arr = [0, 128, 192, 224, 240, 248, 252, 254, 255]
    aux = 1

    print("|   CIDR    |    Decimal    |   Subnets  |     Hosts    |")
    for i in range(1, 9):
        result = f"{aux_arr[aux]}.{aux_arr[0]}.{aux_arr[0]}.{aux_arr[0]}"
        subnet_mask_bits = get_bits(mask_to_bin(result + "."))
        subnets_created = 2**subnet_mask_bits
        bits_per_subnet = 32 - subnet_mask_bits
        hosts_per_subnet = (2**bits_per_subnet)

        print(f"     /{i}        {result}           {subnets_created}",end="")
        print(f"        {hosts_per_subnet}")
        aux += 1

    aux = 1
    for i in range(9, 17):

        if i == 9:
            result = f"{aux_arr[8]}.{aux_arr[aux]}.{aux_arr[0]}.{aux_arr[0]}"
            subnet_mask_bits = get_bits(mask_to_bin(result + "."))
            subnets_created = 2**subnet_mask_bits
            bits_per_subnet = 32 - subnet_mask_bits
            hosts_per_subnet = (2**bits_per_subnet)

            print(f"     /{i}        {result}         {subnets_created}",end="")
            print(f"        {hosts_per_subnet}")
            aux += 1
        else:
            result = f"{aux_arr[8]}.{aux_arr[aux]}.{aux_arr[0]}.{aux_arr[0]}"
            subnet_mask_bits = get_bits(mask_to_bin(result + "."))
            subnets_created = 2**subnet_mask_bits
            bits_per_subnet = 32 - subnet_mask_bits
            hosts_per_subnet = (2**bits_per_subnet)

            print(f"     /{i}       {result}         {subnets_created}",end="")
            print(f"        {hosts_per_subnet}")
            aux += 1

    aux = 1
    for i in range(17, 25):
        result = f"{aux_arr[8]}.{aux_arr[8]}.{aux_arr[aux]}.{aux_arr[0]}"
        subnet_mask_bits = get_bits(mask_to_bin(result + "."))
        subnets_created = 2**subnet_mask_bits
        bits_per_subnet = 32 - subnet_mask_bits
        hosts_per_subnet = (2**bits_per_subnet)

        print(f"     /{i}       {result}       {subnets_created}",end="")
        print(f"        {hosts_per_subnet}")

        aux += 1

    aux = 1
    for i in range(25, 33):
        result = f"{aux_arr[8]}.{aux_arr[8]}.{aux_arr[8]}.{aux_arr[aux]}"
        subnet_mask_bits = get_bits(mask_to_bin(result + "."))
        subnets_created = 2**subnet_mask_bits
        bits_per_subnet = 32 - subnet_mask_bits
        hosts_per_subnet = (2**bits_per_subnet)

        print(f"     /{i}       {result}     {subnets_created}",end="")
        print(f"        {hosts_per_subnet}")

        aux += 1


if __name__ == '__main__':

    if args.prefixes:
        prefixes()
        exit()

    if args.interactive:
        interactive()
        exit()

    if isinstance(args.convertmb, str):
        print(mask_to_bin(args.convertmb + ".")[:-1])
        exit()

    if isinstance(args.convertbm, str):
        print(bin_to_mask(args.convertbm + ".")[:-1])
        exit()

    if args.hostsfile is not None:
        if args.ogfile is not None:
            if args.newfile is not None:
                new_network_ips_table(get_data_from_file(args.hostsfile), get_data_from_file(args.ogfile), get_data_from_file(args.newfile))
                exit()
            else:
                print("Error. Some of the input files were not define passed.For more information use netpy-tools -h")
                exit()
        else:
            print("Error. Some of the input files were not define passed. For more information use netpy-tools -h")
            exit()


    parser.print_help()
