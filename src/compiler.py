import sys
import re
import os

interfaces_dir = './interfaces'

# Loading animation frames
animation_frames = [
    "[ - - - ]",
    "[ . - - ]",
    "[ - . - ]",
    "[ - - . ]",
    "[ . - . ]",
    "[ - . . ]",
    "[ . . . ]",
    "[ - . . ]",
    "[ . - . ]",
    "[ . . - ]",
    "[ - . - ]",
    "[ . - - ]",
]

def display_animation_step(step):
    """Displays a single step of the animation."""
    sys.stdout.write("\r" + animation_frames[step % len(animation_frames)])  # \r moves the cursor to the beginning of the line
    sys.stdout.flush()

def get_interface_content(interface_name):
    """Reads the content of the specified interface file."""
    try:
        with open(os.path.join(interfaces_dir, f'{interface_name}.sol'), 'r') as file:
            return file.read()
    except FileNotFoundError:
        print(f"Error: Interface file for {interface_name} not found.")
        sys.exit(1)

def transform_line(line, output_file):
    transformed = False
    
    # Header syntax simplification
    line = line.replace('set license', '// SPDX-License-Identifier: ')
    line = line.replace('set compiler', 'pragma solidity ^')
    line = line.replace('call', 'import')

    # OpenZeppelin imports
    line = line.replace('use ETH IERC20 OpenZeppelin', "import '@openzeppelin/contracts/token/ERC20/IERC20.sol';")
    line = line.replace('use ETH IERC721 OpenZeppelin', "import '@openzeppelin/contracts/token/ERC721/IERC721.sol';")

    # Visibility and mutability keywords simplification
    line = line.replace('visible', 'public')
    line = line.replace('hidden', 'private')
    line = line.replace('changeable', 'nonpayable')
    line = line.replace('constant', 'view')
    line = line.replace('immutable', 'pure')
    line = line.replace('protected', 'internal')

    # Type simplifications
    line = line.replace('account', 'address')
    line = line.replace('num8', 'uint8')
    line = line.replace('num16', 'uint16')
    line = line.replace('num32', 'uint32')
    line = line.replace('num64', 'uint64')
    line = line.replace('number', 'uint256')

    # Function modifiers simplification (example for onlyOwner)
    line = line.replace('restrictedToOwner=', 'modifier onlyOwner { require(msg.sender == owner, "Not the owner"); _; }')

    # Event declaration and emission simplification
    line = line.replace('trigger', 'emit')

    # Custom syntax for error handling
    line = line.replace('error', 'revert with')

    # Inline assembly blocks
    line = line.replace('asm', 'assembly')

    # Variable storage locations simplification
    line = line.replace('mem', 'memory')
    line = line.replace('storage', 'storage')

    # Function overloading indication
    line = line.replace('overloaded', '/* overloaded */')

    if 'use ETH IERC20' in line:
        interface_content = get_interface_content('IERC20')
        output_file.write(interface_content + '\n')
        return '', True  # Return True to indicate this line should be skipped in further processing
    elif 'use ETH IERC721' in line:
        interface_content = get_interface_content('IERC721')
        output_file.write(interface_content + '\n')
        return '', True

    return line, False

def process_file(input_file_path, output_file_path):
    with open(input_file_path, 'r') as input_file, open(output_file_path, 'w') as output_file:
        animation_step = 0
        for i, line in enumerate(input_file):
            if i % 5 == 0:  # Change the animation every 5 lines processed
                display_animation_step(animation_step)
                animation_step += 1
            
            # Attempt to transform each line, this will check for header transformations and interface usage
            transformed, should_skip = transform_line(line, output_file)
            
            # If the line was specifically an interface usage, it's already handled within transform_line
            if not should_skip:
                output_file.write(transformed)  # Write the transformed or original line

    # Clear the animation once complete
    sys.stdout.write("\r" + " " * len(animation_frames[-1]) + "\r")
    sys.stdout.flush()

if __name__ == '__main__':
    if len(sys.argv) > 2:
        input_file_path = sys.argv[1]
        output_file_path = sys.argv[2]
        process_file(input_file_path, output_file_path)
        print("Compilation complete.")  # Print completion message after clearing the animation
    else:
        print("Insufficient arguments provided. Usage: python compiler.py <input_file> <output_file>", file=sys.stderr)
