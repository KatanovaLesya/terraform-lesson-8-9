##############################################
# Shared Resources for RDS / Aurora Module
##############################################

resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge(var.tags, { Name = "${var.db_name}-subnet-group" })
}

resource "aws_security_group" "this" {
  name        = "${var.db_name}-sg"
  description = "Allow PostgreSQL/Aurora access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.db_name}-sg" })
}

# Параметр-група — залежить від типу бази
resource "aws_db_parameter_group" "this" {
  count  = var.use_aurora ? 0 : 1
  name   = "${var.db_name}-param-group"
  family = var.engine == "postgres" ? "postgres12" : "aurora-postgresql12"

  parameter {
    name         = "max_connections"
    value        = "200"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "log_statement"
    value        = "none"
    apply_method = "immediate"
  }

  parameter {
    name         = "work_mem"
    value        = "4096"
    apply_method = "pending-reboot"
  }

  tags = merge(var.tags, { Name = "${var.db_name}-param-group" })
}
