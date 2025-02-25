from collections import Dict, List


fn main() raises:
  # Create a dictionary with String keys and List[Int] values
  var dict_of_lists = Dict[String, List[Int]]()

  # Add some lists to the dictionary
  dict_of_lists["even"] = List(2, 4, 6, 8)
  dict_of_lists["odd"] = List(1, 3, 5, 7)


  dict_of_lists["even"].append(10)
  for i in dict_of_lists["even"]:
    print(str(i[]))

  if 7 in dict_of_lists["even"]:
    print("Existe")
  else:
    print("no existe")

  var dict_of_ = Dict[String, List[Int]]()

  # Add some lists to the dictionary
  var a = List(2, 4, 6, 8)
  var b = 10

  for i in (a + List[Int](b)):
    print(str(i[]))


  
