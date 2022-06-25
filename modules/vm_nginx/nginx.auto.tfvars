install_nginx_script = [
    "sleep 25",
    "sudo apt update",
    "sudo apt install nginx -y",
    "sudo ufw allow 'Nginx HTTP'"

]