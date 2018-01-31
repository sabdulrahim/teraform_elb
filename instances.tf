# Provision 2 ec2 instances
resource "aws_instance" "jh-instance" {
  ami                         = "${lookup(var.region_ami, var.aws_region)}"
  instance_type               = "t2.micro"
  count                       = 2
  vpc_security_group_ids      = ["${aws_security_group.webservers_sg.id}"]
  subnet_id                   = "${element(aws_subnet.subnets.*.id,count.index)}"
  user_data                   = "${file("webser.sh")}"
  associate_public_ip_address = true

  tags {
    Name       = "ByTerraform"
    Department = "Training"
  }
}
