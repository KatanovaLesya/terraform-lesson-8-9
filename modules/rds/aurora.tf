resource "aws_rds_cluster" "this" {
  count                 = var.use_aurora ? 1 : 0
  cluster_identifier    = "${var.db_name}-cluster"
  engine                = "aurora-postgresql"
  engine_version        = var.engine_version
  master_username       = var.username
  master_password       = var.password
  database_name         = var.db_name
  db_subnet_group_name  = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  skip_final_snapshot   = true
  tags                  = var.tags
}

resource "aws_rds_cluster_instance" "writer" {
  count              = var.use_aurora ? 1 : 0
  identifier         = "${var.db_name}-writer"
  cluster_identifier = aws_rds_cluster.this[0].id
  instance_class     = var.instance_class
  engine             = "aurora-postgresql"
}
