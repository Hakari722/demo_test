
KIỂM TRA THỰC HÀNH KẾT THÚC MÔN CSDL Đề 003
KIỂM TRA KẾT THÚC MÔN
NHẬP MÔN CSDL MYSQL - Đề 003
THỜI GIAN: 120 phút
*******************


Yêu cầu:
Tạo github repository theo cú pháp : [Tên lớp]_[Họ Tên]_[Mã đề]
Ví dụ: HN-K24-CNTT1_NguyenVanA_001
Sau khi hoàn thành, đẩy code lên github repo và nộp link cho người phụ trách
Công nghệ sử dụng: MYSQL
IDE : MYSQL Workbench
Thực hành bài trong script, lưu thành file tên final.sql trong repository đã tạo ở trên.
Lưu ý tuyệt đối không sử dụng Chat-GPT hay AI để làm bài, không copy bài người khác , nếu bị phát hiện sẽ lập biên bản và xử lý theo quy định.


Hệ thống Booking Phòng Khách Sạn
Quy định đặt tên: Sinh viên tự đặt tên bảng và tên cột bằng Tiếng Anh theo quy tắc.


PHẦN 1: THIẾT KẾ CSDL & CHÈN DỮ LIỆU (25 ĐIỂM)
1.1 Thiết kế bảng (10 điểm): Dựa vào mô tả nghiệp vụ dưới đây,hãy viết câu lệnh DDL để tạo CSDL với 5 bảng. Yêu cầu xác định đúng kiểu dữ liệu và thiết lập đầy đủ các ràng buộc.
Bảng 1: Guests

Tên cột
Mô tả nghiệp vụ
Gợi ý ràng buộc
guest_id
Mã khách lưu trú
Khóa chính
full_name
Tên khách hàng
Không được để trống
email
Email khách hàng
Không được để trống, duy nhất
phone
Số điện thoại
Không được để trống, duy nhất
loyalty_points
Điểm tích lũy
Không được âm, mặc định là 0, phải lớn hơn hoặc bằng 0


Bảng 2: Guest_Profiles

Tên cột
Mô tả nghiệp vụ
Gợi ý ràng buộc
profile_id
Mã hồ sơ
Khóa chính
guest_id
Mã khách hàng
Khóa ngoại (Guests)
address
Địa chỉ khách hàng
Không được để trống
birthday
Ngày tháng năm sinh
Không được để trống
national_id
Số căn cước
Không được để trống, duy nhất


Bảng 3: Rooms

Tên cột
Mô tả nghiệp vụ
Gợi ý ràng buộc
room_id
Mã phòng
Khóa chính
room_name
Tên phòng
Không được để trống
room_type
Loại phòng
Standard, Deluxe, Suite
price_per_night
Giá phòng 1 đêm
Không được để trống, phải lớn hơn 0
room_status
Trạng thái phòng
Available, Occupied, Maintenance


Bảng 4: Bookings

Tên cột
Mô tả nghiệp vụ
Gợi ý ràng buộc
booking_id
Mã đặt phòng
Khóa chính
guest_id
Mã khách hàng
Khóa ngoại (Guests)
check_in_date
Ngày giờ nhận phòng
Không được để trống
check_out_date
Ngày giờ trả phòng
Không được để trống, phải lớn hơn ngày giờ nhận phòng
total_charge
Tổng chi phí
Không được để trống, phải lớn hơn 0
booking_status
Trạng thái phòng
Pending, Completed, Cancelled
room_id
Mã phòng
Khóa ngoại (Rooms)


Bảng 5: Room_Log

Tên cột
Mô tả nghiệp vụ
Gợi ý ràng buộc
log_id
Mã nhật ký biến động phòng
Khóa chính
room_id
Mã phòng
Khóa ngoại (Rooms)
action_type
Loại hành động
Check-in, Check-out, Maintenance, Cancelled
change_note
Lý do thay đổi
Không được để trống
logged_at
Thời điểm ghi nhận
Mặc định thời gian hiện tại


1.2 DML (15 điểm): 
Viết Script chèn dữ liệu:

1. Bảng Khách lưu trú (Guests)
guest_id
full_name
email (duy nhất)
phone
loyalty_points
1
Nguyen Van A
anv@gmail.com
901234567
150
2
Tran Thi B
btt@gmail.com
912345678
500
3
Le Van C
cle@yahoo.com
922334455
0
4
Pham Minh D
dpham@hotmail.com
933445566
1000
5
Hoang Anh E
ehoang@gmail.com
944556677
20

