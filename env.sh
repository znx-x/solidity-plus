# Environment Variables
set -o pipefail  # Ensures that the exit status of a pipeline is the status of the last command to exit with a non-zero status.
shopt -s expand_aliases  # Allows for the use of aliases within your script.

setLocal() {
    set -o nounset  # Treat unset variables and parameters as an error.
    set -o errexit  # Exit immediately if a command exits with a non-zero status.
}
