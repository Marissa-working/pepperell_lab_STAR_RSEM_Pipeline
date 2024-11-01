import re

def replace_spaces_in_ids(gtf_file):
    # Regular expressions to match transcript_id, gene_id, and gene_name
    transcript_pattern = re.compile(r'transcript_id "([^"]+)"')
    gene_id_pattern = re.compile(r'gene_id "([^"]+)"')
    gene_name_pattern = re.compile(r'gene_name "([^"]+)"')

    # Read the file and replace spaces
    with open(gtf_file, 'r') as infile:
        lines = infile.readlines()

    with open(gtf_file, 'w') as outfile:
        for line in lines:
            # Replace spaces inside transcript_id, gene_id, and gene_name with underscores
            line = re.sub(transcript_pattern, lambda m: f'transcript_id "{m.group(1).replace(" ", "_")}"', line)
            line = re.sub(gene_id_pattern, lambda m: f'gene_id "{m.group(1).replace(" ", "_")}"', line)
            line = re.sub(gene_name_pattern, lambda m: f'gene_name "{m.group(1).replace(" ", "_")}"', line)
            
            outfile.write(line)

# Get input from the user
gtf_file = input("Enter the path to your GTF file: ")

# Process the file in-place
replace_spaces_in_ids(gtf_file)

print(f"Processed file: {gtf_file}")
