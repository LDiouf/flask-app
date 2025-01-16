provider "null" {}

resource "null_resource" "install_minikube" {
  provisioner "local-exec" {
    command = <<EOT
      sudo apt update
      sudo apt install -y minikube
      minikube start
    EOT
  }
}

resource "null_resource" "install_jenkins" {
  provisioner "local-exec" {
    command = <<EOT
      sudo apt update
      sudo apt install -y jenkins
      sudo systemctl enable --now jenkins
    EOT
  }
}
