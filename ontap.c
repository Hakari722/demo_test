#include <stdio.h>

#define MAX_SIZE 50

int main() {
    // b1 Khoi tao cac bien, dai luong can thiet
    int stock[MAX_SIZE] = {10, 25, 30, 15, 40};
    int n = 5;
    int choice;
    int value;
    int pos;
    int found;

    // b2 Tao khung cho chuong trinh menu
    do {
        // b2.1 Hien thi menu
        printf("\n==============================================\n");
        printf("       CHUONG TRINH QUAN LY TON KHO MINIMART   ");
        printf("\n==============================================\n");
        printf("1. Them so luong ton kho\n");
        printf("2. Sua so luong ton kho\n");
        printf("3. Xoa so luong ton kho\n");
        printf("4. Tim kiem so luong ton kho\n");
        printf("0. Thoat chuong trinh\n");
        printf("==============================================\n");
        printf("Vui long nhap lua chon cua ban (0-4): ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                // --- CHỨC NĂNG THÊM / CHÈN ---
                if (n == MAX_SIZE) {
                    printf("Mang da day, khong the them phan tu!\n");
                    break;
                }
                printf("Moi ban nhap vao gia tri ton kho can them: ");
                scanf("%d", &value);
                if (value < 0) {
                    printf("So luong ton kho khong hop le!\n");
                    break;
                }

                printf("Moi ban nhap vao vi tri muon chen (1 - %d): ", n + 1);
                scanf("%d", &pos);

                if (pos < 1 || pos > n + 1) {
                    printf("Vi tri chen khong hop le!\n");
                    break;
                }

                // Thực hiện chèn
                for (int i = n; i >= pos; i--) {
                    stock[i] = stock[i - 1];
                }
                stock[pos - 1] = value;
                n++;
                printf("Da chen thanh cong!\n");

                // IN HÀNG NGANG SAU KHI THÊM
                printf("Danh sach ton kho hien tai: ");
                for (int i = 0; i < n; i++) {
                    printf("%d ", stock[i]);
                }
                printf("\n");
                break;

            case 2:
                // --- CHỨC NĂNG SỬA ---
                if (n == 0) {
                    printf("Kho hang trong, khong co phan tu de sua!\n");
                    break;
                }
                printf("Nhap vi tri muon sua (1 - %d): ", n);
                scanf("%d", &pos);

                if (pos < 1 || pos > n) {
                    printf("Vi tri khong hop le!\n");
                    break;
                }

                printf("Gia tri hien tai tai vi tri %d la: %d\n", pos, stock[pos - 1]);
                printf("Nhap gia tri ton kho moi: ");
                scanf("%d", &value);

                if (value < 0) {
                    printf("So luong ton kho khong hop le!\n");
                    break;
                }

                stock[pos - 1] = value;
                printf("Cap nhat thanh cong!\n");

                // IN HÀNG NGANG SAU KHI SỬA
                printf("Danh sach ton kho hien tai: ");
                for (int i = 0; i < n; i++) {
                    printf("%d ", stock[i]);
                }
                printf("\n");
                break;

            case 3:
                // --- CHỨC NĂNG XÓA ---
                if (n == 0) {
                    printf("Kho hang trong, khong co gi de xoa!\n");
                    break;
                }
                printf("Nhap vi tri muon xoa (1 - %d): ", n);
                scanf("%d", &pos);

                if (pos < 1 || pos > n) {
                    printf("Vi tri xoa khong hop le!\n");
                    break;
                }

                for (int i = pos - 1; i < n - 1; i++) {
                    stock[i] = stock[i + 1];
                }
                n--;
                printf("Da xoa thanh cong!\n");

                // IN HÀNG NGANG SAU KHI XÓA
                if (n == 0) {
                    printf("Kho hang hien tai dang trong!\n");
                } else {
                    printf("Danh sach ton kho hien tai: ");
                    for (int i = 0; i < n; i++) {
                        printf("%d ", stock[i]);
                    }
                    printf("\n");
                }
                break;

            case 4:
                // --- CHỨC NĂNG TÌM KIẾM ---
                if (n == 0) {
                    printf("Kho hang trong!\n");
                    break;
                }
                printf("Nhap gia tri ton kho can tim: ");
                scanf("%d", &value);

                found = 0;
                for (int i = 0; i < n; i++) {
                    if (stock[i] == value) {
                        printf("Tim thay gia tri %d tai vi tri %d (index %d)\n", value, i + 1, i);
                        found = 1;
                    }
                }

                if (!found) {
                    printf("Khong tim thay gia tri %d trong kho!\n", value);
                }
                break;

            case 0:
                printf("Cam on ban da su dung chuong trinh. Tam biet!\n");
                break;

            default:
                printf("Lua chon khong hop le! Vui long nhap tu 0 den 4.\n");
                break;
        }
    } while (choice != 0);

    return 0;
}