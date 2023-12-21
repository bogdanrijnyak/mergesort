#!/bin/bash
# Generate an array of 16 random numbers between 0 and 99
for i in {1..16}; do
 arr[$i]=$((RANDOM % 100))
done
# Define the merge sort function
function merge_sort {
 local arr=("$@") # Create a local array variable with the input arguments
 local len=${#arr[@]} # Get the length of the array
 if (( len > 1 )); then # Check if the array has more than one element
 local mid=$((len / 2)) # Calculate the midpoint of the array
 local -a left=( "${arr[@]:0:mid}" ) # Create a new array with the left half of 
the input array
 local -a right=( "${arr[@]:mid:len}" ) # Create a new array with the right half 
of the input array
 left=( $(merge_sort "${left[@]}") ) # Recursively call the merge_sort function 
on the left array
 right=( $(merge_sort "${right[@]}") ) # Recursively call the merge_sort function 
on the right array
 arr=( $(merge "${left[@]}" "${right[@]}") ) # Merge the left and right arrays 
using the merge function
 fi
 echo "${arr[@]}" # Return the sorted array
}
# Define the merge function
function merge {
 local left=("$@") # Create a local array variable with the input arguments
 local right=() # Create an empty array
 local result=() # Create an empty array to store the merged array
 if (( $# == 0 )); then # If the input array is empty, return an empty array
 echo "${result[@]}"
 elif (( $# == 1 )); then # If the input array has only one element, return that 
element
 echo "${left[@]}"
 else
 right=("${left[@]:$(( $#/2 ))}") # Split the input array into two arrays, with 
the right array containing the second half of the elements
 left=("${left[@]:0:$(( $#/2 ))}") # The left array contains the first half of 
the elements
 local i=1 # Set a counter variable to 1
 while (( ${#left[@]} > 0 )) && (( ${#right[@]} > 0 )); do # Continue looping as 
long as both arrays are not empty
 if (( left[0] < right[0] )); then # Compare the first elements of the left and 
right arrays
 result+=(${left[0]}) # Add the smaller element to the result array
 left=("${left[@]:1}") # Remove the first element from the left array
 else
 result+=(${right[0]}) # Add the smaller element to the result array
 right=("${right[@]:1}") # Remove the first element from the right array
 fi
 done
 result+=("${left[@]}") # Add any remaining elements from the left array to the 
result array
 result+=("${right[@]}") # Add any remaining elements from the right array to the 
result array
 echo "${result[@]}" # Return the merged array
 fi
}
# Call the merge sort function with the array
sorted_arr=( $(merge_sort "${arr[@]}") )
# Print the sorted array
echo "Original array: ${arr[@]}"
echo "Sorted array: ${sorted_arr[@]}"
