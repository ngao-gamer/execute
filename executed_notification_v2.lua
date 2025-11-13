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
        private static readonly Image InfoIcon = SystemIcons.Information.ToBitmap();

        // Phương thức gọi chính (Cơ sở)
        private static void Show(string message, string title, Image icon)
        {
            CustomNotificationForm notification = new CustomNotificationForm(message, title, icon);
            notification.ShowDialog();
        }

        // 1. Thông báo đơn giản (Không Icon)
        public static void Show(string message, string title = "Thông báo Tùy chỉnh")
        {
            Show(message, title, null);
        }

        // 2. Thông báo với Icon Error
        public static void ShowError(string message, string title = "Lỗi Hệ Thống")
        {
            Show(message, title, ErrorIcon);
        }

        // 3. Thông báo với Icon Information
        public static void ShowInfo(string message, string title = "Thông Tin")
        {
            Show(message, title, InfoIcon);
        }
    }

    // ==========================================================
    // 2. FORM THÔNG BÁO: CustomNotificationForm (Code-behind)
    // ==========================================================
    
    // Form này phải được thiết lập để kế thừa Guna.UI2.WinForms.Guna2Form
    public partial class CustomNotificationForm : Guna2Form
    {
        // Giả định bạn có: label1, label2, picIcon (PictureBox), guna2Button1
        
        public CustomNotificationForm(string message, string title, Image icon = null)
        {
            // VỊ TRÍ CHÍNH XÁC: Luôn là lệnh đầu tiên trong constructor!
            InitializeComponent(); 
            
            // 1. Cấu hình Form (Giao diện Guna)
            this.FormBorderStyle = FormBorderStyle.None;
            this.ControlBox = false;
            this.Text = title;
            this.StartPosition = FormStartPosition.CenterScreen;
            
            // ÁP DỤNG GIAO DIỆN:
            this.FillColor = Color.FromArgb(20, 20, 20); // Màu nền (20, 20, 20)
            this.BorderRadius = 8; // Góc bo tròn (8)
            
            // 2. Cấu hình Control
            label2.Text = title; // Tiêu đề bên trong Form
            label2.ForeColor = Color.White;
            
            label1.Text = message; // Nội dung thông báo
            label1.ForeColor = Color.White; 
            label1.BackColor = Color.FromArgb(20, 20, 20);
            
            guna2Button1.Text = "OK";
            guna2Button1.Click += guna2Button1_Click;

            // 3. Xử lý Icon (PictureBox thường) và Tự động xuống dòng
            if (icon != null)
            {
                picIcon.Image = icon;
                picIcon.Visible = true;
                
                // Điều chỉnh vị trí Label để nội dung bắt đầu sau Icon
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
            
            // Tính toán lại chiều cao Label để xuống dòng (Yêu cầu label1.AutoSize = False)
            label1.Height = TextRenderer.MeasureText(label1.Text, label1.Font, new Size(label1.Width, 0), TextFormatFlags.WordBreak).Height;
        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        
        // (Bạn có thể giữ hoặc xóa hàm Load nếu không cần)
        private void CustomNotificationForm_Load(object sender, EventArgs e)
        {
            
        }
    }
}
