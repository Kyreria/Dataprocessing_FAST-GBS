# Make the first output file
import argparse

def fasta_splitter(fasta_file, output):

    output_r1 = output.R1
    with open(output_r1, 'w') as R1:
        pass
    # Make the second output file
    output_r2 = output.R2
    with open(output_r2, 'w') as R2:
        pass
# Loop through the single file with paired ends and split them into their respective files.
    with open(fasta_file, "r") as input:
        counter = 0
        R2_flag = False
        for line in input:
            match R2_flag:
                case False:
                    with open(output_r1, 'a') as r1:
                        r1.write(line)
                    counter += 1
                    if counter == 4:
                        counter = 0
                        R2_flag = True
                case True:
                    with open(output_r2, 'a') as r2:
                        r2.write(line)
                    counter += 1
                    if counter == 4:
                        counter = 0
                        R2_flag = False
    print("File mangling is done.")


if __name__ =="__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", help="Input fastQ file")
    parser.add_argument("-o", "--output", help="Output for the seperated FastQ files")
    args = parser.parse_args()
    fasta_splitter(args.input, args.output)
