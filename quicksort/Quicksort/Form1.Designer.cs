namespace Quicksort
{
   partial class Form1
   {
      /// <summary>
      ///  Required designer variable.
      /// </summary>
      private System.ComponentModel.IContainer components = null;

      /// <summary>
      ///  Clean up any resources being used.
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
      ///  Required method for Designer support - do not modify
      ///  the contents of this method with the code editor.
      /// </summary>
      private void InitializeComponent()
      {
         buttonGenerate = new Button();
         comboBoxProgrammingLanguage = new ComboBox();
         labelThreads = new Label();
         textBoxThreads = new TextBox();
         buttonSort = new Button();
         labelTimeCs = new Label();
         labelMillisecondsCs = new Label();
         progressBar = new ProgressBar();
         label1 = new Label();
         labelMillisecondsCpp = new Label();
         label3 = new Label();
         labelMillisecondsAsm = new Label();
         SuspendLayout();
         // 
         // buttonGenerate
         // 
         buttonGenerate.Font = new Font("Segoe UI", 9.75F, FontStyle.Regular, GraphicsUnit.Point, 238);
         buttonGenerate.Location = new Point(12, 12);
         buttonGenerate.Name = "buttonGenerate";
         buttonGenerate.Size = new Size(108, 47);
         buttonGenerate.TabIndex = 0;
         buttonGenerate.Text = "Generuj pliki wejściowe";
         buttonGenerate.UseVisualStyleBackColor = true;
         buttonGenerate.Click += buttonGenerate_Click;
         // 
         // comboBoxProgrammingLanguage
         // 
         comboBoxProgrammingLanguage.FormattingEnabled = true;
         comboBoxProgrammingLanguage.Items.AddRange(new object[] { "C#", "C++", "Assembler" });
         comboBoxProgrammingLanguage.Location = new Point(12, 65);
         comboBoxProgrammingLanguage.Name = "comboBoxProgrammingLanguage";
         comboBoxProgrammingLanguage.Size = new Size(108, 23);
         comboBoxProgrammingLanguage.TabIndex = 1;
         // 
         // labelThreads
         // 
         labelThreads.AutoSize = true;
         labelThreads.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 238);
         labelThreads.Location = new Point(12, 91);
         labelThreads.Name = "labelThreads";
         labelThreads.Size = new Size(49, 21);
         labelThreads.TabIndex = 2;
         labelThreads.Text = "Wątki";
         // 
         // textBoxThreads
         // 
         textBoxThreads.Location = new Point(67, 89);
         textBoxThreads.Name = "textBoxThreads";
         textBoxThreads.Size = new Size(53, 23);
         textBoxThreads.TabIndex = 3;
         // 
         // buttonSort
         // 
         buttonSort.Font = new Font("Segoe UI", 9.75F, FontStyle.Regular, GraphicsUnit.Point, 238);
         buttonSort.Location = new Point(12, 118);
         buttonSort.Name = "buttonSort";
         buttonSort.Size = new Size(108, 47);
         buttonSort.TabIndex = 4;
         buttonSort.Text = "Sortuj";
         buttonSort.UseVisualStyleBackColor = true;
         buttonSort.Click += buttonSort_Click;
         // 
         // labelTimeCs
         // 
         labelTimeCs.AutoSize = true;
         labelTimeCs.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 238);
         labelTimeCs.Location = new Point(12, 187);
         labelTimeCs.Name = "labelTimeCs";
         labelTimeCs.Size = new Size(173, 21);
         labelTimeCs.TabIndex = 5;
         labelTimeCs.Text = "Czas przetwarzania C#: ";
         // 
         // labelMillisecondsCs
         // 
         labelMillisecondsCs.AutoSize = true;
         labelMillisecondsCs.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 238);
         labelMillisecondsCs.Location = new Point(191, 187);
         labelMillisecondsCs.Name = "labelMillisecondsCs";
         labelMillisecondsCs.Size = new Size(31, 21);
         labelMillisecondsCs.TabIndex = 6;
         labelMillisecondsCs.Text = "0.0";
         // 
         // progressBar
         // 
         progressBar.Location = new Point(12, 171);
         progressBar.Name = "progressBar";
         progressBar.Size = new Size(187, 13);
         progressBar.TabIndex = 7;
         // 
         // label1
         // 
         label1.AutoSize = true;
         label1.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 238);
         label1.Location = new Point(12, 208);
         label1.Name = "label1";
         label1.Size = new Size(186, 21);
         label1.TabIndex = 8;
         label1.Text = "Czas przetwarzania C++: ";
         // 
         // labelMillisecondsCpp
         // 
         labelMillisecondsCpp.AutoSize = true;
         labelMillisecondsCpp.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 238);
         labelMillisecondsCpp.Location = new Point(191, 208);
         labelMillisecondsCpp.Name = "labelMillisecondsCpp";
         labelMillisecondsCpp.Size = new Size(31, 21);
         labelMillisecondsCpp.TabIndex = 9;
         labelMillisecondsCpp.Text = "0.0";
         // 
         // label3
         // 
         label3.AutoSize = true;
         label3.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 238);
         label3.Location = new Point(12, 229);
         label3.Name = "label3";
         label3.Size = new Size(185, 21);
         label3.TabIndex = 10;
         label3.Text = "Czas przetwarzania Asm: ";
         // 
         // labelMillisecondsAsm
         // 
         labelMillisecondsAsm.AutoSize = true;
         labelMillisecondsAsm.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 238);
         labelMillisecondsAsm.Location = new Point(191, 229);
         labelMillisecondsAsm.Name = "labelMillisecondsAsm";
         labelMillisecondsAsm.Size = new Size(31, 21);
         labelMillisecondsAsm.TabIndex = 11;
         labelMillisecondsAsm.Text = "0.0";
         // 
         // Form1
         // 
         AutoScaleDimensions = new SizeF(7F, 15F);
         AutoScaleMode = AutoScaleMode.Font;
         ClientSize = new Size(296, 273);
         Controls.Add(labelMillisecondsAsm);
         Controls.Add(label3);
         Controls.Add(labelMillisecondsCpp);
         Controls.Add(label1);
         Controls.Add(progressBar);
         Controls.Add(labelMillisecondsCs);
         Controls.Add(labelTimeCs);
         Controls.Add(buttonSort);
         Controls.Add(textBoxThreads);
         Controls.Add(labelThreads);
         Controls.Add(comboBoxProgrammingLanguage);
         Controls.Add(buttonGenerate);
         Name = "Form1";
         Text = "Quicksort";
         Load += Form1_Load;
         ResumeLayout(false);
         PerformLayout();
      }

      #endregion

      private Button buttonGenerate;
      private ComboBox comboBoxProgrammingLanguage;
      private Label labelThreads;
      private TextBox textBoxThreads;
      private Button buttonSort;
      private Label labelTimeCs;
      private Label labelMillisecondsCs;
      private ProgressBar progressBar;
      private Label label1;
      private Label labelMillisecondsCpp;
      private Label label3;
      private Label labelMillisecondsAsm;
   }
}
