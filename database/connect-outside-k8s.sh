enable_port_forward_service(){
    sudo cp port-forward.service /etc/systemd/system
    chmod 750 port-forward.sh
    sudo systemctl restart port-forward.service
    sudo systemctl enable port-forward.service
}

enable_port_forward_service