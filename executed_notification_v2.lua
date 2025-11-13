using System;
using System.Drawing;
using System.Windows.Forms;
// Đã loại bỏ using System.Web.UI.WebControls; vì không cần thiết trong WinForms
using System.Text; 
using System.Threading.Tasks;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Collections.Generic;

namespace Purium
{
    // form co kich thuoc la 273, 160
    public partial class CustomNotificationForm : Form
    {
        public CustomNotificationForm(string message, string title)
        {
            InitializeComponent();
            
            // --- Cài đặt Form ---
            this.Size = new Size(273, 160); // Thiết lập kích thước Form
            this.FormBorderStyle = FormBorderStyle.None;
            this.ControlBox = false;
            this.StartPosition = FormStartPosition.CenterScreen;

            // --- Cài đặt label2 (Title) ---
            label2.Text = title;
            
            // --- Cài đặt label1 (Message) ---
            label1.Text = message;
            label1.ForeColor = Color.White;
            label1.BackColor = Color.FromArgb(20, 20, 20);
            
            // Dòng code KHẮC PHỤC Word Wrap: Tắt AutoSize
            // Điều này buộc Label phải sử dụng chiều rộng cố định (label1.Width)
            // và kích hoạt tự động xuống dòng.
            label1.AutoSize = false; 

            // Giả định thiết lập chiều rộng cố định cho label1
            // (Bạn nên đảm bảo giá trị này được đặt trong Designer hoặc ở đây)
            // Ví dụ: label1.Width = 250; 
            
            // Điều chỉnh chiều cao: Tính toán chiều cao cần thiết 
            // sau khi văn bản đã được Word Break
            label1.Height = TextRenderer.MeasureText(
                label1.Text, 
                label1.Font, 
                new Size(label1.Width, 0), 
                TextFormatFlags.WordBreak
            ).Height;

            // --- Cài đặt Button ---
            guna2Button1.Text = "OK";
            guna2Button1.Click += guna2Button1_Click;
        }

        public static class CustomNotifier
        {
            public static void Show(string message, string title = "Thông báo Tùy chỉnh")
            {
                CustomNotificationForm notification = new CustomNotificationForm(message, title);
                notification.ShowDialog();
            }
        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
