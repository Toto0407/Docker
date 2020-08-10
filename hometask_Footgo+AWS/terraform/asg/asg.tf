
resource "aws_launch_configuration" "footgo_lc" {
  name_prefix                 = "FootGo_lc"
  image_id                    = var.aws_image_id 
#  associate_public_ip_address = true
  instance_type               = "t2.micro"
#  key_name                    = "Key_London"
  security_groups             = [var.aws_sg]
  ebs_block_device {
    device_name           = "/dev/xvdz"
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }
}

    
resource "aws_autoscaling_policy" "scaling_up" {
  name = "footgo_scaling_up"

  autoscaling_group_name = aws_autoscaling_group.footgo_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = "50"

  }
}


resource "aws_autoscaling_group" "footgo_asg" {
  name                      = "Footgo_asg"
  vpc_zone_identifier       = [var.aws_public_subnet]
  launch_configuration      = aws_launch_configuration.footgo_lc.name
  load_balancers            = [aws_elb.elb_footgo.name]
  min_size                  = 1
  max_size                  = 4
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  depends_on                = [var.rds_depends_on]

}

resource "aws_elb" "elb_footgo" {
  name = "footgo-terraform-elb"
  #availability_zones = ["eu-west-2a"
  subnets         = [var.aws_public_subnet]
  security_groups = [var.aws_sg]
  internal        = false

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}
