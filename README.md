# Solidity+

Welcome to Solidity+, a project aimed at enhancing the Solidity programming experience through the introduction of a superset language. Solidity+ is designed to extend the capabilities of traditional Solidity, offering a suite of enhanced functions and a streamlined approach to smart contract development.

## Project Overview

Solidity+ is born out of a passion for blockchain technology and a desire to simplify and empower the development process of smart contracts. By employing a modified syntax with built-in interface calling and other tools, .xsol files facilitate a more efficient, powerful, and user-friendly coding experience.

## Development Status

Currently, Solidity+ is in the early stages of development. The project is experimental, exploring new ways in smart contract programming. While the compiler and core functionalities are under construction, the vision is clear—to provide a flexible and accessible tool for developers to bring their smart contracts to life.

## The Compiler

After tinkering with a few different languages, I have settled on Python for the main compiler, that can be called using the built-in `compile.cmd` script for Windows environments or the `compile.sh` script if you are working on Linux or MacOS - both call the same `compiler.py` compiler script.

### Compile Your Code

#### Requirements
- Pyhthon installed
- Git (if you are cloning it)

To compile your `.xsol` file you can just call the compiler using the appropriate script (for either Windows, Linux, or MacOS) declaring the file you want to compile, inside the `src` folder. For a test run, you can compile the the provided `example.xsol` file using the command below:

First clone and navigate to the `src` folder.
```cmd
git clone https://github.com/znx-x/solidity-plus.git ; cd solidity-plus\src
```

Call the compiler script using `.\compile` and specify the `.xsol` file path - in this case `example.xsol`.
```cmd
.\compile example.xsol
```

After compiling your Solidity+ file, the output file should be `original-file-name_compiled.sol` and it is ready to be deployed using Remix, Hardhat or any other Solidity compiler.

### Future UI for Compiling and Deploying

Once the development of the superset is complete (at least in its first usable iteration) I will work on a UI/frontend so Solidity+ files can be deployed directly on chain, without the need for it to be converted into a Solidity file to then be deployed.

## Get Involved

As Solidity+ evolves, documentation and additional resources will become available, offering guidance and support for those interested in exploring the capabilities of this superset language.

Your feedback, suggestions, and contributions are welcome.