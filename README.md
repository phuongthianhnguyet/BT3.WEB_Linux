# BT3.LẬP TRÌNH ỨNG DỤNG TRÊN NỀN WEB
## Giảng viên: Đỗ Duy Cốp
## Sinh viên: Phương Thị Ánh Nguyệt
## Mssv: K225480106098

## YÊU CẦU : Lập trình ứng dụng web trên nền linux
1. Cài đặt môi trường linux: chọn 1 trong các phương án

2. Cài đặt Docker (nếu dùng docker desktop trên windows thì nó có ngay)

3. Sử dụng 1 file docker-compose.yml để cài đặt các docker container sau: 
mariadb (3306), phpmyadmin (8080), nodered/node-red (1880), influxdb (8086), grafana/grafana (3000), nginx (80,443)

4. Lập trình web frontend+backend:

4.1 Web thương mại điện tử

4.2 Web IOT: Giám sát dữ liệu IOT.

5. Nginx làm web-server
   
# BÀI LÀM.
## *Em chọn làm Web thương mại điện tử.*
## 1. Cài đặt môi trường linux.

### enable wsl: cài đặt docker desktop
#### Bước 1: Bật WSL và Virtual Machine Platform
#### Mở powershell với quyền Administrator. Chạy lần lượt các lệnh:

`dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`

`dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`

<img width="1920" height="1080" alt="Ảnh chụp màn hình (2)" src="https://github.com/user-attachments/assets/f4a9c971-e3cd-4c9e-9dcf-623bb28962b1" />

#### Đặt WSL default verersion = 2

- Chạy lệnh trong powershell Administrator: `wsl --set-default-version 2`

<img width="965" height="640" alt="Ảnh chụp màn hình 2025-11-05 175544" src="https://github.com/user-attachments/assets/8b0391c7-1798-4237-86c9-2c046b5b49df" />

#### Bước 2: Cài Ubuntu bằng Powershell (hoặc tải từ Microsoft Store)

Truy cập link: `Ubuntu 22.04.5 LTS – Microsoft Store` để tải ubuntu.

- Sau khi tải ubuntu về máy, tiến hành cài đặt Ubuntu. Nó sẽ hiển thị ra cửa sổ yêu cầu người dùng đặt Usename và password cho Ubuntu cho các lần đăng nhập vào sau.

<img width="1066" height="606" alt="Ảnh chụp màn hình (3)(1)" src="https://github.com/user-attachments/assets/c1f1ef05-96b8-4cc3-a006-b1be69b84ba1" />

<img width="1110" height="640" alt="Ảnh chụp màn hình 2025-11-05 180358" src="https://github.com/user-attachments/assets/473c4636-3ef4-4336-982f-7c8f9c448ea9" />

## 2. Cài đặt docker 
#### Sau khi tải xong Docker ta tiến hành cài đặt lần lượt: `vào cài đặt -> Resources -> WSL integration -> Ubuntu-22.04 -> Apply &restart.

<img width="1167" height="902" alt="Ảnh chụp màn hình 2025-11-05 181350" src="https://github.com/user-attachments/assets/a84c3a95-205d-4433-abba-cb19808a4c29" />

#### Kiểm tra docker gõ lệnh Docker version:

<img width="963" height="783" alt="Ảnh chụp màn hình 2025-11-05 181557" src="https://github.com/user-attachments/assets/39df71a7-fcce-48e0-8a71-5bfd3c3e8b14" />

#### Chạy lệnh `Docker run --rm hello-world`, nếu thấy dòng `Hello from Docker!` là đã cài đặt thành công.

<img width="950" height="778" alt="Ảnh chụp màn hình 2025-11-05 181640" src="https://github.com/user-attachments/assets/07d034a9-a303-489f-b248-c10508838d51" />



