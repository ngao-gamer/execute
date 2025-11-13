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
        // Định nghĩa các Icon mặc định
        private static readonly Image ErrorIcon = SystemIcons.Error.ToBitmap();
        private static readonly Image WarningIcon = SystemIcons.Warning.ToBitmap();
        private static readonly Image InfoIcon = SystemIcons.Information.ToBitmap();
        private static readonly Image QuestionIcon = SystemIcons.Question.ToBitmap();

        // Phương thức gọi chính (Cơ sở)
        private static void Show(string message, string title, Image icon)
        {
            CustomNotificationForm notification = new CustomNotificationForm(message, title, icon);
            notification.ShowDialog();
        }

        // Phương thức Public cho người dùng gọi (Không Icon)
        public static void Show(string message, string title = "Thông báo Tùy chỉnh")
        {
            Show(message, title, null);
        }

        // Phương thức Public cho Icon Error
        public static void ShowError(string message, string title = "Lỗi Hệ Thống")
        {
            Show(message, title, ErrorIcon);
        }

        // Phương thức Public cho Icon Information
        public static void ShowInfo(string message, string title = "Thông Tin")
        {
            Show(message, title, InfoIcon);
        }

        // Các phương thức Icon khác (Warning, Question) có thể thêm tương tự...
    }

    // ==========================================================
    // 2. CUSTOM NOTIFICATION FORM (Code-behind đã sửa)
    // ==========================================================
    
    // Form này phải được thiết lập để kế thừa Guna2Form trong Designer
    public partial class CustomNotificationForm : Guna2Form
    {
        // Khai báo lại các biến cần thiết cho Designer nếu bạn gộp code
        // (Trong file .Designer.cs, chúng thường là private hoặc protected)
        
        // Bạn có thể giữ nguyên các khai báo này hoặc đảm bảo chúng được 
        // khai báo đúng trong .Designer.cs và là public/internal/protected
        // để có thể truy cập được.

        public CustomNotificationForm(string message, string title, Image icon = null)
        {
            InitializeComponent();
            
            // 1. Cấu hình Form (Giao diện Guna)
            this.FormBorderStyle = FormBorderStyle.None;
            this.ControlBox = false;
            this.Text = title; // Đặt tiêu đề (chỉ dùng cho hệ thống)
            this.StartPosition = FormStartPosition.CenterScreen;
            
            // ÁP DỤNG YÊU CẦU GIAO DIỆN:
            this.FillColor = Color.FromArgb(20, 20, 20); // Màu nền (20, 20, 20)
            this.BorderRadius = 8; // Góc bo tròn (8)
            
            // 2. Cấu hình Control
            label2.Text = title; // Hiển thị tiêu đề bên trong Form
            label2.ForeColor = Color.White;
            
            label1.Text = message; // Nội dung thông báo
            label1.ForeColor = Color.White; 
            label1.BackColor = Color.FromArgb(20, 20, 20); // Đồng bộ màu nền
            
            guna2Button1.Text = "OK";
            guna2Button1.Click += guna2Button1_Click;

            // 3. Xử lý Icon và Tự động xuống dòng
            if (icon != null)
            {
                picIcon.Image = icon;
                picIcon.Visible = true;
                // Nếu có Icon, điều chỉnh vị trí Label để Icon hiển thị.
                // Vị trí này cần được tinh chỉnh dựa trên bố cục Designer của bạn.
                label1.Left = picIcon.Right + 10; 
                label1.Width = this.Width - label1.Left - 20; 
            }
            else
            {
                picIcon.Visible = false;
                // Nếu không có Icon, di chuyển Label sang trái
                label1.Left = 20; 
                label1.Width = this.Width - 40; 
            }
            
            // Tính toán lại chiều cao Label để hỗ trợ tự động xuống dòng (Word Wrap)
            // (Bạn phải đặt label1.AutoSize = False trong Designer)
            label1.Height = TextRenderer.MeasureText(label1.Text, label1.Font, new Size(label1.Width, 0), TextFormatFlags.WordBreak).Height;
        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        
        // Các hàm Load hoặc event handler khác có thể được xóa nếu không cần
    }
}
