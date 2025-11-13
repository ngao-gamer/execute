using System;
using System.Drawing;
using System.Windows.Forms;
using Guna.UI2.WinForms; // Cần thiết cho Guna2Form và Guna2Button

namespace Purium
{
    // ==========================================================
    // 1. CLASS TĨNH: CUSTOM NOTIFIER (Phương thức gọi gọn gàng)
    // ==========================================================
    public static class CustomNotifier
    {
        // Phương thức gọi chính (Chỉ còn 1 constructor không có tham số Icon)
        private static void Show(string message, string title)
        {
            CustomNotificationForm notification = new CustomNotificationForm(message, title);
            notification.ShowDialog();
        }

        // Phương thức Public cho người dùng gọi
        public static void Show(string message, string title = "Thông báo Tùy chỉnh")
        {
            Show(message, title);
        }
        
        // **LƯU Ý: Đã loại bỏ ShowError, ShowInfo và logic Icon khỏi đây**
    }

    // ==========================================================
    // 2. FORM THÔNG BÁO: CustomNotificationForm (Code-behind đã sửa)
    // ==========================================================
    
    // Form này phải được thiết lập để kế thừa Guna.UI2.WinForms.Guna2Form
    public partial class CustomNotificationForm : Guna2Form
    {
        // Giả định bạn có: label1 (Nội dung), label2 (Tiêu đề), guna2Button1 (Nút OK)

        // Constructor chỉ nhận message và title (Không có tham số Icon)
        public CustomNotificationForm(string message, string title)
        {
            // VỊ TRÍ CHÍNH XÁC: Luôn là lệnh đầu tiên trong constructor!
            InitializeComponent(); 
            
            // Kích thước cố định (bạn phải thiết lập Form ở 273x160 trong Designer)
            const int FormWidth = 273;
            const int SidePadding = 20; // Lề 20px mỗi bên

            // 1. Cấu hình Form (Giao diện Guna)
            this.Width = FormWidth;
            this.Height = 160;
            this.FormBorderStyle = FormBorderStyle.None;
            this.ControlBox = false;
            this.Text = title;
            this.StartPosition = FormStartPosition.CenterScreen;
            
            // ÁP DỤNG GIAO DIỆN:
            this.FillColor = Color.FromArgb(20, 20, 20); // Màu nền (20, 20, 20)
            this.BorderRadius = 8; // Góc bo tròn (8)
            
            // 2. Cấu hình Tiêu đề và Nút
            label2.Text = title; // Tiêu đề bên trong Form
            label2.ForeColor = Color.White;
            
            guna2Button1.Text = "OK";
            guna2Button1.Click += guna2Button1_Click;

            // 3. Xử lý Nội dung (Tự động xuống dòng)
            
            // Đặt vị trí và chiều rộng của Label để text không bị ngắt quá sớm
            label1.Left = SidePadding; // Bắt đầu từ lề 20px
            
            // Chiều rộng = Tổng chiều rộng Form (273) - Lề trái (20) - Lề phải (20)
            label1.Width = FormWidth - (SidePadding * 2); // 273 - 40 = 233px
            
            label1.Text = message; // Nội dung thông báo
            label1.ForeColor = Color.White; 
            label1.BackColor = Color.FromArgb(20, 20, 20);
            
            // Tính toán lại chiều cao Label để xuống dòng (Yêu cầu label1.AutoSize = False)
            label1.Height = TextRenderer.MeasureText(
                label1.Text, 
                label1.Font, 
                new Size(label1.Width, 0), 
                TextFormatFlags.WordBreak // Cờ ngắt từ
            ).Height;
        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        
        private void CustomNotificationForm_Load(object sender, EventArgs e)
        {
            
        }
    }
}