2. Bảng Hồ sơ chi tiết khách (Guest_Profiles)
profile_id
guest_id
address
birthday
national_id
101
1
123 Le Loi, Q1, HCM
1990/5/15
12345
102
2
456 Nguyen Hue, Q1, HCM
1985/10/20
23456
103
3
789 Phan Chu Trinh, Da Nang
1995/12/1
34567
104
4
101 Hoang Hoa Tham, Ha Noi
1988/3/25
45678
105
5
202 Tran Hung Dao, Can Tho
2000/7/10
56789

3. Bảng Phòng khách sạn (Rooms)
room_id
room_name
room_type
price_per_night
room_status
1
Room 101
'Standard'
100000
Available
2
Room 202
'Deluxe'
5000000
Occupied
3
Room 303
'Suite'
300000
Available
4
Room 104
'Standard'
200000
Occupied
5
Room 205
'Deluxe'
2000000
Maintenance

4. Bảng Giao dịch đặt phòng (Bookings)
booking_id
guest_id
check_in_date
check_out_date
total_charge
booking_status
room_id
1001
1
2023/11/1 5 10:30
2023 /11/18 12:00
300000
Completed
1
1002
2
2023/12/1    14:20
2023/12/4 12:00
20000000
Completed
2
1003
1
2021/1/10  9:15
2021/1/11 12:00
5000000
Pending
2
1004
3
2023/5/20  16:45
2023/5/22 12:00
900000
Cancelled
3
1005
4
2024/1/18 11:00
2024/1/20 12:00
8000000
Completed
4

5. Bảng Nhật ký biến động phòng (Room_Log)
log_id
room_id
action_type
change_note
logged_at
1
1
Check-in
Guest checked in
2023/10/1 8:00
2
1
Check-out
Guest checked out
2023/11/15 10:35
3
4
Maintenance
Room reported as damaged
2023/11/20 15:00
4
2
Check-in
New guest arrival
2023/11/25 9:00
5
3
Maintenance
Schedule maintenance
2023/12/1 13:00

Viết script INSERT dữ liệu theo bảng dữ liệu mẫu
Viết câu lệnh UPDATE cộng 200 điểm tích lũy cho các khách hàng có email là đuôi '@gmail.com'
Viết câu lệnh DELETE xóa các bản ghi trong Room_Log có logged_at trước ngày 10/11/2023.

PHẦN 2: TRUY VẤN DỮ LIỆU CƠ BẢN (15 ĐIỂM)
Câu 1 (5đ): Lấy danh sách phòng (room_name, price_per_night, room_status) có giá thuê > 1.000.000 hoặc room_status = 'Maintenance' hoặc room_type = 'Suite'.
Câu 2 (5đ): Lấy thông tin khách (full_name, email) có email thuộc domain '@gmail.com' và loyalty_points nằm trong khoảng từ 50 đến 300.
Câu 3 (5đ): Hiển thị 3 booking có total_charge cao nhất, sắp xếp giảm dần, và bỏ qua booking cao nhất (chỉ lấy từ booking thứ 2 → thứ 4). Yêu cầu dùng LIMIT + OFFSET

PHẦN 3: TRUY VẤN DỮ LIỆU NÂNG CAO (20 ĐIỂM)
Mục tiêu: Kiểm tra tư duy liên kết bảng và thống kê dữ liệu.
Câu 1 (6đ): Viết câu lệnh truy vấn lấy ra các thông tin lịch đặt phòng gồm :
full_name
national_id
booking_id
check_in_date
total_charge
Câu 2 (7đ): Tính tổng số tiền thanh toán của mỗi khách. Chỉ hiển thị các khách có tổng chi tiêu của booking đã hoàn thành > 20.000.000 VNĐ.
Câu 3 (7đ): Tìm thông tin phòng có price_per_night cao nhất trong danh sách các phòng đã từng xuất hiện trong booking thành công.

PHẦN 4: INDEX VÀ VIEW (10 ĐIỂM)
Mục tiêu: Kiểm tra khả năng tối ưu hóa và đóng gói truy vấn.
Câu 1 (5đ): Tạo Composite Index tên idx_booking_status_cgh trên bảng Bookings gồm 2 cột:
booking_status
check_in_date
Câu 2 (5đ): Tạo View vw_guest_booking_stats hiển thị:
Guest Name
Tổng số booking đã đặt
Tổng số tiền đã thanh toán (chỉ lấy booking không bị hủy)

PHẦN 5: TRIGGER (10 ĐIỂM)
Mục tiêu: Kiểm tra kỹ năng xử lý sự kiện tự động.
Câu 1 (5đ): Tạo trigger trg_after_update_booking_status. Khi một booking chuyển trạng thái sang 'Completed', tự động ghi vào Room_Log:
action_type = 'Check-out'
change_note = 'Booking Completed'
room_id lấy từ booking liên quan
logged_at = NOW()
Câu 2 (5đ): Tạo trigger trg_update_loyalty_points trên bảng Bookings. Khi thêm booking mới với trạng thái 'Completed', tự động cộng loyalty_points cho khách:
Cứ mỗi 1.000.000 VNĐ → cộng 2 điểm.

