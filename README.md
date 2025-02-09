---

# VNC Server Docker Container

This is a Docker container that provides a **headless VNC server** with an **Xfce desktop environment**, **Firefox**, and **SFTP** access. It is designed to allow users to remotely access a graphical desktop through VNC or SSH, and it is fully customizable.

---

## 🚀 Features

- **Headless VNC server**: Access your remote desktop over VNC.
- **Xfce Desktop Environment**: Lightweight and customizable UI.
- **Browsers**: Includes **Firefox** for browsing.
- **SSH**: Secure SSH access for terminal-based management.
- **SFTP**: Easily transfer files to/from the container.

---

🛠️ Development
This project is based on and inspired by the work done in the ConSol Docker Headless VNC Container repository. I have customized and extended the features to include more up-to-date browsers, additional tools, and other performance improvements.

## 📦 Ready-to-use Docker Image

You can find the pre-built Docker image for this container on [Docker Hub](https://hub.docker.com/r/kzltp/vncserver).

Simply pull the image and run the container using the following command:

```bash
docker pull kzltp/vncserver
```

---

## 📥 How to Use

1. **Run Docker Container**:
   You can use Docker Compose to start the container easily. Here's a sample `docker-compose.yml` file:

   ```yaml
   version: '3'
   services:
     vncserver:
       container_name: vncserver
       image: kzltp/vncserver:12
       networks:
         - guacamole_network
       ports:
         - 5901:5901
         - 2222:22
   networks:
     guacamole_network:
       name: sandbox
       driver: bridge
   ```

   To start the container, run:

   ```bash
   docker-compose up -d
   ```

2. **Access the VNC**:
   - **VNC Username**: `root`
   - **VNC Password**: `vncpassword`
   - **Port**: `5902`

3. **Access SSH**:
   - **SSH Username**: `root`
   - **SSH Password**: `rootpassword`
   - **Port**: `22`

4. **Access the container** via a VNC client (e.g., **VNC Viewer** or **TigerVNC**) and SSH client (e.g., **PuTTY** or **Terminal**).

---

## 📝 Configuration

You can customize the configuration to suit your needs by modifying the **Dockerfile** or by providing your own **VNC password** or **SSH credentials**.

---

## 🌐 Blog and More Information

For more details on how this container works and other related articles, check out my personal blog at:  
[https://arifkiziltepe.medium.com/](https://arifkiziltepe.medium.com/)

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📞 Contact

Feel free to open an issue or contribute to the project. Your feedback is always appreciated!
