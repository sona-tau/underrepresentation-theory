import os
print(f"Working Directory: {os.getcwd()}")

new_directory_path = "/Users/jalexander/Documents/GitHub/survey-questions/text"
os.chdir(new_directory_path)
print(f"New Working Directory: {os.getcwd()}")

# File paths
input_file = "ipeds fall enrollment 2year.pdf.txt"  # Replace with your input file path
output_file = "intermediate.txt"  # Replace with your desired output file path

# Step 1: Read the input file
with open(input_file, "r") as file:
    lines = file.readlines()

# Step 2: Process each line
#processed_lines = [f'"{line.strip()}",\n' for line in lines]
# Skip empty lines and wrap the rest in quotes with a comma
processed_lines = [f'"{line.strip()}",\n' for line in lines if line.strip() != ""]

# Step 3: Write to the output file
with open(output_file, "w") as file:
    file.writelines(processed_lines)

print(f"Processed {len(lines)} lines and saved to {output_file}.")