PHẦN 6: STORED PROCEDURE (15 ĐIỂM)
Mục tiêu: Kiểm tra tư duy lập trình và quản lý giao dịch.
Câu 1 (7đ): Viết Procedure sp_get_room_status nhận vào room_id. Trả về message:
'Phòng trống' nếu room_status = 'Available'
'Đang có khách' nếu room_status = 'Occupied'
'Bảo trì' nếu room_status = 'Maintenance'
Câu 2 (8đ): Viết Procedure sp_cancel_booking xử lý hủy đặt phòng an toàn:
B1: Bắt đầu giao dịch.
B2: Cập nhật booking_status → 'Cancelled'
B3: Cập nhật trạng thái phòng tương ứng về 'Available'
B4: Ghi nhật ký Room_Log với action_type = 'Cancelled'
B5: COMMIT nếu thành công, ROLLBACK nếu xảy ra lỗi

Bonus điểm : 
Cộng tối đa 5 điểm nếu:
code trình bày đẹp
comment đầy đủ
đặt tên chuẩn
format SQL rõ ràng
code chạy đúng hoàn toàn
Lưu ý: Chỉ tính điểm khi thực hiện đúng theo yêu cầu

CREATE DATABASE  Booking_holtel;
USE Booking_holtel;

-- PHẦN 1: THIẾT KẾ CSDL & CHÈN DỮ LIỆU

CREATE TABLE Guests(
	guest_id INT PRIMARY KEY AUTO_INCREMENT, -- mã khách lưu trú
    full_name VARCHAR(50) NOT NULL,  -- Tên khách hàng
    email	VARCHAR(100) NOT NULl UNIQUE, -- Email khách hàng
    phone	VARCHAR(20) NOT NULL UNIQUE, -- Số điện thoại
    loyalty_points DECIMAL(10) DEFAULT 0 CHECK (loyalty_points >= 0) -- Điểm tích lũy
);

CREATE TABLE Guest_Profiles(
	profile_id VARCHAR(5) PRIMARY KEY, -- Mã hồ sơ
	guest_id INT AUTO_INCREMENT,	 -- Mã khách hàng
	address VARCHAR(100) NOT NULL,  	-- Địa chỉ khách hàng
	birthday DATE NOT NULL,				-- Ngày tháng năm sinh
	national_id VARCHAR(20) NOT NULL UNIQUE, -- Số căn cước
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id)
);

CREATE TABLE Rooms(
	room_id INT PRIMARY KEY AUTO_INCREMENT, -- Mã phòng
    room_name VARCHAR(100) NOT NULL,	-- Tên phòng
    room_type	ENUM ('Standard', 'Deluxe', 'Suite'), -- Loại phòng
    price_per_night DECIMAL (10,2) NOT NULL CHECK (price_per_night > 0), -- Giá phòng 1 đêm
    room_status ENUM ('Available', 'Occupied', 'Maintenance') -- Trạng thái phòng
);

CREATE TABLE Bookings(
	booking_id VARCHAR(5) PRIMARY KEY, -- Mã đặt phòng
    guest_id INT AUTO_INCREMENT, -- Mã khách hàng
    check_in_date	DATETIME NOT NULL, -- Ngày giờ nhận phòng
    check_out_date DATETIME NOT NULL CHECK(check_out_date > check_in_date), -- Ngày giờ trả phòng
    total_charge DECIMAL(10,2) NOT NULL CHECK (total_charge > 0), -- Tổng chi phí
    booking_status ENUM ('Pending', 'Completed', 'Cancelled'), -- Trạng thái phòng
    room_id INT AUTO_INCREMENT, -- Mã phòng
    FOREIGN KEY (room_id) REFERENCES  Rooms(room_id),
    FOREIGN KEY (guest_id) REFERENCES  Guests(guest_id)
);

CREATE TABLE  Room_Log(
	log_id INT PRIMARY KEY AUTO_INCREMENT, -- Mã nhật ký biến động phòng
    room_id	INT PRIMARY KEY AUTO_INCREMENT, -- Mã phòng
    action_type ENUM ('Check-in', 'Check-out', 'Maintenance', 'Cancelled'), -- Loại hành động
    change_note VARCHAR(100) NOT NULL, -- Lý do thay đổi
    logged_at datetime , -- Thời điểm ghi nhận
    FOREIGN KEY (room_id)  REFERENCES Rooms(room_id)
);

