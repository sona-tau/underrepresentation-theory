import os
new_directory_path = "/Users/jalexander/Documents/GitHub/survey-questions/text"
os.chdir(new_directory_path)

'''
input_file = "intermediate.txt"  # Replace with your input file path
output_file = "output.txt"  # Replace with your desired output file path

# Step 1: Read the input file
with open(input_file, "r") as file:
    lines = file.readlines()

# Step 2: Process each line
#processed_lines = [f'"{line.strip()}",\n' for line in lines]
# Skip empty lines and wrap the rest in quotes with a comma
#processed_lines = [f'({line.strip()}),\n' for line in lines if line.strip() != ()]
processed_lines = [f'({line.strip()}),\n' for line in lines if line.strip()]

one_line_output = "[" + ", ".join(processed_lines) + "]\n"

# Step 3: Write to the output file
with open(output_file, "w") as file:
    file.writelines(processed_lines)

print(f"Processed {len(lines)} lines and saved to {output_file}.")
'''


input_file = "intermediate.txt"
output_file = "output.txt"

# Step 1: Read the input file
with open(input_file, "r") as file:
    lines = file.readlines()

# Step 2: Skip empty lines and strip whitespace
processed_items = [f"({line.strip()})" for line in lines if line.strip()]

# Step 3: Join all items into a single-line list
one_line_output = "[" + ", ".join(processed_items) + "]\n"

# Step 4: Write to the output file
with open(output_file, "w") as file:
    file.write(one_line_output)

print(f"Processed {len(processed_items)} non-empty lines and saved to {output_file}.")

second_output_file = "Ipeds_output.txt"

with open(second_output_file, "a") as file:
    file.write(one_line_output)

print(f"Also saved to {second_output_file}.")
