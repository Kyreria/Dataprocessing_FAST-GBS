"""
This script generates random forward and reverse FASTA files for use with the Snakemake Pipeline.
"""


# Imports
import argparse
import random
import string


def reverse_complement(sequence):
    # Reverse complements
    complement = {'A': 'T', 'C': 'G'}
    return ''.join(complement.get(base, base) for base in reversed(sequence))


def barcode_selector():
    # Select one of the barcodes with a chance of not having one, this is the "unknown barcode".
    barcodes = ["GAGAGTGT", "GAGTCACT", ""]
    return ''.join(random.choices(barcodes, weights=[10, 10, 1]))


def dna(length):
    # Generates a random DNA strand based on the provided length
    return ''.join(random.choice('CGTA') for _ in range(length))


def readname_generator(namelength):
    # Generates a random filler readname generator to go behind the > in the fasta.
    return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(namelength))


def random_fasta_generator(read_count, filename):
    # Variables for the fasta generator
    name_length = 12
    sequence_length = 160
    forward_file = filename + "_R1" + ".fasta"
    reverse_file = filename + "_R2" + ".fasta"

    # This for loop generates the files
    for i in range(read_count):
        read_name = ">" + readname_generator(name_length)
        sequence = barcode_selector() + dna(sequence_length)
        reverse_sequence = reverse_complement(sequence)
        # Write the forward read.
        with open(forward_file, "a") as fw:
            fw.write(read_name + "\n" + sequence + "\n")
        # Write the reverse read
        with open(reverse_file, "a") as rw:
            rw.write(read_name + "\n" + reverse_sequence + "\n")


if __name__ == '__main__':
    # Parse the arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--length", type=int, help="Length of the FASTA", required=True)
    parser.add_argument("-o", "--output", help="Output name for the fasta files", required=True)
    args = parser.parse_args()

    # Run the generator
    random_fasta_generator(args.length, args.output)
