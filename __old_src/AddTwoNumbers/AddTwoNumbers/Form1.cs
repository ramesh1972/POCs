using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AddTwoNumbers
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            // get the 2 numbers from text boxes
            int num1 = Convert.ToInt32(tbNumber1.Text);
            int num2 = Convert.ToInt32(tbNumber2.Text);

            // add them
            int result = num1 + num2;

            // set in the result label
            lblResult.Text = result.ToString();
        }
    }
}
