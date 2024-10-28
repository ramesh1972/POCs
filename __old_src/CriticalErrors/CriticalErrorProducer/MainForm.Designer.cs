namespace CriticalErrorProducer
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this._btnObjectDisposed = new System.Windows.Forms.Button();
            this._btnDivideByZero = new System.Windows.Forms.Button();
            this._browser = new System.Windows.Forms.WebBrowser();
            this.label1 = new System.Windows.Forms.Label();
            this._btnForward = new System.Windows.Forms.Button();
            this._btnBack = new System.Windows.Forms.Button();
            this._btnLocalLog = new System.Windows.Forms.Button();
            this._openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.SuspendLayout();
            // 
            // _btnObjectDisposed
            // 
            this._btnObjectDisposed.Location = new System.Drawing.Point(13, 12);
            this._btnObjectDisposed.Name = "_btnObjectDisposed";
            this._btnObjectDisposed.Size = new System.Drawing.Size(147, 23);
            this._btnObjectDisposed.TabIndex = 0;
            this._btnObjectDisposed.Text = "&ObjectDisposedException";
            this._btnObjectDisposed.UseVisualStyleBackColor = true;
            this._btnObjectDisposed.Click += new System.EventHandler(this._btnObjectDisposed_Click);
            // 
            // _btnDivideByZero
            // 
            this._btnDivideByZero.Location = new System.Drawing.Point(166, 12);
            this._btnDivideByZero.Name = "_btnDivideByZero";
            this._btnDivideByZero.Size = new System.Drawing.Size(135, 23);
            this._btnDivideByZero.TabIndex = 1;
            this._btnDivideByZero.Text = "&DivideByZeroException";
            this._btnDivideByZero.UseVisualStyleBackColor = true;
            this._btnDivideByZero.Click += new System.EventHandler(this._btnDivideByZero_Click);
            // 
            // _browser
            // 
            this._browser.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._browser.Location = new System.Drawing.Point(13, 82);
            this._browser.MinimumSize = new System.Drawing.Size(20, 20);
            this._browser.Name = "_browser";
            this._browser.Size = new System.Drawing.Size(603, 258);
            this._browser.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial Unicode MS", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 49);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(169, 21);
            this.label1.TabIndex = 3;
            this.label1.Text = "Critical Error Report";
            // 
            // _btnForward
            // 
            this._btnForward.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this._btnForward.FlatAppearance.BorderSize = 0;
            this._btnForward.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this._btnForward.Image = global::CriticalErrorProducer.Properties.Resources.Forward;
            this._btnForward.Location = new System.Drawing.Point(585, 49);
            this._btnForward.Name = "_btnForward";
            this._btnForward.Size = new System.Drawing.Size(31, 27);
            this._btnForward.TabIndex = 5;
            this._btnForward.UseVisualStyleBackColor = true;
            this._btnForward.Click += new System.EventHandler(this._btnForward_Click);
            // 
            // _btnBack
            // 
            this._btnBack.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this._btnBack.FlatAppearance.BorderSize = 0;
            this._btnBack.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this._btnBack.Image = global::CriticalErrorProducer.Properties.Resources.Back;
            this._btnBack.Location = new System.Drawing.Point(541, 49);
            this._btnBack.Name = "_btnBack";
            this._btnBack.Size = new System.Drawing.Size(31, 27);
            this._btnBack.TabIndex = 4;
            this._btnBack.UseVisualStyleBackColor = true;
            this._btnBack.Click += new System.EventHandler(this._btnBack_Click);
            // 
            // _btnLocalLog
            // 
            this._btnLocalLog.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this._btnLocalLog.Location = new System.Drawing.Point(511, 12);
            this._btnLocalLog.Name = "_btnLocalLog";
            this._btnLocalLog.Size = new System.Drawing.Size(105, 23);
            this._btnLocalLog.TabIndex = 6;
            this._btnLocalLog.Text = "&Show Local Log";
            this._btnLocalLog.UseVisualStyleBackColor = true;
            this._btnLocalLog.Click += new System.EventHandler(this._btnLocalLog_Click);
            // 
            // _openFileDialog
            // 
            this._openFileDialog.DefaultExt = "xml";
            this._openFileDialog.FileName = "IssueLog.xml";
            this._openFileDialog.Filter = "Log Files|*.xml";
            this._openFileDialog.Title = "Select Log File";
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(628, 352);
            this.Controls.Add(this._btnLocalLog);
            this.Controls.Add(this._btnForward);
            this.Controls.Add(this._btnBack);
            this.Controls.Add(this.label1);
            this.Controls.Add(this._browser);
            this.Controls.Add(this._btnDivideByZero);
            this.Controls.Add(this._btnObjectDisposed);
            this.Name = "MainForm";
            this.Text = "Critical Error Producer application";
            this.Load += new System.EventHandler(this.Main_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button _btnObjectDisposed;
        private System.Windows.Forms.Button _btnDivideByZero;
        private System.Windows.Forms.WebBrowser _browser;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button _btnBack;
        private System.Windows.Forms.Button _btnForward;
        private System.Windows.Forms.Button _btnLocalLog;
        private System.Windows.Forms.OpenFileDialog _openFileDialog;
    }
}

