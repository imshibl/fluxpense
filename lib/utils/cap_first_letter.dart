String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input; // Return empty string if input is empty
  }
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}
