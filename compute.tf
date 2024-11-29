resource "aws_instance" "testing_env" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Testing_Env"
  }

  root_block_device {
    volume_size = 30
  }
  
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
  }

  provisioner "local-exec" {
    command = "chmod +x ./getkey.sh && ./getkey.sh testingkey.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo chown -R ec2-user:ec2-user /var/www/html/",
      "wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm",
      "sudo yum localinstall google-chrome-stable_current_x86_64.rpm -y",
      "wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip",
      "unzip chromedriver_linux64.zip",
      "sudo mv chromedriver /usr/local/bin/",
      "sudo chmod +x /usr/local/bin/chromedriver"
    ]
  }
}

resource "aws_instance" "staging_env" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Staging_Env"
  }

  root_block_device {
    volume_size = 30
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
  }

  provisioner "local-exec" {
    command = "chmod +x ./getkey.sh && ./getkey.sh stagingkey.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo chown -R ec2-user:ec2-user /var/www/html/",
      "wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm",
      "sudo yum localinstall google-chrome-stable_current_x86_64.rpm -y",
      "wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip",
      "unzip chromedriver_linux64.zip",
      "sudo mv chromedriver /usr/local/bin/",
      "sudo chmod +x /usr/local/bin/chromedriver"
    ]
  }
}

resource "aws_instance" "production_env1" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Production_Env1"
  }

  root_block_device {
    volume_size = 30
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
  }

  provisioner "local-exec" {
    command = "chmod +x ./getkey.sh && ./getkey.sh production1key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo chown -R ec2-user:ec2-user /var/www/html/",
      "wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm",
      "sudo yum localinstall google-chrome-stable_current_x86_64.rpm -y",
      "wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip",
      "unzip chromedriver_linux64.zip",
      "sudo mv chromedriver /usr/local/bin/",
      "sudo chmod +x /usr/local/bin/chromedriver"
    ]
  }
}

resource "aws_instance" "production_env2" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Production_Env2"
  }

  root_block_device {
    volume_size = 30
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
  }

  provisioner "local-exec" {
    command = "chmod +x ./getkey.sh && ./getkey.sh production2key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo chown -R ec2-user:ec2-user /var/www/html/",
      "wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm",
      "sudo yum localinstall google-chrome-stable_current_x86_64.rpm -y",
      "wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip",
      "unzip chromedriver_linux64.zip",
      "sudo mv chromedriver /usr/local/bin/",
      "sudo chmod +x /usr/local/bin/chromedriver"
    ]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-063d43db0594b521b"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Jenkins_Controller"
  }

  root_block_device {
    volume_size = 30
  }
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "chmod +x ./getkey.sh && ./getkey.sh jenkinskey.pem"
  }

  provisioner "file" {
    source      = "scripts/install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
  }

  provisioner "file" {
    source      = "testingkey.pem"
    destination = "/tmp/testingkey.pem"
  }

  provisioner "file" {
    source      = "stagingkey.pem"
    destination = "/tmp/stagingkey.pem"
  }

  provisioner "file" {
    source      = "production1key.pem"
    destination = "/tmp/production1key.pem"
  }

  provisioner "file" {
    source      = "production2key.pem"
    destination = "/tmp/production2key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_jenkins.sh",
      "/tmp/install_jenkins.sh",
      "sudo mkdir -p /var/lib/jenkins/keys",
      "sudo chown -R jenkins:jenkins /var/lib/jenkins/keys",
      "sudo mv /tmp/testingkey.pem /var/lib/jenkins/keys/testingkey.pem",
      "sudo mv /tmp/stagingkey.pem /var/lib/jenkins/keys/stagingkey.pem",
      "sudo mv /tmp/production1key.pem /var/lib/jenkins/keys/production1key.pem",
      "sudo mv /tmp/production2key.pem /var/lib/jenkins/keys/production2key.pem",
      "sudo chown jenkins:jenkins /var/lib/jenkins/keys/*.pem",
      "sudo chmod 600 /var/lib/jenkins/keys/*.pem"
    ]
  }
}

