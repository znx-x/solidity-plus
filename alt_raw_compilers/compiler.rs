use std::fs::{self, File};
use std::io::{self, BufRead, BufReader, Write};
use std::path::Path;
use std::process::Command;

fn clear_console() {
    Command::new("cmd")
        .args(&["/C", "cls"])
        .status()
        .unwrap();
}

fn process_line(line: &str) -> String {
    if line.contains("original_input") {
        "solidity_output".to_string()
    } // else if (...)
    else {
        line.to_string()
    }
}

fn main() -> io::Result<()> {
    clear_console();

    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        println!("Please provide a valid Solidity+ source file.");
        std::process::exit(1);
    }

    let input_file_path = &args[1];
    let output_file_path = input_file_path.trim_end_matches(".sol").to_owned() + "_compiled.sol";

    if !Path::new(input_file_path).exists() {
        println!("File not found: {}", input_file_path);
        std::process::exit(1);
    }

    if Path::new(&output_file_path).exists() {
        fs::remove_file(&output_file_path)?;
    }

    let input_file = File::open(input_file_path)?;
    let reader = BufReader::new(input_file);

    let mut output_file = File::create(&output_file_path)?;

    for line in reader.lines() {
        let line = line?;
        let processed_line = process_line(&line);
        writeln!(output_file, "{}", processed_line)?;
    }

    println!("Compilation complete. Output file: {}", output_file_path);

    Ok(())
}