INSERT INTO Guests(guest_id, full_name, email, phone, loyalty_points)
VALUES
	(1, 'Nguyen Van A', 'anv@gmail.com', '901234567', '150'),
    (2, 'Tran Thi B', 'btt@gmail.com', '912345678', '500'),
    (3, 'Le Van C', 'cle@yahoo.com', '922334455', '0'),
    (4, 'Pham Minh D', 'dpham@hotmail.com', '933445566', '1000'),
    (5, 'Hoang Anh E', 'ehoang@gmail.com', '944556677', '20');
    
INSERT INTO  Guest_Profiles(profile_id, guest_id, address, birthday, national_id)
VALUES 
	(101, 1, '123 Le Loi, Q1, HCM', '1990/5/15', 12345),
    (102, 2, '456 Nguyen Hue, Q1, HCM', '1985/10/20', 23456),
    (103, 3, '789 Phan Chu Trinh, Da Nang', '1995/12/1', 34567),
    (104, 4, '101 Hoang Hoa Tham, Ha Noi', '1988/3/25', 45678),
    (105, 5, '202 Tran Hung Dao, Can Tho', '2000/7/10', 56789);
    
INSERT INTO Rooms(room_id, room_name, room_type, price_per_night, room_status)
VALUES 
	(1, 'Room 101', 'Standard', 100000, 'Available'),
    (2, 'Room 202', 'Deluxe', 5000000, 'Occupied'),
    (3, 'Room 303', 'Suite', 300000, 'Available'),
    (4, 'Room 104', 'Standard', 200000, 'Occupied'),
    (5, 'Room 205', 'Deluxe', 2000000, 'Maintenance');
    
INSERT INTO Bookings (booking_id, guest_id, check_in_date, check_out_date, total_charge, booking_status, room_id)
VALUES 
	(1001, 1, '2023/11/1 5 10:30', '2023 /11/18 12:00', 300000, 'Completed', 1),
    (1002, 2, '2023/12/1 14:20', '2023/12/4 12:00', 20000000, 'Completed', 2),
    (1003, 1, '2021/1/10  9:15', '2021/1/11 12:00', 5000000, 'Pending', 2),
    (1004, 3, '2023/5/20  16:45', '2023/5/22 12:00', 900000, 'Cancelled', 3),
    (1005, 4, '2024/1/18 11:00', '2024/1/20 12:00', 8000000, 'Completed', 4);
    
INSERT INTO Room_Log (log_id, room_id, action_type, change_note, logged_at)
VALUES 
(1, 1, 'Check-in','Guest checked in', '2023/10/1 8:00'),
(2, 1, 'Check-out','Guest checked out', '2023/11/15 10:35'),
(3, 4, 'Maintenance','Room reported as damaged', '2023/11/20 15:00'),
(4, 2, 'Check-in','New guest arrival', '2023/11/25 9:00'),
(5, 3, 'Maintenance','Schedule maintenance', '2023/12/1 13:00');

UPDATE Guests
SET loyalty_points = loyalty_points + 200
WHERE email LIKE '%@gmail.com';

DELETE 
FROM Room_Log 
WHERE logged_at < '10/11/2023';

-- PHẦN 2: TRUY VẤN DỮ LIỆU CƠ BẢN
-- câu 1:
SELECT 
	room_name, 
    price_per_night, 
    room_status
FROM Rooms
WHERE price_per_night > 1000000 OR room_status = 'Maintenance'  OR room_type = 'Suite';

-- câu 2:
SELECT 
	full_name, 
    email
FROM Guests
WHERE  email LIKE '%@gmail.com' AND loyalty_points BETWEEN 50 AND 300;

-- câu 3: 
SELECT 
	booking_id, 
    guest_id, 
    check_in_date, 
    check_out_date, 
    total_charge, 
    booking_status, 
    room_id
FROM Bookings
ORDER BY total_charge DESC
LIMIT 3 OFFSET 1;

-- PHẦN 3: TRUY VẤN DỮ LIỆU NÂNG CAO

-- câu 1:

SELECT 
	g.full_name,
	gp.national_id,
	b.booking_id,
	b.check_in_date,
	b.total_charge
FROM Guests g
INNER JOIN Guest_Profiles gp
ON g.guest_id = gp.guest_id
INNER JOIN Bookings b
ON g.guest_id = b.guest_id;

-- câu 2
SELECT
	g.full_name,
	SUM(b.total_charge)
FROM Guests g
INNER JOIN Bookings b
GROUP BY g.full_name, g.guest_id
HAVING b.total_charge > 20000000;

-- PHẦN 4: INDEX VÀ VIEW

CREATE INDEX  idx_booking_status_cgh ON
INSERT INTO (booking_status,check_in_date);

CREATE VIEW vw_guest_booking_stats AS
INSERT INTO

-- PHẦN 5: TRIGGER 

-- câu 1:
DELIMITER //

CREATE TRIGGER trg_after_update_booking_status 
AFTER UPDATE ON booking_status
FOR EACH ROW 

BEGIN
	
END //
	



