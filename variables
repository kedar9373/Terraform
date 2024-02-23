resource "aws_iam_user" "user_1" {
  name = "var.aws_iam_user-user_1-name"
}
variable "aws_iam_user-user_1-name" {
  type = string
  default = "aws_users"
}
--------------------------------------------------------------------

resource "aws_iam_user" "user_2" {
  name = "var.aws_iam_user-user_2-number"
}
variable "aws_iam_user-user_2-number" {
  type = number
  default = 110
}
---------------------------------------------------------------------

resource "aws_iam_user" "user_3" {
  name = var.aws_iam_user-user_3-list[4]
}
variable "aws_iam_user-user_3-list" {
  type = list
  default = ["tanaji","audhut","rinki","vishal","vaishnavi"]
  #             0        1        2        3          4    
}
----------------------------------------------------------------------

resource "aws_iam_user" "user_4" {
  name = var.aws_iam_user-user_4-map.a3
}
variable "aws_iam_user-user_4-map" {
  type = map
  default = {
    a1 = "omkar"
    a2 = "ganesh"
    a3 = "sairaj"
    a4 = "komal"
  }
  }
-----------------------------------------------------------------------

resource "aws_iam_user" "user_5" {
  name = var.aws_iam_user-user_5-any.a3[2]
}
variable "aws_iam_user-user_5-any" {
  type = any
  default = {
    a1 = "omkar"
    a2 = 1110
    a3 = ["tanaji","audhut","rinki","vishal","vaishnavi"]
    a4 = {
        a4_1 = "pune"
        a4_2 = "mumbai"
        a4_3 = "satara"
        nashik = "maharashtra"
    }
  }
  }
------------------------------------------------------------------------


