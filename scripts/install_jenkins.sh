#!/bin/bash

LOG_FILE="/var/log/install_jenkins.log"

# Criar o arquivo de log e definir permissões
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE

# Atualizar o sistema
#echo "Atualizando o sistema..." | tee -a $LOG_FILE
sudo yum update -y | tee -a $LOG_FILE

# Adicionar repositório e chave do Jenkins
#echo "Adicionando repositório e chave do Jenkins..." | tee -a $LOG_FILE
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo | tee -a $LOG_FILE
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key | tee -a $LOG_FILE

# Atualizar novamente o yum
#echo "Atualizando o yum novamente..." | tee -a $LOG_FILE
sudo yum upgrade -y | tee -a $LOG_FILE

# Instalar Java (Amazon Linux 2023)
#echo "Instalando Java..." | tee -a $LOG_FILE
sudo dnf install -y java-17-amazon-corretto | tee -a $LOG_FILE

# Alocar espaço para swap e ajustar /tmp
#echo "Alocando espaço para swap e ajustando /tmp..." | tee -a $LOG_FILE
sudo fallocate -l 1G /swapfile_extend_1GB | tee -a $LOG_FILE
sudo mount -o remount,size=5G /tmp/ | tee -a $LOG_FILE

# Instalar Jenkins
#echo "Instalando Jenkins..." | tee -a $LOG_FILE
sudo yum install -y jenkins | tee -a $LOG_FILE

# Alterar a porta do Jenkins no arquivo de serviço systemd
#echo "Alterando a porta do Jenkins no arquivo de serviço systemd..." | tee -a $LOG_FILE
sudo sed -i 's/Environment="JENKINS_PORT=8080"/Environment="JENKINS_PORT=80"/g' /usr/lib/systemd/system/jenkins.service | tee -a $LOG_FILE
#echo "Descomentando a linha AmbientCapabilities=CAP_NET_BIND_SERVICE..." | tee -a $LOG_FILE
sudo sed -i 's/#AmbientCapabilities=CAP_NET_BIND_SERVICE/AmbientCapabilities=CAP_NET_BIND_SERVICE/g' /usr/lib/systemd/system/jenkins.service | tee -a $LOG_FILE
#echo "Recarregando o daemon do systemd para aplicar as mudanças..." | tee -a $LOG_FILE
sudo systemctl daemon-reload | tee -a $LOG_FILE

# Habilitar e iniciar o Jenkins
#echo "Habilitando e iniciando Jenkins..." | tee -a $LOG_FILE
sudo systemctl enable jenkins | tee -a $LOG_FILE
sudo systemctl start jenkins | tee -a $LOG_FILE
sudo systemctl status jenkins | tee -a $LOG_FILE

# Instalar Docker
#echo "Instalando Docker..." | tee -a $LOG_FILE
sudo yum install -y docker | tee -a $LOG_FILE
#echo "Iniciando e habilitando Docker..." | tee -a $LOG_FILE
sudo systemctl start docker | tee -a $LOG_FILE
sudo systemctl enable docker | tee -a $LOG_FILE
sudo systemctl status docker | tee -a $LOG_FILE
sudo usermod -aG docker ec2-user | tee -a $LOG_FILE

# Reiniciar Jenkins
#echo "Reiniciando Jenkins..." | tee -a $LOG_FILE
sudo systemctl restart jenkins | tee -a $LOG_FILE
sudo systemctl status jenkins | tee -a $LOG_FILE

# Instalar Node.js e npm
#echo "Instalando Node.js e npm..." | tee -a $LOG_FILE
sudo yum install -y nodejs npm | tee -a $LOG_FILE

# Instalar Git
#echo "Instalando Git..." | tee -a $LOG_FILE
sudo yum install -y git | tee -a $LOG_FILE

# Baixar e instalar Google Chrome
#echo "Baixando Google Chrome..." | tee -a $LOG_FILE
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm | tee -a $LOG_FILE
#echo "Instalando Google Chrome..." | tee -a $LOG_FILE
sudo yum -y localinstall google-chrome-stable_current_x86_64.rpm | tee -a $LOG_FILE

# Baixar e instalar ChromeDriver
#echo "Baixando ChromeDriver..." | tee -a $LOG_FILE
wget https://chromedriver.storage.googleapis.com/$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip | tee -a $LOG_FILE
#echo "Extraindo ChromeDriver..." | tee -a $LOG_FILE
unzip chromedriver_linux64.zip | tee -a $LOG_FILE
#echo "Movendo ChromeDriver..." | tee -a $LOG_FILE
sudo mv chromedriver /usr/bin/ | tee -a $LOG_FILE
sudo chmod +x /usr/bin/chromedriver | tee -a $LOG_FILE

# Instalar Selenium WebDriver
#echo "Instalando Selenium WebDriver..." | tee -a $LOG_FILE
sudo npm install -g selenium-webdriver | tee -a $LOG_FILE

# Instalar ChromeDriver via npm
#echo "Instalando ChromeDriver via npm..." | tee -a $LOG_FILE
sudo npm install -g chromedriver | tee -a $LOG_FILE

# Reiniciar Jenkins
#echo "Reiniciando Jenkins..." | tee -a $LOG_FILE
sudo systemctl restart jenkins | tee -a $LOG_FILE
sudo systemctl status jenkins | tee -a $LOG_FILE

# Ajustar permissões de volta ao estado seguro
sudo chmod 644 $LOG_FILE

