# Tiêu Chuẩn Bảo Mật Nghiêm Ngặt cho Website Chạy trên Linux Server

## 1. Cập Nhật và Quản Lý Hệ Thống
- Cập nhật hệ điều hành và các phần mềm thường xuyên với các bản vá mới nhất.
- Sử dụng các công cụ quản lý gói như apt, yum, hoặc dnf để tự động kiểm tra và cập nhật.
- Áp dụng các cấu hình bảo mật mạnh mẽ cho kernel và các dịch vụ quan trọng.

## 2. Cấu Hình Tường Lửa (Firewall)
- Cài đặt và cấu hình tường lửa như iptables, nftables hoặc ufw để kiểm soát lưu lượng truy cập.
- Chỉ mở các cổng cần thiết cho website và dịch vụ liên quan.
- Bảo vệ server khỏi các tấn công từ chối dịch vụ (DoS) bằng cách hạn chế số lượng kết nối đồng thời.

## 3. Bảo Mật SSH
- Vô hiệu hóa đăng nhập root qua SSH.
- Sử dụng xác thực khóa công khai thay vì mật khẩu.
- Thay đổi cổng mặc định (22) và giới hạn IP được phép truy cập.
- Đặt timeout và giới hạn số lượng kết nối thất bại.

## 4. Quản Lý Người Dùng và Quyền Truy Cập
- Xác định quyền hạn tối thiểu cho người dùng (Principle of Least Privilege).
- Tạo các nhóm người dùng với chính sách truy cập cụ thể.
- Sử dụng sudo thay vì đăng nhập với quyền root trực tiếp.
- Định kỳ kiểm tra và loại bỏ các người dùng không cần thiết.

## 5. Cấu Hình Dịch Vụ Web
- Áp dụng HTTPS với chứng chỉ SSL/TLS từ các nhà cung cấp uy tín.
- Cấu hình các header bảo mật như Content-Security-Policy, X-Frame-Options, và X-XSS-Protection.
- Giới hạn kích thước upload và sử dụng WAF (Web Application Firewall) để ngăn chặn các tấn công từ ứng dụng web.

## 6. Bảo Vệ File Hệ Thống và Quyền Truy Cập
- Đảm bảo các thư mục và tệp cấu hình có quyền truy cập hạn chế.
- Sử dụng SELinux hoặc AppArmor để cung cấp lớp bảo vệ bổ sung.
- Kiểm tra và sẵn sàng khôi phục các quyền truy cập khi có dấu hiệu thay đổi bất thường.

## 7. Giám Sát và Phát Hiện Xâm Nhập
- Cài đặt và cấu hình hệ thống giám sát như Fail2Ban, OSSEC hoặc Tripwire để theo dõi các hoạt động đáng ngờ.
- Ghi lại nhật ký hệ thống và ứng dụng với rsyslog hoặc syslog-ng, và định kỳ phân tích các log này.
- Sử dụng các công cụ giám sát tài nguyên (như Nagios, Zabbix hoặc Prometheus) để theo dõi tải và hiệu năng hệ thống.

## 8. Sao Lưu và Phục Hồi
- Thiết lập quy trình sao lưu định kỳ cho dữ liệu và cấu hình hệ thống.
- Kiểm tra thủ tục phục hồi sau sự cố thường xuyên.
- Lưu trữ bản sao lưu ở vị trí an toàn, có thể tách biệt khỏi server chính.

## 9. Kiểm Tra và Xác Thực Bảo Mật
- Thực hiện kiểm thử thâm nhập (penetration testing) định kỳ để xác định và khắc phục các lỗ hổng.
- Đánh giá bảo mật thông qua các báo cáo đánh giá độc lập.
- Liên tục theo dõi các thông báo bảo mật từ nhà cung cấp và cộng đồng bảo mật.

## 10. Đào Tạo và Chính Sách Bảo Mật
- Đào tạo đội ngũ quản trị viên và người dùng về các quy tắc bảo mật và nhận diện các hoạt động đáng ngờ.
- Thiết lập chính sách bảo mật rõ ràng, bao gồm quy trình phòng ngừa, dự phòng và hồi phục.
