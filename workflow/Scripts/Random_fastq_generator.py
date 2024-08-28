"""
This script generates random forward and reverse FASTQ files for use with the Snakemake Pipeline.
This is only for dummy data and testing purposes.
"""


# Imports
import argparse
import random
import string


def reverse_complement(sequence):
    """
    This function reverse complements the given DNA sequence using a dict.
    :param sequence: A string, the given DNA sequence to reverse complement.
    :return: Returns the reverse complemented DNA sequence
    """
    # Reverse complements
    complement = {'A': 'T', 'C': 'G'}
    return ''.join(complement.get(base, base) for base in reversed(sequence))


def barcode_selector():
    """
    This function uses a generator object together with random.choices to choose a random barcode
    depending on the weights attached.
    :return: Returns one of the selected barcodes as a string.
    """
    # Select one of the barcodes with a chance of not having one, this is the "unknown barcode".
    barcodes = ["GAGAGTGT", "GAGTCACT", ""]
    return ''.join(random.choices(barcodes, weights=[10, 10, 1]))


def dna(length):
    """
    This function uses a generator object and only the four letters of DNA 'CGTA'
    to make a random DNA sequence for the length that was requested.
    :param length: An integer, representing the length of the random DNA sequence
    :return: Returns the random DNA sequence string.
    """
    # Generates a random DNA strand based on the provided length
    return ''.join(random.choice('CGTA') for _ in range(length))


def read_name_generator(name_length):
    """
    This function uses a generator object to randomly make string consisting of letters and numbers.
    :param name_length: an int, how long the read name should be.
    :return: returns the read name string.
    """
    # Generates a random filler read_name generator to go behind the > in the fasta.
    return ''.join(random.choice(string.ascii_uppercase + string.digits)
                   for _ in range(name_length))


def random_fastq_generator(read_count, file_name):
    """
    This is the generator for the fastq files.
    :param read_count: An int, the amount of reads to generate
    :param file_name: A string, the name of the fastq forward and reverse files to generate
    :return: Doesn't return anything, produces 2 files instead, a forward and reverse fastq file.
    """
    # Variables for the fasta generator
    name_length = 12
    sequence_length = 160
    forward_file = file_name + "_R1" + ".fastq"
    reverse_file = file_name + "_R2" + ".fastq"

    # This for loop generates the files
    for i in range(read_count):
        read_name = "@" + read_name_generator(name_length)

        # These 2 sequences are for debugging
        # sequence = barcode_selector() + dna(sequence_length)
        sequence = dna(sequence_length)

        reverse_sequence = reverse_complement(sequence)
        quality_score = ''.join('F' for _ in range(sequence_length))

        # Write the forward read.
        with open(forward_file, "a") as fw:
            read_name_forward = read_name + ".1"
            fw.write(read_name_forward + "\n" + sequence + "\n" + "+" + "\n" + quality_score + "\n")
        # Write the reverse read
        with open(reverse_file, "a") as rw:
            read_name_reverse = read_name + ".2"
            rw.write(read_name_reverse + "\n" + reverse_sequence + "\n" + "+" + "\n" + quality_score + "\n")


if __name__ == '__main__':
    # Parse the arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--length", type=int,
                        help="Length of the FASTA", required=True)
    parser.add_argument("-o", "--output",
                        help="Output name for the fasta files", required=True)
    args = parser.parse_args()

    # Run the generator
    random_fastq_generator(args.length, args.output)
